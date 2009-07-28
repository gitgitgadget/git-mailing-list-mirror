From: Frans Pop <elendil@planet.nl>
Subject: Re: Add option in git-am to ignore leading text?
Date: Tue, 28 Jul 2009 21:11:13 +0200
Message-ID: <200907282111.14404.elendil@planet.nl>
References: <200907280513.59374.elendil@planet.nl> <200907281938.24960.elendil@planet.nl> <20090728181524.GC16168@vidovic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVs59-0000Ml-RH
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 21:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZG1TLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZG1TLQ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 15:11:16 -0400
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:65075 "EHLO
	CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751406AbZG1TLP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 15:11:15 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML101.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 21:11:14 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090728181524.GC16168@vidovic>
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 19:11:14.0691 (UTC) FILETIME=[2D4CA530:01CA0FB7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124269>

On Tuesday 28 July 2009, Nicolas Sebrecht wrote:
> > Here are some other examples (some of which would equally need to
> > drop or change a separator line).
> > http://lkml.org/lkml/2009/6/25/62
> Uses "From:", "Date:", and "Subject:".
>
> > http://lkml.org/lkml/2009/6/22/114
> Uses "From:" and "Subject:".
>
> > http://lkml.org/lkml/2009/6/30/109
> Uses "Subject:" only.
>
> I guess there are as results as contributors but it could be possible
> to add some rules to the format. This could ending up with an unuseable
> feature in practice, though. I don't know.

My proposal was "when it encounters _either_ a From: _or_ a Subject: 
pseudo header" which would work for all examples. But I fully agree with 
you that some rules are needed.
Whether to do the same on Date: is less obvious, but I doubt that would 
ever be seen without at least one of the others (and the rules could 
specify that).

> > http://lkml.org/lkml/2009/6/30/224
> Broken link ?

Works for me, just slow.

> > And I've also seen plenty of cases where quoted lines _were_ a
> > desired part of a commit log.
>
> Yes, that's why it's an _option_.

IMHO it does not add much. My proposal would be more generic exactly 
because it defines the pseudo headers as a natural separator between 
introduction and the part of the mail git-am should act on.
