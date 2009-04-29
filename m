From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Question on merge and mergetool settings
Date: Wed, 29 Apr 2009 22:00:11 +0200
Message-ID: <200904292200.11373.markus.heidelberg@web.de>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F2FE@EXCHANGE.trad.tradestation.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Dlugosz" <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzFz6-0006ob-0t
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbZD2UCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZD2UCN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:02:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42350 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbZD2UCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:02:12 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 61741FDFD189;
	Wed, 29 Apr 2009 22:02:12 +0200 (CEST)
Received: from [89.59.108.55] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LzFwy-00052k-00; Wed, 29 Apr 2009 22:00:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3F2FE@EXCHANGE.trad.tradestation.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117933>

John Dlugosz, 29.04.2009:
> In my config files which I inherited from someone else, there is an
> entry for "url" as well as for "path" under [merge] et al.

What is "et al." in this case? [mergetool]?

> I can't find that mentioned in the git-config manual.  Is that really
> used?

No.

There is remote.<name>.url, mergetool.<name>.path
There is no merge.url, merge.path, mergetool.<name>.url

Markus
