Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5201F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 10:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfJaKQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 06:16:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:45951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfJaKQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 06:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572516993;
        bh=EoVeN3AUPVSL3tqlI5H9TJK0xknJh6dq00McpBlejyM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NGkYbT7HUf4+h5LgeTtnWipIRgWO4a7yU7sk9p5qQ7WUCMU/dLxFeXSsGR6acWn3G
         1bqkEGi6byol/qZAchwFS4S4o7SSAyqsYwDq1x55UmvX6Sr+xqxR5wazEdNlcTWFhn
         7i3TZy8VjSxFRwYdfMjvbwPSkDhkQLzo970K3mfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1i5zOF3UMN-00txpk; Thu, 31
 Oct 2019 11:16:32 +0100
Date:   Thu, 31 Oct 2019 11:16:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matthew DeVore <matvore@google.com>
cc:     git@vger.kernel.org, Matthew DeVore <matvore@gmail.com>,
        matvore@comcast.net, jonathantanmy@google.com, jrnieder@gmail.com,
        emilyshaffer@google.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
In-Reply-To: <20191029003023.122196-1-matvore@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910310929130.46@tvgsbejvaqbjf.bet>
References: <20191029003023.122196-1-matvore@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rI/w2ncezmS8rTPPbpmB9+LU7TrbfszFeKWISTwCQYHNq8i6Quz
 ZkIuYWswy6PINzX3rYJSOUynTu8oYB1gE7CgfSjGDrXCJ8Dyk7vQwP+ART8acafDWxC5S+j
 PXdmkEsLUvUbqOY5jLyX4SJK65cGgzDiIvTjNRt5/GEM1FH7OP85qvNk4NfzY7wTypZikUV
 GBA561sfsWmgZwMEvPZnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kMQhptMKEkI=:lISPppIFQ0ICgGB93hLY2b
 wKJ43Fro8pW9nk+zMrzZnVSiVo8GmI6Vki/MZtxA1QoVzmW+VgTq/f2TE1OK6QdbE7oxi8DE0
 rFG57rTmaU8PYcj7IQMcWCyV+bsRP/I6/6yqXrYJqwJM/MSyhK2PTAWDfcLXA6+uP3TPmX0nl
 /ihl5H8V8pgD5TtTrXB4F8nJKa0NrrCtRGuwpiu9UTEPXdNsMIEf+fUtmCzu+iuJhZBKAw/Br
 XvaoztpUdM6GCWDX9EgrNjiaZLUhu+C1tZAT62auUTIukhyMRI5DIwiIesBhoiYfkrhaLteq7
 X4Qm5HRNdfGmwlevB0i/aD/2l+bjq+hap1vP5BU4LZ/xOcF/gj53sHGKFd59fXzQTdOKhIDQL
 KfQH2wCMnVcIPClkXOsuf4i17IX9o2GlUo3OZKSsvt8Cr317wnH1oIyCc0XerxQDrrWNsb+x4
 v8fhk/UwN6U6cg4ZKaWDWmJJDOG5NrlYQw6uZFU0WhBz0iOqmv2mapn0wtC8n/DkRQ4Tx9QBl
 8yw5RY3Tp6HvA0VHTw4MrRAXmBalo1ksXRUMASc3C3at/MGEXakV2QPQmdZlIor9ixYVMIxjg
 YzUldHPdY3l631raLRBJk/37YrEjNxjAU1eaSts0woOZ8a/bZt6cv46fqrllvzKWH73s7HmJb
 noIspKLhjKwDjEU0zh1e6CfHDGgrDrz1CbpcA1St4ez9Dlm/Ga4ky2YhScnBYmGPDMMw9hiZQ
 XQ1M8MjsLhEf+Cx5YtKgNSNHLxSWJEuclEI7kxXSkKVQYTIqxi6pD4t7OOx7piqI/V00LjC9j
 +WnNAAuyI0gm8FJtpPnJ67KK/aphva1OMImP+TeSX5JJMVMB8tkrFD3V8hzF5mAFidT/beatP
 vCW+uMoeYo/sCNLtCfvoZJGal4Kv8I9Fy8FoOhzJkFs23gMmeSxHy9dV5kcUHN1CcPHFdnhtA
 6ErecV4h9zRrNucpGCCgU7VtUxiDyoqdz+NiFmmPqLI4P/cwn7sxCrUuAJnSf4f8jksoeYW7s
 OCkbuFn58hXSzPTLJtJVGFyFd8UbxWXhQ/zXerNIU077dJejNaE2zGOwnpN0iT2ebjHP7VMHx
 F66Rz3VBTSYuql6TK0Bbrai/h35o+U3vFcCinnIK5nagOJ4EjqmF7pvMoCzGzhRa3q048nSjU
 VxEZAuUGOjtGFC6rkSQk9Eg6o5/69sSE163KTRBGWwCcknQqMFVYRaWg9Ect2YU8OIQE5utfM
 Mw/WpdCwOhm6CpW7zxK/Wc9iOVJICSMYSDf6JtUzGwLSWNU8jMzWoIN/7rdU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Mon, 28 Oct 2019, Matthew DeVore wrote:

> From: Matthew DeVore <matvore@gmail.com>
>
> "git xl" shows a graph of recent history, including all existing
> branches (unless flagged with a config option) and their upstream
> counterparts.  It is named such because it is easy to type and the
> letter "x" looks like a small graph.

