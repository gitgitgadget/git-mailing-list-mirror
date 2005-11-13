From: wa1ter@myrealbox.com
Subject: Re: [PATCH] Building git on NetBSD
Date: Sun, 13 Nov 2005 14:51:31 -0800
Organization: none
Message-ID: <Pine.NEB.4.63.0511131446500.4257@x9.ybpnyarg>
References: <Pine.LNX.4.64.0511120649430.2695@x2.ybpnyarg> <43760AF5.1010704@op5.se>
 <7vhdahclr5.fsf@assigned-by-dhcp.cox.net> <7vlkzsc262.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 14 00:02:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbQpd-0005nk-GO
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 00:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKMW7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 17:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVKMW7u
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 17:59:50 -0500
Received: from main.gmane.org ([80.91.229.2]:33768 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750788AbVKMW7t (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 17:59:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbQl5-0003K9-H7
	for git@vger.kernel.org; Sun, 13 Nov 2005 23:55:35 +0100
Received: from adsl-69-234-227-15.dsl.irvnca.pacbell.net ([69.234.227.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Nov 2005 23:55:35 +0100
Received: from wa1ter by adsl-69-234-227-15.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Nov 2005 23:55:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <7vlkzsc262.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11753>

On Sun, 13 Nov 2005, Junio C Hamano wrote:

> Date: Sun, 13 Nov 2005 01:44:37 -0800
> From: Junio C Hamano <junkio@cox.net>
> Cc: git@vger.kernel.org
> Newsgroups: gmane.comp.version-control.git
> Subject: Re: [PATCH] Building git on NetBSD
>
> Junio C Hamano <junkio@cox.net> writes:
>

> > Very well.  Maybe LDFLAGS and ALL_LDFLAGS pair to parallel
> > CFLAGS and ALL_CFLAGS (the former is for the end user to
> > override from make command line, the latter is for Makefile to
> > augment and use)?
>
> Does this look OK?

<patch snipped>

Yes, git now compiles on NetBSD without modification and with no
warnings about unused linker flags.  Thanks!
