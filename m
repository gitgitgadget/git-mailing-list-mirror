From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.6
Date: Sun, 19 Jun 2005 13:05:46 -0700 (PDT)
Message-ID: <20050619200547.68355.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: berkus@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 22:00:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk5xq-0001Ym-VV
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 22:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFSUF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 16:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVFSUF6
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 16:05:58 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:27254 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261290AbVFSUFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 16:05:53 -0400
Received: (qmail 68357 invoked by uid 60001); 19 Jun 2005 20:05:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aynVJZwoRoxhyp+CSk+C9AatsSGfXj/VTQ4uxjkEhygV2pK5CrUO8FHdZaJkaplrZl6p8pDJAbs2DDut8Z56SYwjlg3PFxg+bLag0i60Q7UJFYuEzeUg5UpF73SDWsuh842x/cZllQR3MjjBy2nGkcQ5LIXwSX1njoWJt//VvOQ=  ;
Received: from [151.38.101.189] by web26309.mail.ukl.yahoo.com via HTTP; Sun, 19 Jun 2005 13:05:46 PDT
To: Ingo Molnar <mingo@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar ha scritto:

>on FC4 the build is quite noisy. Not a big issue because it otherwise 
>builds and works fine:
>
>scons -Q
>/usr/lib/qt-3.3/bin/uic -o src/diffbase.h src/diffbase.ui
>/usr/lib/qt-3.3/bin/uic -impl diffbase.h -o src/uic_diffbase.cc src/diffbase.ui
>/usr/lib/qt-3.3/bin/moc -o src/moc_diffbase.cc src/diffbase.h
>QSettings: error creating /.qt
>QSettings: error creating /.qt
>QSettings: error creating /.qt

I have the same output from day one on my box too, but I am not so familiar with scons to be able
to fix it.
Peraphs someone (Stanislav?) can provide a fix?

Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
