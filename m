From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 22:13:44 +0100
Message-ID: <200812202213.45029.markus.heidelberg@web.de>
References: <200812191314.19302.markus.heidelberg@web.de> <200812201418.38707.markus.heidelberg@web.de> <7v3agiy5gs.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 22:15:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE9A6-0002hZ-LT
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 22:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYLTVNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 16:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbYLTVNo
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 16:13:44 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:42743 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYLTVNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 16:13:43 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 49870FAD1885;
	Sat, 20 Dec 2008 22:13:42 +0100 (CET)
Received: from [91.19.0.168] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LE98o-0007VJ-00; Sat, 20 Dec 2008 22:13:42 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7v3agiy5gs.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+6zEbjVMcQL4rL3z/V/7Ot0SiYF7Ju0PXBOUGc
	1wRb/umQDIeOoGS0FuT0SEM9scCRdkkXHxYrUg0l8wbFqCL/I5
	dCkjeNbdg0uhINY6n7JQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103667>

Junio C Hamano, 20.12.2008:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > Junio C Hamano, 20.12.2008:
> >> Markus Heidelberg <markus.heidelberg@web.de> writes:
> >> 
> >> > @@ -172,7 +172,7 @@ only the primary branches.  In addition, if you happen to be on
> >> >  your topic branch, it is shown as well.
> >> >  
> >> >  ------------
> >> > -$ git show-branch --reflog='10,1 hour ago' --list master
> >> > +$ git show-branch --reflog="10,1 hour ago" --list master
> >> >  ------------
> >> 
> >> Is this just a personal taste, or a correction to typography?
> >
> > When using single quotes, the manpage displayed backticks.
> 
> It does not seem to do that to me:
> 
>     $ git help show-branch | grep 10,1 | od -bc
>     0000040 146 154 157 147 075 342 200 231 061 060 054 061 040 150 157 165
>               f   l   o   g   = 342 200 231   1   0   ,   1       h   o   u

I get this instead:
      0000040 145 146 154 157 147 075 302 264 061 060 054 061 040 150 157 165
                e   f   l   o   g   = 302 264   1   0   ,   1       h   o   u

> It does not use ASCII single quote ' (\047) but the result still does
> render well enough to keep anybody who are typing, following the printed
> examples, from mistaking it from a backquote:
> 
>     http://pics.livejournal.com/gitster/pic/00009pk0/g6

Yes, I was wrong, it wasn't a backtick.