I like to see first paragraphs of commit messages that peak my curiosity
or that excite me about what is to come. Alan Alda's advice for
scientists comes to mind: tell a story, and every story begins with a
relatable struggle, a struggle that the audience can allude to.

In this instance, the first paragraph could be improved in that respect,
I think.

In my worktrees, I usually have a few dozen branches that are in flight,
some of them demoted to lower priority after a brief period of intense
activity, and it would be really nice to have a command to see quickly
where I left off, in order of local activity, filtered by the branches
that are unpushed, showing their relationships (if any).

Any commit message with a first paragraph that describes such a
scenario, and then says that its patch is going to help me with it, will
_immediately_ have my full attention.

> Like "git branch" it supports filtering the branches shown via
> positional arguments.

Following up by an example would make this sentence easier to
understand.

And before even talking about options it supports, it might be a good
idea to illustrate the command with an example output.

> Besides just showing the graph, it also associates refs with all visible
> commits with names in the form of "h/#" where # is an incrementing
> index. After showing the graph, these refs can be used to ergonomically
> invoke some follow-up command like rebase or diff.

As I mentioned in my previous reply to Emily's answer, I think that this
would be a useful thing to have in `git log`, and it should therefore be
split out into its own patch, maybe even its own patch series.

> The test cases show non-trivial output which can be used to get an idea
> for what the command is good for, though it doesn't capture the
> coloring.

If the coloring is so helpful, then it should be tested, too, via
`test_decode_color`.

> The primary goals of this command are:
>
>  a) deduce what the user wants to see based on what they haven't pushed
>     upstream yet
>  b) show the active branches spatially rather than as a linear list (as
>     in "git branch")
>  c) allow the user to easily refer to commits that appeared in the
>     output

Aha! This motivation for the patch should have come a lot earlier.

It still is a bit unclear to me what "spatially rather than as a linear
list" means. Are you referring to the output of `git show-branch` vs the
output of `git branch`?

> I considered making the h/# tags stable across invocations such that a
> particular hash will only be tagged with a different number if ~100
> other hashes are tagged since the hash was last tagged. I didn't
> actually implement it this way, instead opting for always re-numbering
> the hashes on each invocation. This means the hash number is
> predictable based on the position the hash appears in the output, which
> is probably better that encouraging users to memorize hash numbers (or
> use them in scripts!).

Again, as I mentioned in my previous reply, this is not a thing for
scripts. Scripts to not have fingers, they don't need to type, and they
certainly do not tire of long, precise commit hashes.

The fact that the design calls for overwriting previously-generated refs
makes this really dangerous: what if the refs it overwrites were not
actually generated by this command, but were carefully generated
elsewhere?

> Omissions I might/will fix depending on feedback:
>
>  a) rather than show HEAD in the graph, show <checked_out_branch> when
>     possible (i.e. "[<master>]" rather than "[HEAD master]").

I don't quite understand. I guess this concern requires the reader to be
already familiar with the usage of this command, which would require me
to find a revision to which I can apply this patch, then compile locally
and run it. That's not what I expect of an RFC. Could you at least give
an example output here?

Having said that, I have the suspicion that you are talking about
decorating the commits with the applicable refs? The prior art would be
`(HEAD -> master)` as generated by `git log --decorate`.

>  b) don't parse output from `git log` but instead do everything
>     in-process.

Apart from the ephemeral refs (which would probably be useful in `git
log` to begin with, as I already stated), it would seem that at least
some of the ideas in this new command might be implemented better as new
modes in the log-tree machinery.

>  c) documentation

Indeed.

> diff --git a/t/t4400-xl.sh b/t/t4400-xl.sh
> new file mode 100755
> index 0000000000..f6e35bd4da
> --- /dev/null
> +++ b/t/t4400-xl.sh
> @@ -0,0 +1,270 @@
> +#!/bin/sh
> +
> +test_description=3D'git xl'
> +. ./test-lib.sh
> +
> +xl () {
> +	git xl "$@" >actual_raw &&


Would it not make more sense for the command itself to right-trim its
output already?

> +}
> +
> +test_expect_success 'basic' '
> +	test_commit foo &&
> +	git checkout -b branch2 &&
> +	test_commit bar &&
> +
> +	xl >actual &&
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&

It looks a bit fragile to use the generated `h/*` refs to verify the
output, and I am not sure that you want to force the abbreviation that
way rather than use the native `--short=3D8` option. It would be a better
idea to use something like

	h1=3D$(git rev-parse --short=3D8 bar) &&
	h2=3D$(git rev-parse --short=3D8 foo) &&

and after checking the output, verifying _independently_ that the `h/*`
refs were generated correctly, e.g.

	test_cmp_rev $h1 h/1 &&
	test_cmp_rev $h2 h/2

> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch2]
> +          | bar
> +          |
> +$hashvl2  *  2   committer@example.com  [master]
> +            foo
> +" >expect &&

I don't think that we ever use multi-line `echo` elsewhere in the test
suite, instead we seem to use `cat >expect <<-EOF &&` a lot. Maybe it
would be better to follow that convention than to invent a competing
one?

> +	test_cmp expect actual

Okay, so what is done _a lot_ in this test script is to generate the
output of `xl`, to write out the expected output, and then compare them.
Let's dry that up, following the example of `t/t3430-rebase-merges.sh`'
`test_cmp_graph` function:

