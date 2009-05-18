From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Mon, 18 May 2009 21:40:29 +0200
Message-ID: <200905182140.29953.markus.heidelberg@web.de>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <200905181536.39508.johan@herland.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 18 21:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M68kw-0004cm-0M
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 21:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbZERToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 15:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZERToD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 15:44:03 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:47906 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZERToC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 15:44:02 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 16A83FF8194D;
	Mon, 18 May 2009 21:43:43 +0200 (CEST)
Received: from [89.59.74.55] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M68kQ-0004q6-00; Mon, 18 May 2009 21:43:42 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200905181536.39508.johan@herland.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18JIe5UVk+ht/lq/KPpkvfBxL+YhOLUGluuvi35
	xzdll/fdYeympYphxrAA5AmM4pNFWEY0BNMO1PCTrKfYg3G/42
	53AGAaPPVN5KrXvu+m+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119462>

Johan Herland, 18.05.2009:
> On Sunday 17 May 2009, Junio C Hamano wrote:
> > [Will merge to "master" soon]
> >
> > * ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit 
> >  + git-submodule: add support for --rebase.
> 
> [..]
> 
> Now, my question should not stop this feature from going into 'master', 
> except for the fact that if we also want to support merge, we should 
> rename the associated config variable:
> 
> Instead of
> 
>   submodule.<name>.rebase = true/false (false if unset)
> 
> we should have something like
> 
>   submodule.<name>.resolve = checkout/rebase/merge (checkout if unset)

At least this would be inconsistent with options like
branch.<name>.merge and branch.<name>.rebase

Markus
