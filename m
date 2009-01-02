From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git-difftool
Date: Fri, 2 Jan 2009 01:13:31 +0100
Message-ID: <200901020113.32082.markus.heidelberg@web.de>
References: <20081226013021.GA15414@gmail.com> <402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com> <vpq8wpux61c.fsf@bauges.imag.fr>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 02 01:14:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXgY-0002Ak-DJ
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbZABANT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbZABANT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:13:19 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:50463 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZABANT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 19:13:19 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2A83AF87822E;
	Fri,  2 Jan 2009 01:13:16 +0100 (CET)
Received: from [89.59.70.163] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LIXfB-0008Ue-00; Fri, 02 Jan 2009 01:13:17 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <vpq8wpux61c.fsf@bauges.imag.fr>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18QRhFdebHdwDiZUyGrvp2lpMoghg6hcQ1uAdN3
	WQ/e8WFen7iCzGyNhvwnIi+S/UNpPsPuTkCtVAWipP25U3yxoH
	8aPms1TKkQoAN1k1GdhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104348>

Matthieu Moy, 01.01.2009:
> "David Aguilar" <davvid@gmail.com> writes:
> 
> > Hmm... in theory, yes, but in practice, no.
> > xxdiff is too gimp to handle what 'git diff' hands it =)
> 
> As done with "vimdiff" in another message, simply write a one-liner
> wrapper script that calls xxdiff $2 $3, and call this wrapper script.

This works with GUI tools, but not with console tools. GVim works, Vim
doesn't.
And invoking
    git difftool
is by far more convenient than
    GIT_EXTERNAL_DIFF=vimdiff git diff

Markus