test_cmp_xl () {
	cat >expect &&
	git xl "$@" >output &&
	sed "s/ *$//" <output >output.trimmed &&
	test_cmp expect output.trimmed
}

There. Much conciser, and you can even leave the right-trimming to the
script.

> +'
> +
> +test_expect_success 'specify ref names' '
> +	xl master >actual &&
> +
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&

Correct me if I am wrong, but it seems that these lines are repeated an
awful lot. Besides, as I said, they do not test precisely enough: if
`git xl` would display the wrong hashes here, and then store the same
wrong hashes in `h/*`, the test script would still pass.

A better way would be to use the _actually_ expected hashes, and to
assign them in an initial `setup` test case e.g.

test_expect_success 'setup' '
	test_commit foo &&
	foo=3D$(git rev-parse --short=3D8 foo) &&
	git switch -c branch2 &&
	test_commit bar &&
	bar=3D$(git rev-parse --short=3D8 bar)
'

This initial 'setup' test case is a well-established convention in Git's
test suite.

Of course, an even cleverer approach would make use of the fact that
`test_commit` uses the commit message as tag name, too, and let
`test_cmp_xl` _generate_ those hashes.

Only `baz7` seems to be committed via `git commit` directly and would
need a `git tag baz7`. It would need a `test_tick`, too, anyway...

> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD]
> +          | bar
> +          |
> +$hashvl2  *  2   committer@example.com  [master]
> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'deduce graph base' '
> +	git checkout -b branch3 master &&
> +	test_commit baz &&
> +	git branch -d master &&
> +	xl >actual &&
> +

Logically, the empty line should be between the set-up and the test,
i.e. _before_ the `xl` line.

> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	xl_base=3D$(git rev-parse xl_base | test_copy_bytes 8) &&

Wait, where does this `xl_base` come from?

> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch3]
> +          | baz
> +          |
> +$hashvl2  | *  2   committer@example.com  [branch2]
> +          |/  bar
> +          |
> +$xl_base  *  3   committer@example.com

Whoa. Why is this not called `h/3`? I must have read the commit message
wrong.

*goes-back-and-checks*

No, the commit message suggests that an incremental index (which is by
the way not a good terminology here, as "index" already means something
_very_ different in Git, "counter" would be a better term to use) is
used. Not `xl_base`.

And I think it would make more sense to stick with the `x/*` schema,
too.

> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'show upstream branch' '
> +	git init --bare upstream_repo.git &&
> +	git remote add upstream_repo upstream_repo.git &&
> +
> +	git push -u upstream_repo HEAD &&
> +	git branch --set-upstream-to=3Dupstream_repo/branch3 &&
> +	test_commit not_yet_pushed &&
> +
> +	# Exclude branch2 by requesting at least one other ref explicitly.
> +	xl branch3 >actual &&
> +
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch3]
> +          | not_yet_pushed
> +          |
> +$hashvl2  *  2   committer@example.com  [upstream_repo/branch3]
> +            baz
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'de-dupe upstream branches' '
> +	git checkout -b branch4 upstream_repo/branch3 &&
> +	test_commit baz4 &&
> +
> +	# Make sure we do not show the same upstream branch name twice
> +	# even though two local branches share the same upstream branch.

Wait, why?

> +	xl >actual &&
> +
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=3D$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=3D$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=3D$(git rev-parse h/5 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch4]
> +          | baz4
> +          |
> +$hashvl2  | *  2   committer@example.com  [branch3]
> +          |/  not_yet_pushed
> +          |
> +$hashvl3  *  3   committer@example.com  [upstream_repo/branch3]

Okay, it is shown here. Which is what I would expect. Why would it be
shown twice? Was there a bug in a patch iteration that was not sent to
the mailing list? I could understand that, but I would still phrase the
comment above "Make sure that each upstream branch name is shown only
once, even though multiple local branches share it as upstream branch."

