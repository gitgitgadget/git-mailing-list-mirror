Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A6C35242
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EFE21741
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBIA60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 19:58:26 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37129 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727502AbgBIA60 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Feb 2020 19:58:26 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1j0avW-000Yk8-7O>; Sun, 09 Feb 2020 01:58:22 +0100
Received: from x590e5ec4.dyn.telefonica.de ([89.14.94.196] helo=[192.168.1.8])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1j0avV-0016Nb-Ta>; Sun, 09 Feb 2020 01:58:22 +0100
Subject: Re: Testsuite failures on ppc64, sparc64 and s390x (64-bit BE)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <34ed7497-643e-5a38-d68c-7c075b647bcd@physik.fu-berlin.de>
 <b7565f06-55a2-7087-d46e-94f9e7ada988@physik.fu-berlin.de>
 <20200104224830.GF6570@camp.crustytoothpaste.net>
Cc:     git@vger.kernel.org
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <494689ca-c61f-47e0-c14a-28329a30f288@physik.fu-berlin.de>
Date:   Sun, 9 Feb 2020 01:58:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200104224830.GF6570@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 89.14.94.196
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On 1/4/20 11:48 PM, brian m. carlson wrote:
> Did you build your version of Git with Subversion support, and if so,
> which version of Subversion did you use (version of Debian package or
> other source)?  The tests that were failing all require git-svn, which
> in turn require libsvn-perl and subversion (/usr/bin/svn).  If you're
> missing those packages, the Subversion tests will automatically be
> skipped.
> 
> The latest version on master is 2.25-rc1, and that's failing in the
> Debian package.  I haven't checked recently, but last I looked, the
> Debian package wasn't applying any additional patches on top of Git, so
> the version you're getting off GitHub is literally the same version that
> you're getting in the Debian package.

I did some more testing and the failures are caused by sqlite3:

