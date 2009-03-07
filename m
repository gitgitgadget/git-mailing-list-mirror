From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: After the Release I started the Tests  I found a Problem
 git-t4020-diff-external.sh
Date: Sat, 7 Mar 2009 14:01:09 -0700
Message-ID: <alpine.LNX.2.00.0903071358410.2164@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3fR-0004dm-Ay
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbZCGVBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZCGVBM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:01:12 -0500
Received: from suse104.zenez.com ([198.60.105.164]:60579 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbZCGVBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:01:11 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 182506C08B2; Sat,  7 Mar 2009 14:01:09 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 09631938188
	for <git@vger.kernel.org>; Sat,  7 Mar 2009 14:01:09 -0700 (MST)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112583>

This is on the SCO OpenServer 6.0 MP 4 release.

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

on t4020-diff-external.sh Here is the message on the failure.

* FAIL 12: force diff with "diff"

                 echo >.gitattributes "file diff" &&
                 git diff >actual &&
                 test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual


This is what I see with set -x

+ echo NULZbetweenZwords
+ perl -pe 'y/Z/\000/'
+ test_expect_success 'force diff with "diff"' '
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
+ test 2 = 2
+ test_skip 'force diff with "diff"' '
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
++ expr ././t4020-diff-external.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4020
++ expr 11 + 1
+ this_test=t4020.12
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
+ say_color info 'expecting success:
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
+ test -z info
+ shift
+ echo '* expecting success:
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
+ test_run_ '
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
+ eval '
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ 'force diff with "diff"' '
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'
++ expr 11 + 1
+ test_count=12
++ expr 0 + 1
+ test_failure=1
+ say_color error 'FAIL 12: force diff with "diff"'
+ test -z error
+ shift
+ echo '* FAIL 12: force diff with "diff"'
* FAIL 12: force diff with "diff"
+ shift
+ echo '
         echo >.gitattributes "file diff" &&
         git diff >actual &&
         test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
'+ sed -e 's/^/ /'


                 echo >.gitattributes "file diff" &&
                 git diff >actual &&
                 test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
