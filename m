Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A6E20401
	for <e@80x24.org>; Wed, 14 Jun 2017 08:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbdFNIg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 04:36:56 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44653 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754175AbdFNIgv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Jun 2017 04:36:51 -0400
X-AuditID: 12074413-d93ff7000000742e-08-5940f59ed375
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 35.7C.29742.E95F0495; Wed, 14 Jun 2017 04:36:49 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCBFA.dip0.t-ipconnect.de [87.188.203.250])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5E8aiUi021105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 14 Jun 2017 04:36:45 -0400
Subject: Re: [BUG] b9c8e7f2fb6e breaks git bisect visualize
To:     "=?UTF-8?Q?=c3=98yvind_A._Holm?=" <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>
References: <20170614000630.44uctc5y7dyyleqy@sunbase.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
Date:   Wed, 14 Jun 2017 10:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170614000630.44uctc5y7dyyleqy@sunbase.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvwq0OkwaSXZhZdV7qZLBp6rzBb
        TDiygsXiUd9bdgcWjxMzfrN4XLyk7HF3Qg+Lx+dNcgEsUVw2Kak5mWWpRfp2CVwZZ+dEFfxU
        rDg66Sh7A+NumS5GTg4JAROJNecfM3cxcnEICexgkng/6yAjhHOBSaJ//QpGkCphAWuJGRu3
        s4LYIgJZEkdPLmcCsYUELCU6rm5gA7HZBHQlFvU0g8WZBeIlZhx6A2RzcPAK2Etsbg0ACbMI
        qErMvfIWbKSoQITEw85d7CA2r4CgxMmZT1hAbE4BK4nfszewQoxRl/gz7xIzhC0v0bx1NvME
        Rv5ZSFpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQkBXe
        wbjrpNwhRgEORiUe3gfv7SOFWBPLiitzDzFKcjApifLWb3aIFOJLyk+pzEgszogvKs1JLT7E
        KMHBrCTCK3EeKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuAV+QLU
        KFiUmp5akZaZU4KQZuLgBBnOAzR87jOQ4cUFibnFmekQ+VOMilLivG0gzQIgiYzSPLheWEp5
        xSgO9Iow73OQKh5gOoLrfgU0mAlocNAFsMEliQgpqQbGtqcWk5tOxf1XV5Bz98zJeNttsWS+
        mcLaSSsvhRYxnNgv2jjbLTIgwVtMbW+sx5lDuXrbw46JtZ7k0Gh026zytOFa0Mpfurt3HFoR
        2nDkW+HTJ7xG37r5fjOXP1p4RG1ienHw2pzUo//f33z8dc55yb2Z5bylJ8KPTmZ+s2H3Qqtk
        ZWtVht2nlViKMxINtZiLihMBVQc4RAQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14/2017 02:06 AM, Øyvind A. Holm wrote:
> Commit b9c8e7f2fb6e ("prefix_ref_iterator: don't trim too much") breaks 
> git bisect visualize, this reproduces the bug:
> 
>   $ git bisect start
>   $ git bisect bad
>   $ git bisect good HEAD^^
>   $ git bisect visualize
>   fatal: BUG: attempt to trim too many characters
>   $
> 
> Reverting b9c8e7f2fb6e makes git bisect visualize work again.

Thanks for the bug report.

The same error occurs if the last step is simplified to

    git log --bisect

The corresponding stack trace is

#0  prefix_ref_iterator_advance (ref_iterator=0x91c5a0) at
refs/iterator.c:305
#1  0x000000000054edd7 in ref_iterator_advance (ref_iterator=0x91c5a0)
    at refs/iterator.c:13
#2  0x000000000054f62f in do_for_each_ref_iterator (iter=0x91c5a0,
    fn=0x56337a <handle_one_ref>, cb_data=0x7fffffffcdb0)
    at refs/iterator.c:382
#3  0x0000000000546a40 in do_for_each_ref (refs=0x8ce3c0,
    prefix=0x8c1af0 "refs/bisect/bad", fn=0x56337a <handle_one_ref>,
