From: Junio C Hamano <junkio@cox.net>
Subject: Re: Sharing repositories later on
Date: Wed, 12 Jul 2006 08:21:28 -0700
Message-ID: <7vpsgazw5j.fsf@assigned-by-dhcp.cox.net>
References: <20060712132800.GA7328@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 17:22:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0gWv-0006fH-8N
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 17:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWGLPVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 11:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWGLPVd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 11:21:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2756 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751406AbWGLPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 11:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712152131.GYQP18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 11:21:31 -0400
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060712132800.GA7328@harddisk-recovery.com> (Erik Mouw's
	message of "Wed, 12 Jul 2006 15:28:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> Hi,
>
> I just learned out about "git clone -s" to share objects between
> repositories. How do I use that with already existing repositories?
>
> Right now I have a "linux-2.6" repository to track Linus's 2.6 kernel
> tree and an "elinux-2.6" tree that pulls from linux-2.6 and holds my
> own changes. I created a file .git/objects/info/alternates that
> contains the line "/home/erik/git/linux-2.6/.git/objects". Now how do I
> get rid of the "old" objects and packs without loosing my changes?

repack -a -d -l perhaps?
