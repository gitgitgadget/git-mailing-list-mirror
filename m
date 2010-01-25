From: Michael Ludwig <michael.ludwig@xing.com>
Subject: git status showing phantom modifications
Date: Mon, 25 Jan 2010 11:41:05 +0100
Message-ID: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 11:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMUk-0008NB-6c
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 11:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab0AYKsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 05:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821Ab0AYKsa
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 05:48:30 -0500
Received: from mail42-3.xing.com ([213.238.60.163]:46721 "EHLO
	mail42-3.xing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0AYKs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 05:48:29 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2010 05:48:29 EST
Received: from localhost (localhost [127.0.0.1])
	by mail42-3.xing.com (Postfix) with ESMTP id 4F4DB3000ABBA
	for <git@vger.kernel.org>; Mon, 25 Jan 2010 11:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xing.com; h=
	mime-version:content-transfer-encoding:content-type
	:content-language:accept-language:message-id:subject:date:from
	:received:received:received:x-virus-scanned; s=main; t=
	1264416084; bh=zg5jYw9wSkXZ4cmWOQgbTYUwD0S5CGRWN7ZdANPTtxM=; b=e
	kiU9ud962hgxtyNz5odAOnp2adKZJToDn6fB7Mit9xdwRqL1QB4oYHCmaoDDqTkl
	Ti775F1XkLpQZz1DK7hxIztJ1S7cFHt3oM1xmCfjSW05h0u4jtaHAK1I+v6CpFpu
	13Dhbbxdv6/HeGgtiqBLYZPEqajfgI+AmdK8PR3VHQ=
X-Virus-Scanned: Debian amavisd-new at obc-mail42-3.rz.xing.com
Received: from mail42-3.xing.com ([127.0.0.1])
	by localhost (obc-mail42-3.rz.xing.com [127.0.0.1]) (amavisd-new, port 10030)
	with ESMTP id jAtemjjR1VEv for <git@vger.kernel.org>;
	Mon, 25 Jan 2010 11:41:24 +0100 (CET)
Received: from luftpostix.xing.hh (unknown [172.20.1.5])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail42-3.xing.com (Postfix) with ESMTPS id 38A933000ABA3
	for <git@vger.kernel.org>; Mon, 25 Jan 2010 11:41:23 +0100 (CET)
Received: from luftpostix.xing.hh ([172.20.1.5]) by luftpostix.xing.hh
 ([172.20.1.5]) with mapi; Mon, 25 Jan 2010 11:41:06 +0100
Thread-Topic: git status showing phantom modifications
Thread-Index: AcqdquXNk135AhqXQouXLUS7uMwtNA==
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137947>

This is on Cygwin, package git-1.6.4.2-1 [1]:

michael@wladimir:/cygdrive/m/REPOS6.TECH.git :-) git st
# On branch master
nothing to commit (working directory clean)

Note: This repository is a fresh conversion from a subversion repository.
As mentioned, this is Cygwin on XP Home, and the filesystem is NTFS.

michael@wladimir:/cygdrive/m/REPOS6.TECH.git :-) cd comp

Note: The directory I've cd'd into is not a submodule, just a regular part
of the working copy.

michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git st
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   mw/wsdl-version.txt
#       modified:   net/httpsrvr/iis6.wodo
#       ... and about 100 more of that ...

I would expect the output of git status to be consistent regardless of my
position in the working directory.

Git bug, Cygwin issue, or some oversight of mine?

[1] http://cygwin.com/packages/git/
-- 
Michael.Ludwig (#) XING.com