trim=15,
    flags=0, cb_data=0x7fffffffcdb0) at refs.c:1298
#4  0x0000000000546b2d in refs_for_each_ref_in (refs=0x8ce3c0,
    prefix=0x8c1af0 "refs/bisect/bad", fn=0x56337a <handle_one_ref>,
    cb_data=0x7fffffffcdb0) at refs.c:1319
#5  0x0000000000546bf9 in for_each_ref_in_submodule (submodule=0x0,
    prefix=0x8c1af0 "refs/bisect/bad", fn=0x56337a <handle_one_ref>,
    cb_data=0x7fffffffcdb0) at refs.c:1340
#6  0x0000000000566842 in for_each_bisect_ref (submodule=0x0,
    fn=0x56337a <handle_one_ref>, cb_data=0x7fffffffcdb0, term=0x8ce600
"bad")
    at revision.c:2083
#7  0x0000000000566885 in for_each_bad_bisect_ref (submodule=0x0,
    fn=0x56337a <handle_one_ref>, cb_data=0x7fffffffcdb0) at revision.c:2090
#8  0x0000000000563541 in handle_refs (submodule=0x0, revs=0x7fffffffd210,
    flags=0, for_each=0x566856 <for_each_bad_bisect_ref>) at revision.c:1196
#9  0x0000000000566a09 in handle_revision_pseudo_opt (submodule=0x0,
    revs=0x7fffffffd210, argc=1, argv=0x7fffffffdd28, flags=0x7fffffffcf44)
    at revision.c:2125
#10 0x000000000056711e in setup_revisions (argc=2, argv=0x7fffffffdd20,
    revs=0x7fffffffd210, opt=0x7fffffffd1f0) at revision.c:2247
#11 0x0000000000448ce4 in cmd_log_init_finish (argc=2, argv=0x7fffffffdd20,
    prefix=0x0, rev=0x7fffffffd210, opt=0x7fffffffd1f0) at builtin/log.c:168
#12 0x0000000000448f53 in cmd_log_init (argc=2, argv=0x7fffffffdd20,
    prefix=0x0, rev=0x7fffffffd210, opt=0x7fffffffd1f0) at builtin/log.c:220
#13 0x000000000044a37f in cmd_log (argc=2, argv=0x7fffffffdd20, prefix=0x0)
    at builtin/log.c:692
#14 0x0000000000405983 in run_builtin (p=0x870158 <commands+1176>, argc=2,
    argv=0x7fffffffdd20) at git.c:371
#15 0x0000000000405bed in handle_builtin (argc=2, argv=0x7fffffffdd20)
    at git.c:572
#16 0x0000000000405d62 in run_argv (argcp=0x7fffffffdbdc,
argv=0x7fffffffdbd0)
    at git.c:624
#17 0x0000000000405f04 in cmd_main (argc=2, argv=0x7fffffffdd20) at
git.c:701
#18 0x0000000000498ba6 in main (argc=3, argv=0x7fffffffdd18)
    at common-main.c:43

The code for `git log --bisect` is questionable. It calls
`for_each_ref_in_submodule()` with prefix "refs/bisect/bad", which is
the actual name (not a prefix) of the reference that it is interested
in. So the callback is called with the empty string as path, and that in
turn is passed to a variety of functions, like `ref_excluded()`,
`get_reference()`, `add_rev_cmdline()`, and `add_pending_oid()`. I'm not
sure whom to ping; the code in question was introduced eons ago:

    ad3f9a71a8 Add '--bisect' revision machinery argument, 2009-10-27

It seems to me that we should add a `for_each_fullref_in_submodule()`
and call that instead. I'll submit a patch doing that, though I'm not
certain that no new problems will arise from the callbacks getting full
rather than trimmed reference names (also for "refs/bisect/good").

Another possible orthogonal "fix" is to make the refs side tolerate
being asked to trim a refname down to the empty string, while still
refusing to trim even more than that. I'll also submit a patch to that
effect.

Either of the patches fix the issue that was reported and pass the whole
test suite (except for t1308, which seems to be broken in master for
unrelated reasons).

Michael

