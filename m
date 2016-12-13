Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6BB203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934148AbcLMTTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:19:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:59708 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933449AbcLMTTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:19:25 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrqNe-1clEDr15Bu-013iLO; Tue, 13
 Dec 2016 20:19:17 +0100
Date:   Tue, 13 Dec 2016 20:19:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
In-Reply-To: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612131839220.3147@virtualbox>
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w2iAOQ0Nh3gQy23g5m0NaNE6cDqlKyQUTFfRBuMyPbKFh0iHi5Q
 lgb0Qqm7w3jNyRFQ0wt9flUfy2pEMVCL10Gj5BXlizG0m1vU5saFx9FkJkD7U1f2gZHR9ZL
 jpGxaj45HNAJPJleEKpm1YH3Hg3ZhVpQ3gb+6CodfRGcuswN7/hjs3dMMYz9UUetfNyyf0k
 fuKLgAS5HES1Ky484VgAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rc/J6AfJC3w=:ONn4CHlclV2aCROY/BIM9F
 lArH2CZ3j8uSZ8fiXI36CzYZb4zZRDBqm1CuIRiedjWbXb4GWrR4lj+7B1oClsMkI91I2HKJs
 AtWL2mpeOfSGsrWht0s4vHPHxgt6ABKzuTpHLC9e71mUdVxXa13rIPlEkXPlOiYsZrEAedMEx
 lAc3og/VThsLyVfYPaO/2lTZ2vUJhbfRupJs84h1G5k2WRyh7wXgm77DjSMgawAMYP01T1IMT
 jXE5fXwGvuLjga1GgLfmR71YjV25MjQ04r7iqlBJflsCtLWwgcABctIKnotUXN/GNWbRXhxHq
 abx2bCopFJZQbU+sGqIOWBLJr16WYOHhpw1stLVBCaE8QUs5f93cr5G9i94zOc0vluPLA5qSh
 QfHuDx5trmbW6+iSltEiRpvsSjXHRhQQscIBMwfgpDaZ0GfjzFJY0MwONIeDIxCxFRad8ri3F
 e7oZdDoY6zC+xy+RhCvrslvY0yPOHnvaXLN9Ma90aYtxsyYPNJKIBHItYNsWYkZhVxSbWtbtc
 NvJeN2ppUUiPlHlXM328YCvRatvM3tcY2jtUA8Ri/ALB4qAN1xCzrzbHypCENUefnfLAqr9jF
 eALYpwQ+KEa5ivEWW3u2NmJ3itR7zyPHgMIbAmAsR+Br3SW6EImn5rlZ2GQZ/YRou/3PGO1lP
 kkewtGyQZw10BZkDrqGWdZE3M0LvLCWHW39c0IAa+lu+7CmZJlg3N9f693nvl76Ofmrv5nrXa
 2t4AlOptn3w+yRxOOYlA46+arejfVoeDE/zG9nCs7t1mdoP3hmPeSQzJGNK/Gf2/UU6Kpx5kn
 0h4JD48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Dec 2016, Junio C Hamano wrote:

> * bw/grep-recurse-submodules (2016-11-22) 6 commits
>  - grep: search history of moved submodules
>  - grep: enable recurse-submodules to work on <tree> objects
>  - grep: optionally recurse into submodules
>  - grep: add submodules as a grep source type
>  - submodules: load gitmodules file from commit sha1
>  - submodules: add helper functions to determine presence of submodules
> 
>  "git grep" learns to optionally recurse into submodules
> 
>  Has anybody else seen t7814 being flakey with this series?

It is not flakey for me, it fails consistently on Windows. This is the
output with -i -v -x (sorry, I won't have time this week to do anything
about it, but maybe it helps identify the root cause):

-- snipsnap --
Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip3/t/trash
directory.t7814-grep-recurse-submodules/.git/
expecting success: 
	echo "foobar" >a &&
	mkdir b &&
	echo "bar" >b/b &&
	git add a b &&
	git commit -m "add a and b" &&
	git init submodule &&
	echo "foobar" >submodule/a &&
	git -C submodule add a &&
	git -C submodule commit -m "add a" &&
	git submodule add ./submodule &&
	git commit -m "added submodule"

