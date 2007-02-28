From: "Stefano Spinucci" <virgo977virgo@gmail.com>
Subject: Re: using the same repo with different OS
Date: Wed, 28 Feb 2007 19:06:29 +0100
Message-ID: <906f26060702281006l794173e8uea0f7174dd712e32@mail.gmail.com>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
	 <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTCN-0004Am-KG
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbXB1SGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXB1SGe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:06:34 -0500
Received: from ik-out-1112.google.com ([66.249.90.176]:37830 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbXB1SGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:06:33 -0500
Received: by ik-out-1112.google.com with SMTP id c21so136646ika
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:06:31 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S/viOZgMwKa1TaLnZ6vo9Ay+jUfx/STVGtv4Kl4iWp3XEtotqBy75k74bp+iHuPcXyvT/JQXGB9ec3ob776OnErTPKYPdm3NTjf6rgJb2vswsqgzpKa9zaHXBk7AtS1qcJNjWJKNpOHmxINQz9e2crDmX7kK5XPqn3TlBSah1r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/Tkt/TZ/jphGwuoGyS1cV37KoHmXviAn1yHcKBkyleQGos4n9pL7wfF9gvR/Rc9RfK61nwTuzGCYOdb6jw8scgtCHRPnOs5Cl2yaA7C0WxOc0qTp2Xkqf18KcBPXFXO3nqLfo61yE6xFxatGE2UJf3tJn6/W2exY8pQ5Is4tf0=
Received: by 10.115.76.1 with SMTP id d1mr107827wal.1172685989636;
        Wed, 28 Feb 2007 10:06:29 -0800 (PST)
Received: by 10.114.92.12 with HTTP; Wed, 28 Feb 2007 10:06:29 -0800 (PST)
In-Reply-To: <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40981>

I noticed today that my notes about compiling Git on cygwin to work
with FAT32 (export NO_MMAP=1) on the Wiki page WindowsInstall were
removed.

Than I'm asking how you'd setup repos to work on some linux/windows
machines, transferring data only with an USB disk.

* current repos scenario *
r1.linux -> on fat32
r2.windows -> on fat32

* proposed (better???) repos scenario *
r1.lin -> on ext3 (partition 1)
r1.lin -> on fat32 (partition 2) mirrored with rsync from linux
r2.win -> on fat32 (partition 2) mirrored with cwrsync from windows
r2.win -> on ntfs (partition 3)


bye, and thanks for the wonderful tool git is!

---
Stefano Spinucci
