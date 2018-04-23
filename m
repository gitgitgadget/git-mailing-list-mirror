Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D4F1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 12:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeDWMVO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 08:21:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:42021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754788AbeDWMVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 08:21:09 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkTSx-1eZJZI1YbL-00cQAS; Mon, 23
 Apr 2018 14:20:59 +0200
Date:   Mon, 23 Apr 2018 14:20:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
In-Reply-To: <b05915e6-2259-5dee-69d8-90a5a524662d@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804231405230.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de> <b05915e6-2259-5dee-69d8-90a5a524662d@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:11Mma5IVjznuI1a4QlygyOtGctlg9tX3XHkTaFFxhY+pMOtmF2b
 OhoekdGv+IENxAOJoELMyyTDKFvNlpXf2js0EDqb10YQzD9v8SmK/YJD2SHOg0sCnKBgyat
 OeBm4kWQUsEBchdXA7Gve+04EYZC3B8LRpUw1vHwUTf+RTLoQ+Rb7b87qL78yP9tJZV1XVp
 TNzUmoWiMT1ipF+PwNgaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8DMKcrDYgbc=:ZhnbyJzoRN89hY6VHgwnIQ
 73tKrQdXU0uYduGb0oAJjl/+KDaSvacGhhh+ZXZtFIi1Zhn6511hNVArlEsGU+5JSjK/SS6LG
 eecKTCka2TwasFfBeWqsV+MdbkABoj81hzu+egPC3YpTY4v0sY73eKRIwS9qzxiE10ApCYJB6
 S90sZnaFGLG7CvmwGd8NXorQqhHC4D0KsN8lO6RBxkkONSDCemlJUMfyzk845+Oc0aAbU9fo7
 eYkefnmfpbW/wO5VKd41OLPOTN26pCeAPZZIvA/ydJ4+VlPnjQEQEXo/XcuNT+b/vITOH44gp
 FtzP3RKy1CDq65p395haShezTflfFuTX3zu1C+QXGIsFKr7+JAW4/U0tgbH9CT1Qjs97r28Xs
 /H8d4sTWdo6bpoONQ3PDdCm5FaxNai/y7h42Em0QoAwWgEHMMWGIbsrBEK1PmexRx5DyjUfNQ
 7qyBQYbbANrl5aqUkWTobVKSX42l676FVdUbgtKRFPf+xKT9yfMyDjElKrQ+KbhuvOItFQ/X7
 heF5gPl+tRPW5bUNk1cx2HBkOz2upsK3U5rgwvNjfc/6dm8utIlACpq/AUqw//jZEvTot4SBi
 UHxuZdK391MXMSs2i6v9tmNcw+JnNUQ2A5bWM81V8066BcBGGhNwxmdv82Rp0eM+pkY13Owg4
 IQYsz7ny0vYUrHTjAwCaOmiSpDT/Vr1fO4i/hKv/giu4W6M+HryLM97od5I+Z+nN++gp5pSmE
 Zh8EXsebdKPr9FuqwQ+syOaAasRxo2F3nb111Q+blnMDDzLt3LIJbRQLAmnucnqSR+B1D8elX
 IKVJR8WCp4lkNltj2DDv4FqIgcpatPOsHz7xXBv2D+eXqIIfKA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sat, 21 Apr 2018, Phillip Wood wrote:

> On 21/04/18 11:33, Johannes Schindelin wrote:
> > This patch is part of the effort to reimplement `--preserve-merges` with
> > a substantially improved design, a design that has been developed in the
> > Git for Windows project to maintain the dozens of Windows-specific patch
> > series on top of upstream Git.
> > 
> > The previous patch implemented the `label` and `reset` commands to label
> > commits and to reset to labeled commits. This patch adds the `merge`
> > command, with the following syntax:
> 
> The two patches seem to have been fused together in this series.

Indeed. I have yet to investigate further how that happened, it could be a
bug in my series after all.

> If the reset command fails because it would overwrite untracked files it
> says
> 
> error: Untracked working tree file 'b' would be overwritten by merge.
> 
> Followed by the hint to edit the todo file. Saying 'merge' rather 'reset' is
> possibly confusing to users. Perhaps it could call
> setup_unpack_trees_porcelain(), though that would need to be extended to
> handle 'reset'.

Yes, and it changes global state :-(

Maybe we can leave it as-is for now? After all, it should be clear to the
user what is happening. The most important part is the "Untracked working
tree file"...

> Also it currently refuses to overwrite ignored files which is either
> annoying or safe depending on one's point of view.

Let me think about that. My gut feeling says: if it is easy to do, then
let's nuke ignored files, but keep untracked files. But I do not think
that the unpack-trees machinery was taught to know about .gitignore...

Seeing as `label` and `reset` really are mostly about revisions we see
along the lines, I think that the common case will *not* overwrite any
untracked files, ever. You would have to use `reset` on a
not-previously-seen commit and/or add `exec` commands designed to
interfere with the `reset`.

So I tend to want to not bother with discerning between untracked and
ignored files here.

Ciao,
Dscho