> +          | baz
> +          |
> +$hashvl4  | *  4   committer@example.com  [branch2]
> +          |/  bar
> +          |
> +$hashvl5  *  5   committer@example.com
> +            foo
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'multiple merge bases' '
> +	git merge -m merge1 branch3 &&
> +	test_commit baz5 &&
> +
> +	git checkout branch3 &&
> +	git merge -m merge2 h/1 &&
> +	test_commit baz6 &&
> +
> +	git branch --unset-upstream branch3 &&
> +	xl branch3 branch4 >actual &&
> +
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=3D$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=3D$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=3D$(git rev-parse h/5 | test_copy_bytes 8) &&
> +	hashvl6=3D$(git rev-parse h/6 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch3]
> +          | baz6
> +          |
> +$hashvl2  *    2   committer@example.com
> +          |\  merge2
> +          | |
> +$hashvl3  | | *  3   committer@example.com  [branch4]
> +          | | | baz5
> +          | | |
> +$hashvl4  | | *    4   committer@example.com
> +          | | |\  merge1
> +          | |/ /
> +          | | /
> +          | |/
> +          |/|
> +$hashvl5  * |  5   committer@example.com
> +           /  not_yet_pushed
> +          |
> +$hashvl6  *  6   committer@example.com
> +            baz4
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'orphan branches' '
> +	# If there are some branches to display which do not have a common
> +	# ancestor with the other branches, we show them in a separate graph.
> +	git checkout --orphan branch-a h/6 &&
> +	git commit -m baz7 &&
> +	xl >actual &&
> +
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=3D$(git rev-parse h/3 | test_copy_bytes 8) &&
> +	hashvl4=3D$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=3D$(git rev-parse h/5 | test_copy_bytes 8) &&
> +	hashvl6=3D$(git rev-parse h/6 | test_copy_bytes 8) &&
> +	hashvl7=3D$(git rev-parse h/7 | test_copy_bytes 8) &&
> +	hashvl8=3D$(git rev-parse h/8 | test_copy_bytes 8) &&
> +	hashvl9=3D$(git rev-parse h/9 | test_copy_bytes 8) &&
> +	hashv10=3D$(git rev-parse h/10 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [HEAD branch-a]
> +            baz7
> +
> +$hashvl2  *  2   committer@example.com  [branch3]
> +          | baz6
> +          |
> +$hashvl3  *    3   committer@example.com
> +          |\  merge2
> +          | |
> +$hashvl4  | | *  4   committer@example.com  [branch4]
> +          | | | baz5
> +          | | |
> +$hashvl5  | | *    5   committer@example.com
> +          | | |\  merge1
> +          | |/ /
> +          | | /
> +          | |/
> +          |/|
> +$hashvl6  * |  6   committer@example.com
> +          | | not_yet_pushed
> +          | |
> +$hashvl7  | *  7   committer@example.com
> +          |/  baz4
> +          |
> +$hashvl8  *  8   committer@example.com
> +          | baz
> +          |
> +$hashvl9  | *  9   committer@example.com  [branch2]
> +          |/  bar
> +          |
> +$hashv10  *  10   committer@example.com
> +            foo
> +" >expect &&
> +	test_cmp expect actual &&
> +
> +	# Verify xl_base_# refs have been set correctly.
> +	test_cmp_rev xl_base_1 h/1 &&
> +	test_cmp_rev xl_base_2 h/10
> +'
> +
> +test_expect_success 'hide branches when branch.<branch-name>.no-xl is o=
n' '
> +	git checkout branch4 &&
> +	git config branch.branch-a.no-xl true &&
> +	git config branch.branch2.no-xl true &&
> +	xl >actual &&
> +
> +	hashvl1=3D$(git rev-parse h/1 | test_copy_bytes 8) &&
> +	hashvl2=3D$(git rev-parse h/2 | test_copy_bytes 8) &&
> +	hashvl3=3D$(git rev-parse h/3 | test_copy_bytES 8) &&
> +	hashvl4=3D$(git rev-parse h/4 | test_copy_bytes 8) &&
> +	hashvl5=3D$(git rev-parse h/5 | test_copy_bytes 8) &&
> +	hashvl6=3D$(git rev-parse h/6 | test_copy_bytes 8) &&
> +	hashvl7=3D$(git rev-parse h/7 | test_copy_bytes 8) &&
> +
> +	echo "\
> +$hashvl1  *  1   committer@example.com  [branch3]
> +          | baz6
> +          |
> +$hashvl2  *    2   committer@example.com
> +          |\  merge2
> +          | |
> +$hashvl3  | | *  3   committer@example.com  [HEAD branch4]
> +          | | | baz5
> +          | | |
> +$hashvl4  | | *    4   committer@example.com
> +          | | |\  merge1
> +          | |/ /
> +          | | /
> +          | |/
> +          |/|
> +$hashvl5  * |  5   committer@example.com
> +          | | not_yet_pushed
> +          | |
> +$hashvl6  | *  6   committer@example.com
> +          |/  baz4
> +          |
> +$hashvl7  *  7   committer@example.com  [upstream_repo/branch3]
> +            baz
> +" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_done

After reading through this script, I cannot fail to notice that the
committer is always the same, and repeated a gazillion times. It might
be more readable to use a shorter name, or to inject the email address
automatically in `test_cmp_xl`. Dunno.

In any case, there is a lot of room for DRYing up this test script.

> diff --git a/xl.c b/xl.c
> new file mode 100644
> index 0000000000..539e590f6b
> --- /dev/null
> +++ b/xl.c
> @@ -0,0 +1,485 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "color.h"
> +#include "commit-reach.h"
> +#include "config.h"
> +#include "oidmap.h"
> +#include "ref-filter.h"
> +#include "refs.h"
> +#include "refs/refs-internal.h"
> +#include "remote.h"
> +#include "run-command.h"
> +#include "strbuf.h"
> +
> +#include <errno.h>
> +#include <stdarg.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +static void set_ref(
> +	struct ref_transaction *ref_tr,

This is not how Git's source code is formatted. Please do not introduce
a new, contradicting convention.

> +	char const *name,
> +	const struct object_id *oid)
> +{
> +	struct strbuf err =3D STRBUF_INIT;
> +
> +	if (ref_transaction_update(ref_tr, name, oid, NULL, 0, NULL, &err))
> +		die("%s", err.buf);
> +
> +	strbuf_release(&err);
> +}
> +
> +struct hash_to_ref {
> +	struct oidmap_entry e;
> +
> +	struct ref_array_item **refs;
> +	size_t nr;
> +	size_t alloc;
> +};
> +
> +/* An array of ref_array_item's which are not owned by this structure. =
*/
> +struct ref_selection {
> +	struct ref_array_item **items;
> +	size_t alloc;
> +	size_t nr;
> +};
> +
> +static void populate_hash_to_ref_map(
> +	struct oidmap *m,

We could spell it out instead of using a single letter: it is a `map`.

> +	struct ref_selection *refs)
> +{
> +	size_t ref_i;

Why not just `i`? Why complicating things?

> +	for (ref_i =3D 0; ref_i < refs->nr; ref_i++) {
> +		struct hash_to_ref *h2r;
> +		struct ref_array_item *ref =3D refs->items[ref_i];
> +
> +		h2r =3D oidmap_get(m, &ref->objectname);
> +		if (!h2r) {
> +			h2r =3D xcalloc(1, sizeof(*h2r));
> +			oidcpy(&h2r->e.oid, &ref->objectname);
> +			oidmap_put(m, h2r);
> +		}
> +		ALLOC_GROW_BY(h2r->refs, h2r->nr, 1, h2r->alloc);
> +		h2r->refs[h2r->nr - 1] =3D ref;

Quite honestly, I would find it easier to read like it is done
elsewhere: use `ALLOC_GROW(... nr + 1 ...)` and then `...[nr++] =3D ...`.

I know, it is done this way _once_, in `list-objects-filter-options.c`,
but in the way I suggested twice in `alias.c`, once in `alloc.c`, once
in `apply.c`, and the list is actually quite long so I won't bore you
with the rest.

> +	}
> +}
> +
> +/*
> + * Helps invoke `git log` for a certain kind of graph format and proces=
s that
> + * output. One instance of this object lives for the entire invocation =
of
> + * `git xl` even if multiple disjoint graphs are included.
> + */
> +struct log_processing {
> +	struct strbuf raw_line;
> +	struct strbuf line_buf;
> +	struct strbuf line_prefix;
> +	struct strbuf sym_refs;
> +	struct strbuf tag_name;
> +
> +	struct child_process log_proc;
> +
> +	/* A buffered stream of the output of `git log` */
> +	FILE *stream;

Is it really worth the complexity to read from the stream, rather than
using `capture_command()`?

> +
> +	/*
> +	 * Number of hashes found and abbreviated since the first graph was
> +	 * started.
> +	 */
> +	size_t hash_count;
> +
> +	unsigned graph_count;
> +
> +	/*
> +	 * Maps object IDs to hash_to_ref objects which contain all the ref
> +	 * names that ref to the object.
> +	 */
> +	const struct oidmap *h2r;
> +
> +	/*
> +	 * All references that the user desires to be included in a graph. Thi=
s
> +	 * array may get resorted.
> +	 */
> +	struct ref_selection *refs;
> +
> +	/*
> +	 * Index pointing to the first element that has not been included in a
> +	 * graph yet.
> +	 */
> +	size_t ref_i;
> +
> +	/* Transaction for creating h/# and xl_base(_#) refs. */
> +	struct ref_transaction *ref_tr;
> +};
> +
> +#define LOG_PROCESSING_INIT { \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +	STRBUF_INIT, \
> +}
> +
> +static void log_processing_finish_proc(struct log_processing *p)
> +{
> +	int err;
> +
> +	fclose(p->stream);
> +	p->stream =3D NULL;
> +	err =3D finish_command(&p->log_proc);
> +	if (err)
> +		die(_("log failed or could not be terminated: 0x%x"), err);
> +}
> +
> +static void log_processing_release(struct log_processing *p)
> +{
> +	if (p->stream)
> +		BUG("last log stdout was not closed");
> +	strbuf_release(&p->raw_line);
> +	strbuf_release(&p->line_buf);
> +	strbuf_release(&p->line_prefix);
> +	strbuf_release(&p->sym_refs);
> +	strbuf_release(&p->tag_name);
> +}
> +
> +#define XL_HASH_PREFIX "<{xl_hash}>"
> +
> +/*
> + * Begins a `git log` sub process with a subset of the branches request=
ed.
> + *
> + * This log invocation shows a graph (using --graph) with full hashes. =
The
> + * hashes are prefixed with XL_HASH_PREFIX so they can get easily extra=
cted.

Since you are using the output using `--graph`, I agree that it is
better to capture and post-process the output of `git log`, at least for
now.

> + *
> + * This function also sets the xl_base or xl_base_# ref to the merge ba=
se of
> + * the branches included.
> + */
> +static int log_processing_start_proc(struct log_processing *p)
> +{
> +	size_t ref_i;

What's with these unnecessary `ref_` prefixes? If there is no other `i`
to be confused with, let's use `i`, plain and simple.

> +	size_t start_ref_i =3D p->ref_i;
> +	size_t end_ref_i =3D p->refs->nr;
> +	struct commit *merge_base;
> +
> +	if (p->ref_i =3D=3D p->refs->nr)
> +		return 0;
> +
> +	/*
> +	 * Split the p->refs[] sub array starting at start_ref_i into two
> +	 * sections, re-ordering if needed.
> +	 *
> +	 * The first section contains all commits which share a common ancesto=
r
> +	 * with p->refs->items[start_ref_i]. The second section contains all
> +	 * other commits. In the process, we determine the merge base of the
> +	 * subset. If there are multiple merge bases, we only keep track of on=
e.
> +	 * This is because `git log --graph <branch1...branchN>` only needs on=
e
> +	 * of the merge bases to intelligently limit the graph size.
> +	 *
> +	 * After the loop is complete, end_ref_i will point to the first item
> +	 * in the second section.
> +	 */
> +	merge_base =3D lookup_commit(

Again, please don't invent your own formatting rules that contradict the
existing source code's convention.

> +		the_repository, &p->refs->items[start_ref_i]->objectname);
> +	for (ref_i =3D start_ref_i + 1; ref_i < end_ref_i;) {
> +		struct commit *next =3D lookup_commit(
> +			the_repository, &p->refs->items[ref_i]->objectname);
> +		struct commit_list *clist =3D repo_get_merge_bases(

I could imagine that `merge_bases` would be a splendid name for what is
now called `clist`.

> +			the_repository, merge_base, next);
> +
> +		if (!clist) {
> +			/*
> +			 * The ref at ref_i does not share a common ancestor
> +			 * with the refs processed since start_ref_i. Move the
> +			 * ref at ref_i to the end of the refs array, and move
> +			 * the item already at the end of the array to ref_i.
> +			 * This allows us to postpone processing this orphan
> +			 * branch until the next `git log` invocation.
> +			 */
> +			struct ref_array_item *tmp =3D p->refs->items[ref_i];
> +			p->refs->items[ref_i] =3D p->refs->items[--end_ref_i];
> +			p->refs->items[end_ref_i] =3D tmp;

It would probably be a lot clearer to write

			SWAP(p->refs->items[ref_i], p->refs->items[end_ref_i]);
			end_ref_i--;

> +		} else {
> +			merge_base =3D clist->item;
> +			free_commit_list(clist);
> +			ref_i++;
> +		}
> +	}
> +
> +	p->graph_count++;
> +	if (!start_ref_i && end_ref_i =3D=3D p->refs->nr) {
> +		/* Only a single log graph in this invocation of `git xl`. */
> +		set_ref(p->ref_tr, "xl_base", &merge_base->object.oid);

So that's where the `xl_base` comes from.

I still would _much_ prefer the merge base to be labeled with just yet
another `x/*` ref. _Much_.

> +	} else {
> +		/* Multiple log graphs - use a counter to disambiguate bases. */
> +		struct strbuf xl_base_ref_name =3D STRBUF_INIT;
> +		strbuf_addf(&xl_base_ref_name, "xl_base_%u", p->graph_count);
> +		set_ref(p->ref_tr, xl_base_ref_name.buf,
> +			&merge_base->object.oid);
> +		strbuf_release(&xl_base_ref_name);
> +	}
> +
> +	child_process_init(&p->log_proc);
> +	p->log_proc.git_cmd =3D 1;
> +	p->log_proc.out =3D -1;
> +	p->log_proc.no_stdin =3D 1;
> +
> +	argv_array_pushl(&p->log_proc.args, "log", "--graph", NULL);
> +	argv_array_pushf(&p->log_proc.args, "--color=3D%s",
> +			 want_color(GIT_COLOR_UNKNOWN) ? "always" : "never");
> +	argv_array_push(&p->log_proc.args,
> +			"--format=3Dformat:" XL_HASH_PREFIX "%H  %ce\n%s\n ");

I wonder why we don't just use `%h` here. And `%d` for the decoration.

> +	for (ref_i =3D start_ref_i; ref_i < end_ref_i; ref_i++)
> +		argv_array_push(
> +			&p->log_proc.args, p->refs->items[ref_i]->refname);
> +	argv_array_pushf(&p->log_proc.args, "^%s^@",
> +			 oid_to_hex(&merge_base->object.oid));

Wouldn't it make more sense to use `^%s` and `--boundary`?

> +	argv_array_push(&p->log_proc.args, "--");
> +
> +	if (start_command(&p->log_proc))
> +		die(_("cannot start log"));
> +
> +	p->stream =3D xfdopen(p->log_proc.out, "r");
> +
> +	p->ref_i =3D end_ref_i;
> +
> +	return 1;
> +}

