From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: make test fails with git 1.7.0 on my debian
Date: Tue, 16 Feb 2010 17:18:07 +0100
Message-ID: <7fce93be1002160818p1095b251s281dcd0b644ca519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 17:18:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ82-0007mx-1z
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227Ab0BPQSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 11:18:10 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:23145 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201Ab0BPQSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:18:09 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1518679eyd.19
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:18:08 -0800 (PST)
Received: by 10.213.109.131 with SMTP id j3mr1650790ebp.36.1266337088436; Tue, 
	16 Feb 2010 08:18:08 -0800 (PST)
X-Originating-IP: [80.13.22.90]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140128>

Hi,

this is what I get running make test on my debian :

root@numerobis:~/src/git-1.7.0# uname -a
Linux numerobis 2.6.26-2-686 #1 SMP Wed Nov 4 20:45:37 UTC 2009 i686 GNU/Linux
root@numerobis:~/src/git-1.7.0# make test
    SUBDIR git-gui
    SUBDIR gitk-git
make[1]: Nothing to be done for `all'.
    SUBDIR perl
    SUBDIR git_remote_helpers
    SUBDIR templates
make -C t/ all
make[1]: Entering directory `/root/src/git-1.7.0/t'
rm -f -r test-results
make aggregate-results-and-cleanup
make[2]: Entering directory `/root/src/git-1.7.0/t'
*** t0000-basic.sh ***
*   ok 1: .git/objects should be empty after git init in an empty repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: success is reported like this
*   still broken 4: pretend we have a known breakage
*   FIXED 5: pretend we have fixed a known breakage
*   ok 6: test runs if prerequisite is satisfied
* skip 7: unmet prerequisite causes test to be skipped
*   ok 8: git update-index without --add should fail adding.
*   ok 9: git update-index with --add should succeed.
*   ok 10: writing tree out with git write-tree
*   ok 11: validate object ID of a known tree.
*   ok 12: git update-index without --remove should fail removing.
*   ok 13: git update-index with --remove should be able to remove.
*   ok 14: git write-tree should be able to write an empty tree.
*   ok 15: validate object ID of a known tree.
*   ok 16: adding various types of objects with git update-index --add.
*   ok 17: showing stage with git ls-files --stage
*   ok 18: validate git ls-files output for a known tree.
*   ok 19: writing tree out with git write-tree.
*   ok 20: validate object ID for a known tree.
*   ok 21: showing tree with git ls-tree
*   ok 22: git ls-tree output for a known tree.
*   ok 23: showing tree with git ls-tree -r
*   ok 24: git ls-tree -r output for a known tree.
*   ok 25: showing tree with git ls-tree -r -t
*   ok 26: git ls-tree -r output for a known tree.
*   ok 27: writing partial tree out with git write-tree --prefix.
*   ok 28: validate object ID for a known tree.
*   ok 29: writing partial tree out with git write-tree --prefix.
*   ok 30: validate object ID for a known tree.
*   ok 31: put invalid objects into the index.
*   ok 32: writing this tree without --missing-ok.
*   ok 33: writing this tree with --missing-ok.
*   ok 34: git read-tree followed by write-tree should be idempotent.
*   ok 35: validate git diff-files output for a know cache/work tree state.
*   ok 36: git update-index --refresh should succeed.
*   ok 37: no diff after checkout and git update-index --refresh.
*   ok 38: git commit-tree records the correct tree in a commit.
*   ok 39: git commit-tree records the correct parent in a commit.
*   ok 40: git commit-tree omits duplicated parent in a commit.
*   ok 41: update-index D/F conflict
*   ok 42: absolute path works as expected
*   ok 43: very long name in the index handled sanely
* fixed 1 known breakage(s)
* still have 1 known breakage(s)
* passed all remaining 42 test(s)
*** t0001-init.sh ***
*   ok 1: plain
*   ok 2: plain with GIT_WORK_TREE
*   ok 3: plain bare
*   ok 4: plain bare with GIT_WORK_TREE
*   ok 5: GIT_DIR bare
*   ok 6: init --bare
*   ok 7: GIT_DIR non-bare
*   ok 8: GIT_DIR & GIT_WORK_TREE (1)
*   ok 9: GIT_DIR & GIT_WORK_TREE (2)
*   ok 10: reinit
*   ok 11: init with --template
*   ok 12: init with --template (blank)
*   ok 13: init --bare/--shared overrides system/global config
*   ok 14: init honors global core.sharedRepository
*   ok 15: init rejects insanely long --template
*   ok 16: init creates a new directory
*   ok 17: init creates a new bare directory
*   ok 18: init recreates a directory
*   ok 19: init recreates a new bare directory
*   ok 20: init creates a new deep directory
*   ok 21: init creates a new deep directory (umask vs. shared)
*   ok 22: init notices EEXIST (1)
*   ok 23: init notices EEXIST (2)
* FAIL 24: init notices EPERM

        rm -fr newdir &&
        (
            mkdir newdir &&
            chmod -w newdir &&
            test_must_fail git init newdir/a/b
        )

* failed 1 among 24 test(s)
make[2]: *** [t0001-init.sh] Error 1
make[2]: Leaving directory `/root/src/git-1.7.0/t'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/src/git-1.7.0/t'
make: *** [test] Error 2

Regards.


--
Sylvain
