Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351F31F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 10:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfJaKib (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 06:38:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:47143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfJaKib (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 06:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572518309;
        bh=9T5XOHFOc0/IPLO4vS4sOFtUPMqMP8Nyn0+1Dhw86I8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kb2TRx0qaF4i2+Ect+91MHBYKD1TIxTsdDRpdL7TrT2oCXJlaXtyKgFc8t1tHL606
         +pXTR+IfBrKAOqXKOsHe/XSWe6pxL7EJ0YF55mkBGMknnu5pXbsgaoE/Qmd/SzVLB8
         95oidp0I41uvZpslhenx5abXlLfJifDB2blchZBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1iggnI3I0S-00L0sM; Thu, 31
 Oct 2019 11:38:28 +0100
Date:   Thu, 31 Oct 2019 11:38:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] sequencer: reencode to utf-8 before arrange rebase's
 todo list
In-Reply-To: <20191031092618.29073-4-congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910311134011.46@tvgsbejvaqbjf.bet>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <20191031092618.29073-4-congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:H1IZIsqSVl2LKKQIsrh8PHaXBAUiSTQekMHWlt6zeg0S5oCLK1Y
 6MRVGzInJ/N2M8KSg91w/J3Pge62V//rRp+e6CYl0eBzpf21G4ANmUAXxHWwGSHBGqfFtkQ
 johywFBQGeAaEhaNPX463XmH/IwbAt0sEN3aSkdkE3awUd7BTAzYWu0jo/wtqigU5+YFkxv
 Id9/s260n/10FzWZ9LRdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yt5O6aFHsEk=:a8tN/aDSdqsVznSmLa35Q6
 TeV6SDrRw8vd0gY7In+bGbxPQmNe+Kd7P/CSWisbC7gz1P0Pmb6sYXv6BV7w+wcDbLJfi7YZr
 Uc7ZQ8nhbHqZvn2qnF9r4Sti2gHWGvD8BA18kGmucUZNO+1Yjg3MfRUdMPlbuXraWmlj3BOcy
 RnQ3eysiTOxgwACAL2+HrdZ0PChZ6Hex0ZEygA6Rv1nGTKI/B8h452DEnT9/AbCUGkXbfIIM2
 tbos/xkMz2/8jqrSEc8F7ODugZDDLDmfzS0rvWlBkvGVXOhpgss8C1jwIDTE6qNgnqBpZm+iE
 J/OqwjFI4VwSwA8d7SRNVr4NzaZAnowwQhIiOwTdjCo3wy3aVhBQbo/eCqVBedcA6mnxWIjmC
 1Gp58i4VfTEugCBZHLfhg3V021cuwatnjVf/o7G6fHjcREUC4d51n1bs3VoyKytwQ3jVma5lf
 EA4tV8yWzHyUaapFGw1n3t6mfXGyArizFBEvcU7U//jaaPujUUbq94CtDqwvi18vkV8uelyTn
 6WqLjwy2ErZV1uMQaF89USWtVoDfJ/fCMY3/iGE6ULjjfZLylhdn0Y4NdkJrSM3lIyBix/mFI
 k5vB2ovN2q2hOmVuS/jPicSChTBFjmRucjIPnoV3MrG7iwB05RDwfBdDfmm1uvDVQJT/xR9TI
 4tRcM8UQYia6c4f4QYLo3+4Ltn3Sv1zsapWas3u175SbpzzT7tk4XkwGAhZySTQ9bygU/Sh+T
 Ed9nfC12xJClYpOHIm4v0ZDj4/xvExTQY8oVeMJM7REL8xAn+bx5JQ4BunEzihAUoPH6gF9rM
 fnblsUIFghE1hZ8CYRrpmTff2A4lo/dwPEDt1F+wLqUKRC8p66zeEt+VXJbKHsjlbOFfy24Ek
 l3ZevQlZ01TlluHY3huEY2IlCcrS3YLBSXSG5CiiODqEfwq7wNN4KhhbSkhZk6SZxjrUhk3bJ
 o/gSt5bp5cVzXgJzatKd7CY77/fxsUoQihxq9Vou8u0m5Uu+HbhQaQxdkQmac7Fuf6QqgvP0L
 g1gPc5SPtDkZheUNYbvlM77qrJZ+TTBeGWa/Ve61bVMN+wdzVF8vEyrJ7rwrk/KEnWBPBKfHs
 91gp4/qlbe+CgN8LDnsw5eMuLPAFr82mve9n18NB/GFrQswYdmrTBebnu55hjXWVA5aXGEBBF
 M6ooriyyMmymB9vYyL28yly2EOivWReGPjke5hnBRgfK4+A+FC4im2N6R0YBVjD6NIJIrmIDk
 LcTly0QbGayakM+t3W1hGcwFUmHz+xnIArUFSBGnCqfBdIEhQE88uXOT9mAY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Thu, 31 Oct 2019, Doan Tran Cong Danh wrote:

> On musl libc, ISO-2022-JP encoder is too eager to switch back to
> 1 byte encoding, musl's iconv always switch back after every combining
> character. Comparing glibc and musl's output for this command
> $ sed q t/t3900/ISO-2022-JP.txt| iconv -f ISO-2022-JP -t utf-8 |
> 	iconv -f utf-8 -t ISO-2022-JP | xxd
>
> glibc:
> 00000000: 1b24 4224 4f24 6c24 5224 5b24 551b 2842  .$B$O$l$R$[$U.(B
> 00000010: 0a                                       .
>
> musl:
> 00000000: 1b24 4224 4f1b 2842 1b24 4224 6c1b 2842  .$B$O.(B.$B$l.(B
> 00000010: 1b24 4224 521b 2842 1b24 4224 5b1b 2842  .$B$R.(B.$B$[.(B
> 00000020: 1b24 4224 551b 2842 0a                   .$B$U.(B.
>
> Although musl iconv's output isn't optimal, it's still correct.
>
> From commit 7d509878b8, ("pretty.c: format string with truncate respects
> logOutputEncoding", 2014-05-21), we're encoding the message to utf-8
> first, then format it and convert the message to the actual output
> encoding on git commit --squash.
>
> Thus, t3900 is failing on Linux with musl libc.
>
> Reencode to utf-8 before arranging rebase's todo list.

Since the re-encoded commit messages are only used for figuring out the
relationships between the `fixup!`/`squash!` commits and their targets,
but are not used in any of the lines that are written out, this change
looks good to me.

In fact, all three patches look good to me.

Thanks for unbreaking Git with musl!
Johannes

>
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---
>
> Notes:
>     The todo list shown to user has already been reencoded by sequencer_=
make_script,
>     without this patch it looks like this:
>
>     $ head -3 .git/rebase-merge/git-rebase-todo | xxd
>     00000000: 7069 636b 2065 6633 3961 3033 201b 2442  pick ef39a03 .$B
>     00000010: 244f 1b28 421b 2442 246c 1b28 421b 2442  $O.(B.$B$l.(B.$B
>     00000020: 2452 1b28 421b 2442 245b 1b28 421b 2442  $R.(B.$B$[.(B.$B
>     00000030: 2455 1b28 420a 7069 636b 2062 3832 3931  $U.(B.pick b8291
>     00000040: 3336 2073 7175 6173 6821 201b 2442 244f  36 squash! .$B$O
>     00000050: 1b28 421b 2442 246c 1b28 421b 2442 2452  .(B.$B$l.(B.$B$R
>     00000060: 1b28 421b 2442 245b 1b28 421b 2442 2455  .(B.$B$[.(B.$B$U
>     00000070: 1b28 420a 7069 636b 2062 3532 3132 6437  .(B.pick b5212d7
>     00000080: 2069 6e74 6572 6d65 6469 6174 6520 636f   intermediate co
>     00000090: 6d6d 6974 0a                             mmit.
>
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 9d5964fd81..69430fe23f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5169,7 +5169,7 @@ int todo_list_rearrange_squash(struct todo_list *t=
odo_list)
>  		*commit_todo_item_at(&commit_todo, item->commit) =3D item;
>
>  		parse_commit(item->commit);
> -		commit_buffer =3D get_commit_buffer(item->commit, NULL);
> +		commit_buffer =3D logmsg_reencode(item->commit, NULL, "UTF-8");
>  		find_commit_subject(commit_buffer, &subject);
>  		format_subject(&buf, subject, " ");
>  		subject =3D subjects[i] =3D strbuf_detach(&buf, &subject_len);
> --
> 2.24.0.rc1.3.g89530838a3.dirty
>
>
