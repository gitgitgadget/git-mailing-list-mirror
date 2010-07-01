From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 11:28:24 +0200
Message-ID: <87y6dveekn.fsf@ft.bewatermyfriend.org>
References: <8739w3fupp.fsf@ft.bewatermyfriend.org>
	<4C2C5D2F.90000@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUG56-0000Kd-Hm
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab0GAJ3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:29:10 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:35698 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab0GAJ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:29:09 -0400
Received: from [212.117.84.72] (helo=bones.voodoo.lan)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1OUG4v-0004jh-6L; Thu, 01 Jul 2010 11:29:05 +0200
Received: by bones.voodoo.lan (Postfix, from userid 1000)
	id C2F9717EED; Thu,  1 Jul 2010 11:28:24 +0200 (CEST)
In-Reply-To: <4C2C5D2F.90000@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 01 Jul 2010 11:17:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150019>

Michael J Gruber wrote:
> Frank Terbeck venit, vidit, dixit 01.07.2010 10:54:
>> [snip]
>> *   ok 16: info --url added-file
>> * FAIL 17: info added-directory
[...]
>> *   ok 18: info --url added-directory
>> [...]
>> * failed 1 among 38 test(s)
>> make[2]: *** [t9119-git-svn-info.sh] Error 1
>> [snap]
[...]
>> Anyway, my svn version is "svn, version 1.6.9 (r901367)". The test suite
>> I ran is from yesterdays git master branch. If it matters, this is a
>> Linux box running a debian 2.6.26-2-686 kernel; the file system in
>> question is `ext3' being mounted `noatime'.
>
> It works for me with the exact same svn version on Fedora 13.
>
> Please run the test like that:
> cd t
> ./t9119-git-svn-info.sh -i
>
> This stop immediately after the failed test. Then, please tell us the
> contents of the actual.. and expected... files in the trash... subdir.

Okay.

expected.info-added-directory:
[snip]
Path: added-directory
URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/svnrepo/added-directory
Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/svnrepo
Repository UUID: 638d0b70-c7df-46bd-9c56-aff8052b4ab8
Revision: 0
Node Kind: directory
Schedule: add
[snap]

actual.info-added-directory:
[snip]
Path: added-directory
URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/svnrepo/added-directory
Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/svnrepo
Revision: 0
Node Kind: directory
Schedule: add
[snap]

And a unified diff of the two:
[snip]
--- trash directory.t9119-git-svn-info/actual.info-added-directory 2010-07-01 11:22:16.000000000 +0200
+++ trash directory.t9119-git-svn-info/expected.info-added-directory 2010-07-01 11:22:16.000000000 +0200
@@ -1,6 +1,7 @@
 Path: added-directory
 URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/svnrepo/added-directory
 Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/svnrepo
+Repository UUID: 638d0b70-c7df-46bd-9c56-aff8052b4ab8
 Revision: 0
 Node Kind: directory
 Schedule: add
[snap]

Regards, Frank
