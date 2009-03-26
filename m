From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: git fsk is reporting problems that don't exist
Date: Thu, 26 Mar 2009 08:51:08 -0300
Message-ID: <20090326085108.0fbc489d@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 12:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmo92-0007l0-CB
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 12:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZCZLvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 07:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbZCZLvP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 07:51:15 -0400
Received: from bombadil.infradead.org ([18.85.46.34]:37135 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZCZLvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 07:51:15 -0400
Received: from 200.220.139.66.nipcable.com ([200.220.139.66] helo=pedra.chehab.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Lmo76-0003GG-Kw
	for git@vger.kernel.org; Thu, 26 Mar 2009 11:51:13 +0000
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114771>

git  fsck (version 1.6.1.1) is reporting a nonexistent troubles on some of
my trees.

For example, those are the results for my
kernel.org /pub/scm/linux/kernel/git/mchehab/linux-2.6.git tree:

$ git fsck
missing tree 3afa5c9eace50837f3c31238102358cf67b8a1ff
missing commit 87c3a86e1c220121d0ced59d1a71e78ed9abc6dd

Both objects exist on this tree.

Also, if we run fsck with --full, those missing objects disappear:

$ git fsck --full
dangling tag b65a80a5ee7923355cbca669cead08e067fc7ada
dangling tag 6fa7003fe34e9a8a31fb91754f3c289cc045564b
dangling tag 8be00154b8e949bf4b89ac198aef9a247532ac2d
dangling tag b503092a16bdba0a418e155fe592521fc20855af
dangling tag 5eb14db1f80df4eb0ecb0976e47e8e287e3175fc
dangling tag 31cb515c75388d457c2f318a0ee9606b3527852f
dangling tag 0715562512ca6cf14c1b8f08e09d5907118deaf0
dangling tag 68185b00cf91c1c4dcc761a2f3a1631562ed52f3
dangling tag 7d4b1bcc5e7411fc9e63f610c16e5de8fe6dfde8
dangling tag 7a3862d6e9934ffe107fe7ddfbe2c63dba321793
dangling tag 1dcda2df87ba4ecc7988be7a45d01645e11c9f4c
dangling tag 8a38e7fd7a30cd44be954f9a3b062e607cec5d41
dangling tag d31ce8060b0e875179ba5ca1d40475dc2a082cc7
dangling tag 87c16e9e8bb74f14f4504305957e4346e7fc46ea
dangling tag b21232ea962bbaf0e909365f4964f6cceb2ba8ce
dangling tag 5dfd736f95b3d84a18b5bb8e50ac71f245438acf
dangling tag cb50773491b0066d0e55f31f8875d5678fa3f8ad
dangling tag 73e37758f6b500a67d918528204832cc8f256516
dangling tag 1a0bff987b27da5181f112bcc60f34d6fbb7e67e

Could this be fixed? It is very annoying to have it reporting a nonexistent
problem.


Cheers,
Mauro
