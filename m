From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Fix git-push --mirror also mirroring refs/remotes/
Date: Mon, 11 May 2009 00:15:06 +0200
Message-ID: <200905110015.06939.markus.heidelberg@web.de>
References: <1241984136-2578-1-git-send-email-bryan@shatow.net> <200905102313.13544.markus.heidelberg@web.de> <7vskjctyey.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bryan Drewery <bryan@shatow.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 00:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3HIj-0002Ml-MY
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 00:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbZEJWPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 18:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbZEJWPJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 18:15:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54135 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbZEJWPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 18:15:08 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4F23DFEB64E2;
	Mon, 11 May 2009 00:15:07 +0200 (CEST)
Received: from [89.59.125.79] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M3HIZ-00063R-00; Mon, 11 May 2009 00:15:07 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vskjctyey.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18JYvbnsu9UEGOsRAct8l9GPiimg26zMrfuifh4
	eIJbqhrSNywsdhPlmV9hIOFB/g1TN0/MQaayTwut/W6r4pO1/5
	pA7FBeE5MSlLCznXaEBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118753>

Junio C Hamano, 10.05.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > Bryan Drewery, 10.05.2009:
> >> This behavior makes no sense to me. Can we at least add a config option
> >> to make it not push remotes? I push my development repository
> >> to a remote private repository only as a backup, and push my master/next
> >> to a public repository. I see no reason to push my 8 remotes and
> >> all their branches to my backup repository.
> >
> > Why are you disturbed by the remotes, if it's only a backup repository
> > where you don't look into in the normal case?
> 
> I suspect you got a wrong "backup".
> 
> [...]
> 
> It would be a regression if you stop pushing the refs/remotes
> hierarchy, and such a proposal must be backed by an argument that says the
> benefit such a change brings in far outweighs the regression it causes.

I'm not sure if this is addressed to me, but I'm not for removing
refs/remotes from push --mirror, maybe I was a bit confusing above.

Markus