(sid_ppc64-dchroot)root@redpanda:/build/git-ceFUyK/git-2.25.0+next.20200130/t# ./t9108-git-svn-glob.sh
not ok 1 - test refspec globbing
#
#               mkdir -p trunk/src/a trunk/src/b trunk/doc &&
#               echo "hello world" > trunk/src/a/readme &&
#               echo "goodbye world" > trunk/src/b/readme &&
#               svn_cmd import -m "initial" trunk "$svnrepo"/trunk &&
#               svn_cmd co "$svnrepo" tmp &&
#               (
#                       cd tmp &&
#                       mkdir branches tags &&
#                       svn_cmd add branches tags &&
#                       svn_cmd cp trunk branches/start &&
#                       svn_cmd commit -m "start a new branch" &&
#                       svn_cmd up &&
#                       echo "hi" >> branches/start/src/b/readme &&
#                       poke branches/start/src/b/readme &&
#                       echo "hey" >> branches/start/src/a/readme &&
#                       poke branches/start/src/a/readme &&
#                       svn_cmd commit -m "hi" &&
#                       svn_cmd up &&
#                       svn_cmd cp branches/start tags/end &&
#                       echo "bye" >> tags/end/src/b/readme &&
#                       poke tags/end/src/b/readme &&
#                       echo "aye" >> tags/end/src/a/readme &&
#                       poke tags/end/src/a/readme &&
#                       svn_cmd commit -m "the end" &&
#                       echo "byebye" >> tags/end/src/b/readme &&
#                       poke tags/end/src/b/readme &&
#                       svn_cmd commit -m "nothing to see here"
#               ) &&
#               git config --add svn-remote.svn.url "$svnrepo" &&
#               git config --add svn-remote.svn.fetch \
#                                "trunk/src/a:refs/remotes/trunk" &&
#               git config --add svn-remote.svn.branches \
#                                "branches/*/src/a:refs/remotes/branches/*" &&
#               git config --add svn-remote.svn.tags\
#                                "tags/*/src/a:refs/remotes/tags/*" &&
#               git svn multi-fetch &&
#               git log --pretty=oneline refs/remotes/tags/end >actual &&
#               sed -e "s/^.\{41\}//" actual >output.end &&
#               test_cmp expect.end output.end &&
#               test "$(git rev-parse refs/remotes/tags/end~1)" = \
#                       "$(git rev-parse refs/remotes/branches/start)" &&
#               test "$(git rev-parse refs/remotes/branches/start~2)" = \
#                       "$(git rev-parse refs/remotes/trunk)" &&
#               test_must_fail git rev-parse refs/remotes/tags/end@3
#
not ok 2 - test left-hand-side only globbing
#
#               git config --add svn-remote.two.url "$svnrepo" &&
#               git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
#               git config --add svn-remote.two.branches \
#                                "branches/*:refs/remotes/two/branches/*" &&
#               git config --add svn-remote.two.tags \
#                                "tags/*:refs/remotes/two/tags/*" &&
#               (
#                       cd tmp &&
#                       echo "try try" >> tags/end/src/b/readme &&
#                       poke tags/end/src/b/readme &&
#                       svn_cmd commit -m "try to try"
#               ) &&
#               git svn fetch two &&
#               git rev-list refs/remotes/two/tags/end >actual &&
#               test_line_count = 6 actual &&
#               git rev-list refs/remotes/two/branches/start >actual &&
#               test_line_count = 3 actual &&
#               test $(git rev-parse refs/remotes/two/branches/start~2) = \
#                    $(git rev-parse refs/remotes/two/trunk) &&
#               test $(git rev-parse refs/remotes/two/tags/end~3) = \
#                    $(git rev-parse refs/remotes/two/branches/start) &&
#               git log --pretty=oneline refs/remotes/two/tags/end >actual &&
#               sed -e "s/^.\{41\}//" actual >output.two &&
#               test_cmp expect.two output.two
#
ok 3 - prepare test disallow multi-globs
not ok 4 - test disallow multi-globs
#
#               git config --add svn-remote.three.url "$svnrepo" &&
#               git config --add svn-remote.three.fetch \
#                                trunk:refs/remotes/three/trunk &&
#               git config --add svn-remote.three.branches \
#                                "branches/*/t/*:refs/remotes/three/branches/*" &&
#               git config --add svn-remote.three.tags \
#                                "tags/*/*:refs/remotes/three/tags/*" &&
#               (
#                       cd tmp &&
#                       echo "try try" >> tags/end/src/b/readme &&
#                       poke tags/end/src/b/readme &&
#                       svn_cmd commit -m "try to try"
#               ) &&
#               test_must_fail git svn fetch three 2> stderr.three &&
#               test_cmp expect.three stderr.three
#
# failed 3 among 4 test(s)
1..4
(sid_ppc64-dchroot)root@redpanda:/build/git-ceFUyK/git-2.25.0+next.20200130/t# dpkg -i /libsqlite3-0_3.30.1-1_ppc64.deb
dpkg: warning: downgrading libsqlite3-0:ppc64 from 3.31.1-1 to 3.30.1-1
(Reading database ... 30145 files and directories currently installed.)
Preparing to unpack .../libsqlite3-0_3.30.1-1_ppc64.deb ...
Unpacking libsqlite3-0:ppc64 (3.30.1-1) over (3.31.1-1) ...
Setting up libsqlite3-0:ppc64 (3.30.1-1) ...
Processing triggers for libc-bin (2.29-10) ...
(sid_ppc64-dchroot)root@redpanda:/build/git-ceFUyK/git-2.25.0+next.20200130/t# ./t9108-git-svn-glob.sh
ok 1 - test refspec globbing
ok 2 - test left-hand-side only globbing
ok 3 - prepare test disallow multi-globs
ok 4 - test disallow multi-globs
# passed all 4 test(s)
1..4
(sid_ppc64-dchroot)root@redpanda:/build/git-ceFUyK/git-2.25.0+next.20200130/t#

I will bisect sqlite3 tomorrow to find out when the regression was introduced.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
