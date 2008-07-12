From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 3/3 FIXED] help (Windows): Display HTML in default browser using Windows' shell API
Date: Sat, 12 Jul 2008 22:41:17 +0200
Message-ID: <1215895277.487916ed43464@webmail.nextra.at>
References: <228FC26D-D318-487A-9BF3-B473096CB0C9@zib.de> <1215761822-21356-1-git-send-email-prohaska@zib.de> <7vtzevhjf8.fsf@gitster.siamese.dyndns.org> <8D150442-8B57-4025-9110-BC4C23C2310C@zib.de> <7vskufy40c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 22:42:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHlvA-0001LL-Vj
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 22:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYGLUlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 16:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYGLUlW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 16:41:22 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:34515 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYGLUlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 16:41:21 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp4.srv.eunet.at (Postfix) with ESMTPS id BB82F979C4;
	Sat, 12 Jul 2008 22:41:19 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6CKfHVs013478;
	Sat, 12 Jul 2008 22:41:18 +0200
Received: from 77.117.179.246 ([77.117.179.246]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sat, 12 Jul 2008 22:41:17 +0200
In-Reply-To: <7vskufy40c.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.179.246
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88264>

Zitat von Junio C Hamano <gitster@pobox.com>:

> Steffen Prohaska <prohaska@zib.de> writes:
>
> >> Do you mean to have that printf() or is it a leftover debugging
> >> statement?
> >
> > I mean to have it.
>
> Ok, I was just checking.  Unless other Windows users complain, will apply
> as-is.  As you might guess, I am completely neutral on this one.

I'm working on followups to this series, and it turns out to be more
convenient to have system_path() in exec_cmd.c instead of path.c.
It'll make sense if I resend the series with an updated version of 1/3
(instead of a patch that merely moves the function around).

-- Hannes