++ echo foobar
++ mkdir b
++ echo bar
++ git add a b
++ git commit -m 'add a and b'
[master (root-commit) 6a17548] add a and b
 Author: A U Thor <author@example.com>
 2 files changed, 2 insertions(+)
 create mode 100644 a
 create mode 100644 b/b
++ git init submodule
Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip3/t/trash
directory.t7814-grep-recurse-submodules/submodule/.git/
++ echo foobar
++ git -C submodule add a
++ git -C submodule commit -m 'add a'
[master (root-commit) 081a998] add a
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 a
++ git submodule add ./submodule
Adding existing repo at 'submodule' to the index
++ git commit -m 'added submodule'
[master 0c0fdd0] added submodule
 Author: A U Thor <author@example.com>
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 submodule
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 1 - setup directory structure and submodule

expecting success: 
	cat >expect <<-\EOF &&
	a:foobar
	b/b:bar
	submodule/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules >actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='b/b:bar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
b/b:bar
submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='b/b:bar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
b/b:bar
submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'a:foobar
b/b:bar
submodule/a:foobar
'
++ test -n 'a:foobar
b/b:bar
submodule/a:foobar
'
++ test 'a:foobar
b/b:bar
submodule/a:foobar
' = 'a:foobar
b/b:bar
submodule/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 2 - grep correctly finds patterns in a submodule

expecting success: 
	cat >expect <<-\EOF &&
	submodule/a:foobar
	EOF

	git grep -e. --recurse-submodules -- submodule >actual &&
	test_cmp expect actual

++ cat
++ git grep -e. --recurse-submodules -- submodule
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'submodule/a:foobar
'
++ test -n 'submodule/a:foobar
'
++ test 'submodule/a:foobar
' = 'submodule/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 3 - grep and basic pathspecs

expecting success: 
	git init submodule/sub &&
	echo "foobar" >submodule/sub/a &&
	git -C submodule/sub add a &&
	git -C submodule/sub commit -m "add a" &&
	git -C submodule submodule add ./sub &&
	git -C submodule add sub &&
	git -C submodule commit -m "added sub" &&
	git add submodule &&
	git commit -m "updated submodule" &&

	cat >expect <<-\EOF &&
	a:foobar
	b/b:bar
	submodule/a:foobar
	submodule/sub/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules >actual &&
	test_cmp expect actual

++ git init submodule/sub
Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip3/t/trash
directory.t7814-grep-recurse-submodules/submodule/sub/.git/
++ echo foobar
++ git -C submodule/sub add a
++ git -C submodule/sub commit -m 'add a'
[master (root-commit) b95b263] add a
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 a
++ git -C submodule submodule add ./sub
Adding existing repo at 'sub' to the index
++ git -C submodule add sub
++ git -C submodule commit -m 'added sub'
[master 190608e] added sub
 Author: A U Thor <author@example.com>
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 sub
++ git add submodule
++ git commit -m 'updated submodule'
[master 5198849] updated submodule
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ cat
++ git grep -e bar --recurse-submodules
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='b/b:bar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
b/b:bar
submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/sub/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
b/b:bar
submodule/a:foobar
submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='b/b:bar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
b/b:bar
submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/sub/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
b/b:bar
submodule/a:foobar
submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'a:foobar
b/b:bar
submodule/a:foobar
submodule/sub/a:foobar
'
++ test -n 'a:foobar
b/b:bar
submodule/a:foobar
submodule/sub/a:foobar
'
++ test 'a:foobar
b/b:bar
submodule/a:foobar
submodule/sub/a:foobar
' = 'a:foobar
b/b:bar
submodule/a:foobar
submodule/sub/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 4 - grep and nested submodules

expecting success: 
	cat >expect <<-\EOF &&
	a:foobar
	submodule/a:foobar
	submodule/sub/a:foobar
	EOF

	git grep -e "bar" --and -e "foo" --recurse-submodules >actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --and -e foo --recurse-submodules
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/sub/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='a:foobar
submodule/a:foobar
submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='submodule/sub/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='a:foobar
submodule/a:foobar
submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'a:foobar
submodule/a:foobar
submodule/sub/a:foobar
'
++ test -n 'a:foobar
submodule/a:foobar
submodule/sub/a:foobar
'
++ test 'a:foobar
submodule/a:foobar
submodule/sub/a:foobar
' = 'a:foobar
submodule/a:foobar
submodule/sub/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 5 - grep and multiple patterns

