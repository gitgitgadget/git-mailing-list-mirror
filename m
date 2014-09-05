From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCHv3 0/4] am: patch-format
Date: Fri,  5 Sep 2014 22:06:47 +1200
Message-ID: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 12:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPqQS-0005bN-RT
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 12:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbaIEKHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 06:07:16 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:50750 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbaIEKHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 06:07:14 -0400
Received: by mail-ig0-f169.google.com with SMTP id r2so32433igi.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xWKn7U5gO8CYynS4q1fy+6FeSv3vnxE0JitvsXjttKA=;
        b=1JJf+X2x85X1T55wGPMPCx3aWaCbwY+VMOUw3r++ghQBZv6CvHICjN+EMJsgd8DcBa
         N2NzeItLvB3HeI+ZwI25tUAEW5sbeqM9Q/3uzrIvTJDRaXlw05ihevWl7g+4UzAYPFVg
         UP00OeMp+j+J8hBUQzP1rLz6iUkN1XrjdeWRO4vx0q73w33d/S/I3SdLZbvZLFm1Z2pG
         wCB8ZWmonif2Ful5d32I5uSWfYBONfR7MZVg8JCJg0xyyexAKBQjxPYUZdvUZoDXfvlJ
         J7fC2SZJbWqA303fObP01+KLrNVATAK9qzx2wSpfAs7beA5xq4GCgl13tQl+F62GYQ9+
         Fi6w==
X-Received: by 10.66.221.193 with SMTP id qg1mr19902555pac.9.1409911632038;
        Fri, 05 Sep 2014 03:07:12 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id o2sm1348068pdk.87.2014.09.05.03.07.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 03:07:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256502>

I've re-ordered things in this round. Hopefully the first 3 patches are
uncontroversial, Junio has expressed reservations about the 4th. I
haven't looked at moving the changes into mailsplit yet or I could try
and update gitk to use something other than diff-tree or I could write
some external filter programs.

Chris Packham (4):
  am: avoid re-directing stdin twice
  t/am: add test for stgit patch format
  t/am: add tests for hg patch format
  am: add gitk patch format

 Documentation/git-am.txt |  3 +-
 git-am.sh                | 38 +++++++++++++++++++++++-
 t/t4150-am.sh            | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.1.0.64.gc343089
