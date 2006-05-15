From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Add "--summary" option to git diff.
Date: Sun, 14 May 2006 20:54:42 -0400
Message-ID: <BAYC1-PASMTP02640E2C9813E4DA1E778BAEA30@CEZ.ICE>
References: <BAYC1-PASMTP0770FC4238970CB812C192AEA20@CEZ.ICE>
	<7v3bfcno2b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon May 15 03:00:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfRRY-0007Ma-RM
	for gcvg-git@gmane.org; Mon, 15 May 2006 03:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWEOBAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 21:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWEOBAL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 21:00:11 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:33531 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751389AbWEOBAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 21:00:10 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 May 2006 18:00:09 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id A3CE3644C28;
	Sun, 14 May 2006 21:00:08 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060514205442.5d671f27.seanlkml@sympatico.ca>
In-Reply-To: <7v3bfcno2b.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 May 2006 01:00:10.0008 (UTC) FILETIME=[E9FF4180:01C677BA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 14 May 2006 17:12:28 -0700
Junio C Hamano <junkio@cox.net> wrote:

> The next branch with this and other patches applied seems to
> misbehave.
> 
> It makes glibc unhappy with 
> 
> PAGER= ./git whatchanged -B -C --stat --summary --no-merges --diff-filter=RC

What's a bit more worrying is that:

$ PAGER= ./git whatchanged -B -C --stat --no-merges --diff-filter=RC

Causes the same problem on the current (1.3.2) release branch without any
other patches applied at all.

Sean