expecting success: 
	cat >expect <<-\EOF &&
	b/b:bar
	EOF

	git grep -e "bar" --and --not -e "foo" --recurse-submodules
>actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --and --not -e foo --recurse-submodules
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='b/b:bar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='b/b:bar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'b/b:bar
'
++ test -n 'b/b:bar
'
++ test 'b/b:bar
' = 'b/b:bar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 6 - grep and multiple patterns

expecting success: 
	cat >expect <<-\EOF &&
	HEAD:a:foobar
	HEAD:b/b:bar
	HEAD:submodule/a:foobar
	HEAD:submodule/sub/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules HEAD >actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules HEAD
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:b/b:bar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:a:foobar
HEAD:b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:b/b:bar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:a:foobar
HEAD:b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ test -n 'HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ test 'HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
' = 'HEAD:a:foobar
HEAD:b/b:bar
HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 7 - basic grep tree

expecting success: 
	cat >expect <<-\EOF &&
	HEAD^:a:foobar
	HEAD^:b/b:bar
	HEAD^:submodule/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules HEAD^ >actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules 'HEAD^'
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^:a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD^:a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^:b/b:bar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD^:a:foobar
HEAD^:b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^:submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD^:a:foobar
HEAD^:b/b:bar
HEAD^:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^:a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD^:a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^:b/b:bar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD^:a:foobar
HEAD^:b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^:submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD^:a:foobar
HEAD^:b/b:bar
HEAD^:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD^:a:foobar
HEAD^:b/b:bar
HEAD^:submodule/a:foobar
'
++ test -n 'HEAD^:a:foobar
HEAD^:b/b:bar
HEAD^:submodule/a:foobar
'
++ test 'HEAD^:a:foobar
HEAD^:b/b:bar
HEAD^:submodule/a:foobar
' = 'HEAD^:a:foobar
HEAD^:b/b:bar
HEAD^:submodule/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 8 - grep tree HEAD^

expecting success: 
	cat >expect <<-\EOF &&
	HEAD^^:a:foobar
	HEAD^^:b/b:bar
	EOF

	git grep -e "bar" --recurse-submodules HEAD^^ >actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules 'HEAD^^'
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^^:a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD^^:a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^^:b/b:bar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD^^:a:foobar
HEAD^^:b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^^:a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD^^:a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD^^:b/b:bar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD^^:a:foobar
HEAD^^:b/b:bar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD^^:a:foobar
HEAD^^:b/b:bar
'
++ test -n 'HEAD^^:a:foobar
HEAD^^:b/b:bar
'
++ test 'HEAD^^:a:foobar
HEAD^^:b/b:bar
' = 'HEAD^^:a:foobar
HEAD^^:b/b:bar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 9 - grep tree HEAD^^

expecting success: 
	cat >expect <<-\EOF &&
	HEAD:submodule/a:foobar
	HEAD:submodule/sub/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules HEAD -- submodule >actual
&&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules HEAD -- submodule
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ test -n 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ test 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
' = 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 10 - grep tree and pathspecs

expecting success: 
	cat >expect <<-\EOF &&
	HEAD:submodule/a:foobar
	HEAD:submodule/sub/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules HEAD -- "submodule*a"
>actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules HEAD -- 'submodule*a'
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ test -n 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
++ test 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
' = 'HEAD:submodule/a:foobar
HEAD:submodule/sub/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 11 - grep tree and pathspecs

expecting success: 
	cat >expect <<-\EOF &&
	HEAD:submodule/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules HEAD -- "submodul?/a"
>actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules HEAD -- 'submodul?/a'
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:submodule/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD:submodule/a:foobar
'
++ test -n 'HEAD:submodule/a:foobar
'
++ test 'HEAD:submodule/a:foobar
' = 'HEAD:submodule/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 12 - grep tree and more pathspecs

