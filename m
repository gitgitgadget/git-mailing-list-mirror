From: sean <seanlkml@sympatico.ca>
Subject: Re: Problem with git bisect between 2.6.15 and 2.6.16
Date: Mon, 27 Mar 2006 19:06:27 -0500
Message-ID: <BAYC1-PASMTP036F0DBE8F7101BCAD5470AED30@CEZ.ICE>
References: <0e7301c651fa$9e0fd770$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 02:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1ll-00051K-JK
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWC1AJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWC1AJG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:09:06 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:6830 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932137AbWC1AJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 19:09:05 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 27 Mar 2006 16:09:04 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 7D5ED644C28;
	Mon, 27 Mar 2006 19:09:03 -0500 (EST)
To: "Greg Lee" <glee@casabyte.com>
Message-Id: <20060327190627.7d72794f.seanlkml@sympatico.ca>
In-Reply-To: <0e7301c651fa$9e0fd770$a100a8c0@casabyte.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Mar 2006 00:09:04.0438 (UTC) FILETIME=[D2F26560:01C651FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Mar 2006 19:00:25 -0500
"Greg Lee" <glee@casabyte.com> wrote:

> I get the following when I try to git bisect between 2.6.15 and 2.6.16:
>  
> [root@Fedora-test tmp]# git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-git
> [root@Fedora-test linux-git]# git bisect start
> [root@Fedora-test linux-git]# cd linux-git
> [root@Fedora-test linux-git]# git bisect good v2.6.16
> [root@Fedora-test linux-git]# git bisect bad v2.6.15
> dab47a31f42a23d2b374e1cd7d0b797e8e08b23d was both good and bad
> 
> What is the proper method to do a bisect between 2.6.15 and 2.6.16?
> 

You need to do the bisect start after you cd into the linux-git 
directory.   Also, it appears you have the good and bad reversed,
presumably the newer (v2.6.16) is bad, and the older (v.2.6.15)
is good.

Sean
