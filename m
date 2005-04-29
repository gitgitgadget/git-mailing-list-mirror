From: Russell King <rmk@arm.linux.org.uk>
Subject: More problems...
Date: Fri, 29 Apr 2005 17:01:27 +0100
Message-ID: <20050429170127.A30010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 18:04:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXyX-0007LI-1i
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 18:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVD2QHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVD2QFF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 12:05:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49170 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262309AbVD2QBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 12:01:31 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRXvl-0004be-80
	for git@vger.kernel.org; Fri, 29 Apr 2005 17:01:29 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DRXvj-0008CW-Ge
	for git@vger.kernel.org; Fri, 29 Apr 2005 17:01:27 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok.  cogito-0.8.

rmk@dyn-67:[linux-2.6-rmk]:<1049> cg-update origin
`../linux-2.6/.git/refs/heads/master' -> `.git/refs/heads/origin'
`../linux-2.6/.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901' -> `.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901'
cp: cannot create link `.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901': File exists
`../linux-2.6/.git/objects/01/ca31cc7bfdd18d6f72288915021730442f386d' -> `.git/objects/01/ca31cc7bfdd18d6f72288915021730442f386d'
cp: cannot create link `.git/objects/01/ca31cc7bfdd18d6f72288915021730442f386d': File exists
`../linux-2.6/.git/objects/04/17820d15efac837a84f9ade46f56339016a282' -> `.git/objects/04/17820d15efac837a84f9ade46f56339016a282'
cp: cannot create link `.git/objects/04/17820d15efac837a84f9ade46f56339016a282': File exists
`../linux-2.6/.git/objects/07/da010b67d4d715b5e97dfb824eb70433776a20' -> `.git/objects/07/da010b67d4d715b5e97dfb824eb70433776a20'
cp: cannot create link `.git/objects/07/da010b67d4d715b5e97dfb824eb70433776a20': File exists
`../linux-2.6/.git/objects/07/5d3961a119e8f27294cd77193f8fee7908a521' -> `.git/objects/07/5d3961a119e8f27294cd77193f8fee7908a521'
...
cp: cannot create link `.git/objects/fc/1428905472a61e8e51057a4237acab5d8594d8': File exists
`../linux-2.6/.git/objects/fc/373c483e62dc1bbc5c3915f2d3c795fb316ec5' -> `.git/objects/fc/373c483e62dc1bbc5c3915f2d3c795fb316ec5'
cp: cannot create link `.git/objects/fc/373c483e62dc1bbc5c3915f2d3c795fb316ec5': File exists
`../linux-2.6/.git/objects/ff/c3be3dff7e20e2ad5367fa8d6d0d2f0baa8a24' -> `.git/objects/ff/c3be3dff7e20e2ad5367fa8d6d0d2f0baa8a24'
cp: cannot create link `.git/objects/ff/c3be3dff7e20e2ad5367fa8d6d0d2f0baa8a24': File exists
`../linux-2.6/.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783' -> `.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783'
cp: cannot create link `.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783': File exists
cg-pull: rsync error

rmk@dyn-67:[linux-2.6-rmk]:<1052> md5sum .git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783 ../linux-2.6/.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783
194b70d0eed786807e14e97dd0a5ad8d  .git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783
194b70d0eed786807e14e97dd0a5ad8d  ../linux-2.6/.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783
rmk@dyn-67:[linux-2.6-rmk]:<1053> vdir .git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783 ../linux-2.6/.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783
-rw-rw-r--  1 rmk rmk 3070 Apr 28 10:43 .git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783
-rw-r--r--  1 rmk rmk 3070 Apr 29 16:50 ../linux-2.6/.git/objects/ff/8b49966a9f6ed23f6489bb986de87a14d4b783

What seems to be happening is that I create changes in my tree, rsync
them out to kernel.org.  Linus pulls them into his tree.  I pull them
back into my reference tree, and then try and update my working tree.

By that time, the object files in the reference tree appear to have
a newer timestamp than the corresponding ones in my local tree, and
cp -lua fails.

Which means cogito fails to work for me...  Help.

-- 
Russell King