expecting success: 
	cat >expect <<-\EOF &&
	HEAD:submodule/sub/a:foobar
	EOF

	git grep -e "bar" --recurse-submodules HEAD -- "submodul*/sub/a"
>actual &&
	test_cmp expect actual

++ cat
++ git grep -e bar --recurse-submodules HEAD -- 'submodul*/sub/a'
++ test_cmp expect actual
++ mingw_test_cmp expect actual
++ local test_cmp_a= test_cmp_b=
++ local stdin_for_diff=
++ test -s expect
++ test -s actual
++ mingw_read_file_strip_cr_ test_cmp_a
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_a=$test_cmp_a$line'
+++ test_cmp_a='HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ mingw_read_file_strip_cr_ test_cmp_b
++ local line
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ line='HEAD:submodule/sub/a:foobar
'
++ eval 'test_cmp_b=$test_cmp_b$line'
+++ test_cmp_b='HEAD:submodule/sub/a:foobar
'
++ :
++ IFS=$'\r'
++ read -r -d '
' line
++ test -z ''
++ break
++ test -n 'HEAD:submodule/sub/a:foobar
'
++ test -n 'HEAD:submodule/sub/a:foobar
'
++ test 'HEAD:submodule/sub/a:foobar
' = 'HEAD:submodule/sub/a:foobar
'
+ test_eval_ret_=0
+ want_trace
+ test t = t
+ test t = t
+ set +x
ok 13 - grep tree and more pathspecs

expecting success: 
	git init parent &&
	test_when_finished "rm -rf parent" &&
	echo "foobar" >"parent/fi:le" &&
	git -C parent add "fi:le" &&
	git -C parent commit -m "add fi:le" &&

	git init "su:b" &&
	test_when_finished "rm -rf su:b" &&
	echo "foobar" >"su:b/fi:le" &&
	git -C "su:b" add "fi:le" &&
	git -C "su:b" commit -m "add fi:le" &&

	git -C parent submodule add "../su:b" "su:b" &&
	git -C parent commit -m "add submodule" &&

	cat >expect <<-\EOF &&
	fi:le:foobar
	su:b/fi:le:foobar
	EOF
	git -C parent grep -e "foobar" --recurse-submodules >actual &&
	test_cmp expect actual &&

	cat >expect <<-\EOF &&
	HEAD:fi:le:foobar
	HEAD:su:b/fi:le:foobar
	EOF
	git -C parent grep -e "foobar" --recurse-submodules HEAD >actual
&&
	test_cmp expect actual

++ git init parent
Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip3/t/trash
directory.t7814-grep-recurse-submodules/parent/.git/
++ test_when_finished 'rm -rf parent'
++ test 0 = 0
++ test_cleanup='{ rm -rf parent
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ echo foobar
++ git -C parent add fi:le
fatal: pathspec 'fi:le' did not match any files
+ test_eval_ret_=128
+ want_trace
+ test t = t
+ test t = t
+ set +x
error: last command exited with $?=128
not ok 14 - grep recurse submodule colon in name
#	
#		git init parent &&
#		test_when_finished "rm -rf parent" &&
#		echo "foobar" >"parent/fi:le" &&
#		git -C parent add "fi:le" &&
#		git -C parent commit -m "add fi:le" &&
#	
#		git init "su:b" &&
#		test_when_finished "rm -rf su:b" &&
#		echo "foobar" >"su:b/fi:le" &&
#		git -C "su:b" add "fi:le" &&
#		git -C "su:b" commit -m "add fi:le" &&
#	
#		git -C parent submodule add "../su:b" "su:b" &&
#		git -C parent commit -m "add submodule" &&
#	
#		cat >expect <<-\EOF &&
#		fi:le:foobar
#		su:b/fi:le:foobar
#		EOF
#		git -C parent grep -e "foobar" --recurse-submodules
#		>actual &&
#		test_cmp expect actual &&
#	
#		cat >expect <<-\EOF &&
#		HEAD:fi:le:foobar
#		HEAD:su:b/fi:le:foobar
#		EOF
#		git -C parent grep -e "foobar" --recurse-submodules HEAD
#		>actual &&
#		test_cmp expect actual
#	