Okay, so far, it looks like the logic to determine the tips and the
merge bases could easily be folded into `revision.c` guarded by a new
option.  Good.

> +
> +static const char *color_on(const char *c)
> +{
> +	return want_color(GIT_COLOR_UNKNOWN) ? c : "";
> +}
> +
> +static const char *color_off(void)
> +{
> +	return want_color(GIT_COLOR_UNKNOWN) ? "\e[0m" : "";
> +}

Ugh. What's wrong with `GIT_COLOR_RESET`? Why hard-code an ANSI code
here?

> +
> +static void maybe_format_symrefs(
> +	struct strbuf *sym_refs,
> +	struct oidmap const *h2r,
> +	const struct object_id *oid)
> +{
> +	struct hash_to_ref const *h2r_entry;
> +	size_t ref_i;
> +
> +	h2r_entry =3D oidmap_get(h2r, oid);
> +
> +	if (!h2r_entry)
> +		return;
> +
> +	strbuf_addf(sym_refs, "  %s[", color_on("\e[1m"));
> +
> +	for (ref_i =3D 0; ref_i < h2r_entry->nr; ref_i++) {
> +		char *shortened_ref =3D shorten_unambiguous_ref(
> +			h2r_entry->refs[ref_i]->refname, /*strict=3D*/1);
> +
> +		if (ref_i)
> +			strbuf_addch(sym_refs, ' ');
> +
> +		strbuf_addstr(sym_refs, shortened_ref);
> +		free(shortened_ref);
> +	}
> +
> +	strbuf_addf(sym_refs, "]%s", color_off());
> +}

