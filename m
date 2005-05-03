From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: PATCH: diff-cache.c:51: `return' with a value, in function returning void
Date: Tue, 3 May 2005 23:44:34 +0200
Message-ID: <20050503214434.GA31958@steel.home>
References: <20050503195601.GA4165@steel.home> <7vmzrct2ot.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:41:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT56l-0007L8-EL
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVECVpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVECVo5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:44:57 -0400
Received: from mx4.valuehost.ru ([217.112.42.203]:3591 "HELO mx4.valuehost.ru")
	by vger.kernel.org with SMTP id S261812AbVECVor (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:44:47 -0400
Received: (qmail 24599 invoked by uid 89); 4 May 2005 01:44:37 +0400
Received: from unknown (HELO tigra.home) (fork0@delphiplus.org@84.160.253.121)
  by mx4.valuehost.ru with SMTP; 4 May 2005 01:44:37 +0400
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1DT5Bz-00060f-00; Tue, 03 May 2005 23:44:35 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1DT5By-0008JZ-G2; Tue, 03 May 2005 23:44:34 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzrct2ot.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Tue, May 03, 2005 23:33:22 +0200:
> >>>>> "AR" == Alex Riesen <fork0@users.sourceforge.net> writes:
> 
> AR> gcc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-cache diff-cache.c libgit.a -lz -lssl
> AR> diff-cache.c: In function `show_new_file':
> AR> diff-cache.c:51: warning: `return' with a value, in function returning void
> 
> This one was fixed in the Linus tree long time ago.
> 

Oh, sorry: it was cogito today.

