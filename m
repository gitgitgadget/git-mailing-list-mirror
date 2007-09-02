From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 10:43:38 +0200
Message-ID: <fbdt3q$lcf$1@sea.gmane.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 10:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRlEd-0000dG-VY
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 10:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbXIBIzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 04:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbXIBIzG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 04:55:06 -0400
Received: from main.gmane.org ([80.91.229.2]:39511 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbXIBIzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 04:55:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IRlEU-0004Xz-DV
	for git@vger.kernel.org; Sun, 02 Sep 2007 10:55:02 +0200
Received: from chello089076029142.chello.pl ([89.76.29.142])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 10:55:02 +0200
Received: from arekm by chello089076029142.chello.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 10:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello089076029142.chello.pl
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57308>

Junio C Hamano wrote:

> The latest feature release GIT 1.5.3 is available at the usual
> places:

Hm,

/usr/bin/make -C t/ all
make[1]: Entering directory `/home/users/arekm/rpm/BUILD/git-1.5.3/t'
*** t0000-basic.sh ***
*   ok 1: .git/objects should be empty after git init in an empty repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: git update-index without --add should fail adding.
*   ok 4: git update-index with --add should succeed.
*   ok 5: writing tree out with git write-tree
*   ok 6: validate object ID of a known tree.
*   ok 7: git update-index without --remove should fail removing.
*   ok 8: git update-index with --remove should be able to remove.
*   ok 9: git write-tree should be able to write an empty tree.
*   ok 10: validate object ID of a known tree.
*   ok 11: adding various types of objects with git update-index --add.
*   ok 12: showing stage with git ls-files --stage
*   ok 13: validate git ls-files output for a known tree.
*   ok 14: writing tree out with git write-tree.
*   ok 15: validate object ID for a known tree.
*   ok 16: showing tree with git ls-tree
*   ok 17: git ls-tree output for a known tree.
*   ok 18: showing tree with git ls-tree -r
*   ok 19: git ls-tree -r output for a known tree.
*   ok 20: showing tree with git ls-tree -r -t
*   ok 21: git ls-tree -r output for a known tree.
*   ok 22: writing partial tree out with git write-tree --prefix.
*   ok 23: validate object ID for a known tree.
*   ok 24: writing partial tree out with git write-tree --prefix.
*   ok 25: validate object ID for a known tree.
*   ok 26: put invalid objects into the index.
*   ok 27: writing this tree without --missing-ok.
*   ok 28: writing this tree with --missing-ok.
*   ok 29: git read-tree followed by write-tree should be idempotent.
*   ok 30: validate git diff-files output for a know cache/work tree st=
ate.
*   ok 31: git update-index --refresh should succeed.
*   ok 32: no diff after checkout and git update-index --refresh.
*   ok 33: git commit-tree records the correct tree in a commit.
*   ok 34: git commit-tree records the correct parent in a commit.
*   ok 35: git commit-tree omits duplicated parent in a commit.
*   ok 36: update-index D/F conflict
*   ok 37: absolute path works as expected
* passed all 37 test(s)
*** t0001-init.sh ***
* FAIL 1: plain

                (
                        unset GIT_DIR GIT_WORK_TREE &&
                        mkdir plain &&
                        cd plain &&
                        git init
                ) &&
                check_config plain/.git false unset

*   ok 2: plain with GIT_WORK_TREE
* FAIL 3: plain bare

                (
                        unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
                        mkdir plain-bare-1 &&
                        cd plain-bare-1 &&
                        git --bare init
                ) &&
                check_config plain-bare-1 true unset

*   ok 4: plain bare with GIT_WORK_TREE
*   ok 5: GIT_DIR bare
*   ok 6: GIT_DIR non-bare
*   ok 7: GIT_DIR & GIT_WORK_TREE (1)
*   ok 8: GIT_DIR & GIT_WORK_TREE (2)
* failed 2 among 8 test(s)
make[1]: *** [t0001-init.sh] Error 1
make[1]: Leaving directory `/home/users/arekm/rpm/BUILD/git-1.5.3/t'

verified on 2 machines (so /dev/ is ok this time)

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
