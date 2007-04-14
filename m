From: Rene Herman <rene.herman@gmail.com>
Subject: GIT and the current -stable
Date: Sat, 14 Apr 2007 07:36:02 +0200
Message-ID: <46206842.80203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161024AbXDNFh2@vger.kernel.org Sat Apr 14 07:37:58 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161024AbXDNFh2@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcaxP-0004lg-HO
	for glk-linux-kernel-3@gmane.org; Sat, 14 Apr 2007 07:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbXDNFh2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 14 Apr 2007 01:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbXDNFh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Apr 2007 01:37:28 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:51568 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161024AbXDNFh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Apr 2007 01:37:27 -0400
Received: from [213.51.130.189] (port=41451 helo=smtp2.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hcawv-0005dg-IR; Sat, 14 Apr 2007 07:37:25 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:47290 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hcawt-0005uj-RP; Sat, 14 Apr 2007 07:37:23 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44443>

Good day.

Stumbling around with git here. I'd like to use git to efficiently track the 
  current -stable as well as -current. Say, my local tree is a clone of 
Linus current:

git clone \ 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git local

I then branch off a 2.6.20 branch:

cd local
git checkout -b v2.6.20 v2.6.20

to now update to the current -stable I could do:

git pull \ 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git

each time that a new -stable is released. Rather though, I'd like a simple 
"git pull" to do this while on this branch while a "git pull" while back on 
the master branch pulls from the originally cloned Linus repo again.

Is this possible? Do I want it to be? Comments like "work like this instead" 
welcome as well; figuring out what the heck it is that I want from git seems 
to be one of the most difficult questions to answer...

Currently using git 1.5.0.4.

Rene.