This looks a lot like the `--decorate` code. I wonder whether you can
avoid duplicating that logic and use `--decorate` (or `%d`) directly.

And if you cannot, how much effort it would be to teach the `--decorate`
machinery the (optional) tricks you want.

> +
> +static int process_log_line(struct log_processing *p)
> +{
> +	const char *in;
> +	size_t hash_prefix_len =3D strlen(XL_HASH_PREFIX);
> +
> +	strbuf_reset(&p->raw_line);
> +	strbuf_reset(&p->line_buf);
> +	strbuf_reset(&p->line_prefix);
> +	strbuf_reset(&p->sym_refs);
> +	strbuf_reset(&p->tag_name);
> +
> +	if (strbuf_getline_lf(&p->raw_line, p->stream) =3D=3D EOF)
> +		return 0;
> +
> +	in =3D p->raw_line.buf;
> +
> +	while (*in) {
> +		struct object_id oid;
> +		const char *after_hash;
> +
> +		if (p->line_prefix.len ||

Now I am curious what that `line_prefix` field serves. It is not clear
yo me, except that it basically prevents any parsing in
`process_log_line()` and instead adding each input line character by
character. I also see that this `line_prefix` is reset at the beginning
of this function and set later inside the loop. It's almost as if we
simply wanted to append the rest of the raw_line and `break;` at the end
of this loop.

Which makes the whole flow a little awkward.

Why not start the loop by

	size_t remaining =3D p->raw_line.len - (in - p->raw_line.buf);
	/* look for the commit hash */
	char *hash_prefix =3D memmem(in, remaining, XL_HASH_PREFIX, hash_prefix_l=
en);

	if (!hash_prefix) {
		strbuf_add(&p->line_buf, in, remaining);
		break;
	}

	/* copy everything before the commit hash prefix */
	strbuf_add(&p->line_buf, in, hash_prefix - in);
	in =3D hash_prefix + hash_prefix_len;

	if (parse_oid_hex(in, &oid, &after_hash)) {
		strbuf_add(&p->line_buf, hash_prefix, hash_prefix_len);
		continue;
	}

> +		    strncmp(XL_HASH_PREFIX, in, hash_prefix_len) ||
> +		    parse_oid_hex(in + hash_prefix_len, &oid, &after_hash)) {
> +			strbuf_addch(&p->line_buf, *in++);
> +			continue;
> +		}
> +
> +		p->hash_count++;
> +		strbuf_addf(&p->line_buf,
> +			    "%s %ld %s",
> +			    color_on("\e[48;5;213m\e[30m"),
> +			    p->hash_count,
> +			    color_off());
> +
> +		strbuf_addf(&p->line_prefix,
> +			    "%s%.8s%s",
> +			    color_on("\e[38;5;147m"),
> +			    in + hash_prefix_len,
> +			    color_off());
> +		in =3D after_hash;
> +
> +		strbuf_addf(&p->tag_name, "h/%ld", p->hash_count);
> +		set_ref(p->ref_tr, p->tag_name.buf, &oid);

If you split out the ephemeral refs and make them an optional part of
`git log`'s output, this should easily fall right into the `--decorate`
machinery's duties.

> +
> +		maybe_format_symrefs(&p->sym_refs, p->h2r, &oid);
> +	}
> +
> +	fprintf(stdout, "%8s  %s%s\n",
> +		p->line_prefix.buf,
> +		p->line_buf.buf,
> +		p->sym_refs.buf);
> +
> +	return 1;
> +}
> +
> +static void empty_hash_to_ref_map(struct oidmap *m)
> +{
> +	struct oidmap_iter i;
> +	struct hash_to_ref *h2r;
> +	oidmap_iter_init(m, &i);
> +
> +	while ((h2r =3D oidmap_iter_next(&i)) !=3D NULL) {
> +		FREE_AND_NULL(h2r->refs);
> +		h2r->alloc =3D 0;
> +		h2r->nr =3D 0;
> +	}
> +}
> +
> +static int add_ref(struct ref_array *refs, const char *name)
> +{
> +	struct object_id oid;
> +	size_t ref_i;
> +
> +	/* If we already have the ref, don't add it again. */
> +	for (ref_i =3D 0; ref_i < refs->nr; ref_i++) {
> +		if (!strcmp(refs->items[ref_i]->refname, name))
> +			return 0;
> +	}
> +
> +	if (get_oid(name, &oid))
> +		die("unknown object: %s", name);
> +	ref_array_push(refs, name, &oid);
> +
> +	return 1;
> +}
> +
> +static void select_ref(
> +	struct ref_selection *ref_sel,
> +	struct ref_array *refs,
> +	size_t ref_i)
> +{
> +	ALLOC_GROW_BY(ref_sel->items, ref_sel->nr, 1, ref_sel->alloc);
> +	ref_sel->items[ref_sel->nr - 1] =3D refs->items[ref_i];
> +}
> +
> +static void populate_branch_args(
> +	struct ref_array *refs,
> +	struct ref_selection *ref_sel,
> +	const char **argv)
> +{
> +	struct ref_filter filter =3D {0};
> +	size_t ref_i;
> +	size_t ref_i_end;
> +	struct strbuf no_xl_config_key =3D STRBUF_INIT;
> +
> +	filter.name_patterns =3D argv;
> +	filter_refs(refs, &filter, FILTER_REFS_BRANCHES);
> +
> +	ref_i_end =3D refs->nr;
> +
> +	/* Add upstream branches of each branch. */
> +	for (ref_i =3D 0; ref_i < ref_i_end; ref_i++) {
> +		struct branch *branch =3D branch_get(refs->items[ref_i]->refname);
> +		char *short_name;
> +		const char *upstream;
> +		int no_xl =3D 0;
> +
> +		if (!branch) {
> +			/*
> +			 * Not actually a branch, but might be HEAD. Select this
> +			 * ref for display.
> +			 */
> +			select_ref(ref_sel, refs, ref_i);
> +			continue;
> +		}
> +
> +		/*
> +		 * Do not show the branch or its upstream if user configured
> +		 * branch.<branch-name>.no-xl =3D true
> +		 */
> +		short_name =3D shorten_unambiguous_ref(
> +			branch->name, /*strict=3D*/1);
> +		strbuf_reset(&no_xl_config_key);
> +		strbuf_addf(&no_xl_config_key, "branch.%s.no-xl", short_name);
> +		FREE_AND_NULL(short_name);
> +
> +		if (!git_config_get_bool(no_xl_config_key.buf, &no_xl) && no_xl)
> +			continue;
> +
> +		select_ref(ref_sel, refs, ref_i);
> +		upstream =3D branch_get_upstream(branch, NULL);
> +
> +		/*
> +		 * Add the upstream branch if it has not been added as the
> +		 * upstream of some other local branch.
> +		 */
> +		if (upstream && add_ref(refs, upstream))
> +			select_ref(ref_sel, refs, refs->nr - 1);
> +	}
> +
> +	strbuf_release(&no_xl_config_key);
> +}

