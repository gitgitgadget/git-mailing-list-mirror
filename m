From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 9 Nov 2007 17:05:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091702190.4362@racer.site>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1102319673-1194627917=:4362"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXIh-0005nG-7q
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXKIRFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXKIRFb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:05:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:49242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750842AbXKIRFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:05:30 -0500
Received: (qmail invoked by alias); 09 Nov 2007 17:05:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 09 Nov 2007 18:05:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19c/XpFF/VcjUfZetj27sBQJLEz95OpjFasBJ+i/P
	aZJ+1BQNmKC2Vj
X-X-Sender: gene099@racer.site
In-Reply-To: <1194626427-2419-1-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64220>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1102319673-1194627917=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 9 Nov 2007, Kristian Høgsberg wrote:

> This fixes the race in the last test int t3700.

Well, it is not a race.  My fault.  I thought it was.

What you basically did was to make sure that the index is up-to-date after 
adding the files.  You might even want to say that in the commit message, 
and only then say that it fixes t3700, too.

Thanks,
Dscho

--8323584-1102319673-1194627917=:4362--
