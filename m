From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sun, 27 Jul 2008 21:24:00 +0200
Message-ID: <1217186640.488ccb50a934a@webmail.nextra.at>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <1217104655.488b8b0f5ca48@webmail.nextra.at> <4CCD1862-48FB-412B-80B6-E1B822BF3A87@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 21:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNBre-0004tz-CJ
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 21:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbYG0TYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbYG0TYF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 15:24:05 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:51011 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757545AbYG0TYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 15:24:04 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp3.srv.eunet.at (Postfix) with ESMTPS id 03A9F10A841;
	Sun, 27 Jul 2008 21:24:01 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6RJO0o5014621;
	Sun, 27 Jul 2008 21:24:00 +0200
Received: from 77.118.56.245 ([77.118.56.245]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sun, 27 Jul 2008 21:24:00 +0200
In-Reply-To: <4CCD1862-48FB-412B-80B6-E1B822BF3A87@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.118.56.245
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90359>

Zitat von Steffen Prohaska <prohaska@zib.de>:

>
> On Jul 26, 2008, at 10:37 PM, Johannes Sixt wrote:
>
> > Zitat von Steffen Prohaska <prohaska@zib.de>:
> >> With MinGW's
> >>
> >>   gcc.exe (GCC) 3.4.5 (mingw special)
> >>   GNU ld version 2.17.50 20060824
> >>
> >> the old define caused link errors:
> >>
> >>   git.o: In function `main':
> >>   C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
> >>   collect2: ld returned 1 exit status
> >>
> >> The modified define works.
> >
> > I have the same tools, but not this error. ???
>
> I cleaned my work tree and built several times but did not
> find out what exactly is causing the error.  So I came up
> with the modified define, which declares the static
> mingw_main in global scope.  I have no clue why I see the
> error that you don't have.

Neither do I. But a strange line number you have there. In 01d9b2d (from
mingw.git) I have 'exit(1)' in line 500 of git.c.

-- Hannes