This part also looks as if it would be _very_ easy to put it into
`revision.c`, guarded by a new option.

The only thing we would need to be careful about is to clear the commit
markers after figuring out the merge base(s).

> +
> +int cmd_xl(int argc, const char **argv, const char *prefx)
> +{
> +	struct oidmap hash_to_ref_map =3D OIDMAP_INIT;
> +	struct ref_selection ref_sel =3D {0};
> +	struct ref_array refs =3D {0};
> +	struct strbuf ref_tr_err =3D STRBUF_INIT;
> +	struct ref_transaction *ref_tr;
> +	struct log_processing log_processing =3D LOG_PROCESSING_INIT;
> +
> +	git_config(git_color_config, NULL);
> +
> +	/*
> +	 * Add HEAD first. This way, if we output multiple graphs, the first
> +	 * one will include the currently checked-out ref.
> +	 */
> +	add_ref(&refs, "HEAD");
> +
> +	populate_branch_args(&refs, &ref_sel, argv + 1);
> +
> +	oidmap_init(&hash_to_ref_map, 16);
> +	populate_hash_to_ref_map(&hash_to_ref_map, &ref_sel);
> +
> +	if (!(ref_tr =3D ref_transaction_begin(&ref_tr_err)))
> +		die("%s", ref_tr_err.buf);
> +
> +	log_processing.h2r =3D &hash_to_ref_map;
> +	log_processing.ref_tr =3D ref_tr;
> +	log_processing.refs =3D &ref_sel;
> +	while (log_processing_start_proc(&log_processing)) {
> +		while (process_log_line(&log_processing)) {}
> +		log_processing_finish_proc(&log_processing);
> +	}
> +
> +	if (ref_transaction_commit(ref_tr, &ref_tr_err))
> +		die("%s", ref_tr_err.buf);
> +
> +	empty_hash_to_ref_map(&hash_to_ref_map);
> +	oidmap_free(&hash_to_ref_map, 1);
> +	ref_array_clear(&refs);
> +	ref_transaction_free(ref_tr);
> +	strbuf_release(&ref_tr_err);
> +	log_processing_release(&log_processing);
> +	FREE_AND_NULL(ref_sel.items);
> +
> +	return 0;
> +}
> --
> 2.19.0.605.g01d371f741-goog

