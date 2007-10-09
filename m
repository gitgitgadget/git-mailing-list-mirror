From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: Problem with git-cvsimport
Date: Tue, 09 Oct 2007 11:25:51 +0200
Organization: Jentro Technologies GmbH
Message-ID: <470B491F.9020306@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 11:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBLq-0007zl-GJ
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 11:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbXJIJZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 05:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXJIJZ4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 05:25:56 -0400
Received: from mail2.infra.net ([212.89.96.7]:4218 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751589AbXJIJZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 05:25:55 -0400
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l999Pq8F026352
	for <git@vger.kernel.org>; Tue, 9 Oct 2007 11:25:52 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id l999Ppt3022618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 9 Oct 2007 11:25:52 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60373>

Hello,

using git-cvsimport (1.5.3.4), it dies with

Update
guidance-common/src/java/com/jentro/manager/guidance/common/servlet/IconServlet.java:
2104 bytes
Tree ID 01cb84cbee2e70a712459be6601b993603eed5bd
Parent ID dcd8dc76f4638d1994165070c9813202992d546a
Committed patch 3775 (bmw +0000 2004-10-14 11:10:43)
Commit ID 53c68066f71651b057884e1101cda3967070724d
Fetching
guidance-common/src/java/com/jentro/manager/guidance/common/serverapi/GuidanceException.java
  v 1.14.4.2
Update
guidance-common/src/java/com/jentro/manager/guidance/common/serverapi/GuidanceException.java:
3718 bytes
Tree ID 886268190ac2cb28b5f1e6cdb309054bcb8fa38e
Parent ID 53c68066f71651b057884e1101cda3967070724d
Merge parent branch: master
fatal: Not a valid object name master
Use of uninitialized value in chomp at /usr/bin/git-cvsimport line 766.
Use of uninitialized value in pattern match (m//) at
/usr/bin/git-cvsimport line 527.
Use of uninitialized value in concatenation (.) or string at
/usr/bin/git-cvsimport line 767.
Cannot get commit id ():

What can I do to avoid this problem?

Cheers,

Thomas
