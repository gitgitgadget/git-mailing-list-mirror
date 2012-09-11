From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: How to update a cloned git repository
Date: Tue, 11 Sep 2012 12:49:01 +0200
Message-ID: <k2n4v2$88t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 12:49:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBO24-0005g7-3P
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 12:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758662Ab2IKKtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 06:49:20 -0400
Received: from plane.gmane.org ([80.91.229.3]:56382 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317Ab2IKKtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 06:49:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TBO1u-0005Vn-Kb
	for git@vger.kernel.org; Tue, 11 Sep 2012 12:49:18 +0200
Received: from dsdf-4db532aa.pool.mediaways.net ([77.181.50.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 12:49:18 +0200
Received: from jojo by dsdf-4db532aa.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 12:49:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db532aa.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205216>

Hi folks

Probably a beginner's question...

If I did a
    git clone git://guthub.com/git/git.git
and worked on some own branches of pu
    git checkout pu;git checkout -p mybranch;hack;hack;...;git commit -a -s
how to update my repository once the the one on github changed?
A plain
    git pull
or
    git fetch;git merge
keeps failing on my with lots of conflicts, none of which relate to any of 
the changes I did (and hence wouldn't know how to resolve)


Bye, Jojo 