Phew. What a long read.

Short summary of my impressions:

- The _idea_ is a very useful one. Or better put: the _ideas_:

	- There is the idea of ephemeral refs, and I think it is a good
	  one and it deserves its own patch or even its own patch
	  series, and _definitely_ it deserves being integrated into
	  `git log`!

	- The idea of generating the tips of the graph from the local
	  branches that have unpushed changes, and automatically
	  adding the merge base(s) as boundary commit(s). This deserves
	  its own, new option in `revision.c`, I would think.

- The patch mostly adds new code, in new files. This bears two problems:

	- The new code is so far away from the existing code that it is
	  all too easy to violate the formatting conventions without
	  even realizing, and that is quite the case.

	- Both the ephemeral refs as well as the tip/boundary selection
	  are performed at the wrong layer.

	  If they were done at the correct layer, the `git log` command
	  would _already_ gain a lot of benefits, independent of `xl`.

	  For example, a regular `git log` (with a to-be-introduced
	  option) would generate and show the ephemeral refs. I would
	  even go so far as to introduce a config option to make that
	  automatic as long as outputting to a pager, that's how useful
	  I would find this feature, personally.

	  I could also imagine that introducing those features at the
	  correct layer (`revision.c`, in both cases, I believe) would
	  make it possible to reduce `git xl` to a simple Git alias that
	  merely launches `git log` with a bunch o' options.

Thank you for starting work on this. I hope, out of purely selfish
reasons, that you will follow through and make these two ideas a reality.

Ciao,
Dscho
