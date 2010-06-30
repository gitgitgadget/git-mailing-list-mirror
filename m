From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Wed, 30 Jun 2010 23:16:20 +0200
Message-ID: <m2d3v8b4rf.fsf@igel.home>
References: <4C226520.5080009@ramsay1.demon.co.uk>
	<20100623210820.GA24242@burratino>
	<4C264019.6030408@ramsay1.demon.co.uk>
	<20100626181945.GA13070@burratino>
	<4C2B9DA7.9000902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Peter Harris <git@peter.is-a-geek.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 30 23:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU4dy-0001Uy-5D
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 23:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab0F3VQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 17:16:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37705 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab0F3VQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 17:16:23 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 1B8F21C15990;
	Wed, 30 Jun 2010 23:16:21 +0200 (CEST)
Received: from igel.home (ppp-88-217-123-23.dynamic.mnet-online.de [88.217.123.23])
	by mail.mnet-online.de (Postfix) with ESMTP id 0BCEA1C00353;
	Wed, 30 Jun 2010 23:16:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A1514CA297; Wed, 30 Jun 2010 23:16:20 +0200 (CEST)
X-Yow: LOOK!!!  I'm WALKING in my SLEEP again!!
In-Reply-To: <4C2B9DA7.9000902@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Wed, 30 Jun 2010 20:40:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149997>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Hmmm, the output from gcc 4.4.0 adds a line like:
>     COLLECT_GCC_OPTIONS='-v' '-g' '-O2' '-o' 'hello.exe' '-mtune=i386'
> so, does this imply this is a env. var exported to collect2?

This is needed for the case that the linker needs to rerun the compiler.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
