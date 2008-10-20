From: Johan Herland <johan@herland.net>
Subject: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 10:10:29 +0200
Message-ID: <200810201010.29173.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 20:23:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krpsa-0003vz-Om
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 10:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYJTILc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 04:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYJTILc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 04:11:32 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56705 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbYJTILb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 04:11:31 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K91003092R60D00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 20 Oct 2008 10:11:31 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K91000CD2PI7WD0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 20 Oct 2008 10:10:30 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K9100ILL2PHR4B0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 20 Oct 2008 10:10:29 +0200 (CEST)
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98687>

Hi,

Currently I get the following error when trying to pull from git.git at 
kernel.org:

$ git pull
remote: Counting objects: 279, done.
remote: Compressing objects: 100% (78/78), done.
remote: Total 177 (delta 136), reused 135 (delta 99)
Receiving objects: 100% (177/177), 66.59 KiB | 59 KiB/s, done.
fatal: pack has bad object at offset 53487: failed to apply delta
fatal: index-pack failed


For reference, here's the relevant part of .git/config:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*


I using a recent "next" version: 1.6.0.2.767.g8f0e


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
