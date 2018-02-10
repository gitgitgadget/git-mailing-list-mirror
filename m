Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B37A1F404
	for <e@80x24.org>; Sat, 10 Feb 2018 21:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBJVtf (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 16:49:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:44089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbeBJVte (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 16:49:34 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0Lb90f-1f8eAE1YPR-00kdK7; Sat, 10 Feb 2018 22:49:23 +0100
Date:   Sat, 10 Feb 2018 22:49:19 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] sequencer: introduce new commands to reset
 therevision
In-Reply-To: <cba8d5dc-f42d-8412-c471-edb5a860b3ae@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1802102248590.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de> <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de> <CAGZ79kYK9H88HRLKBFs+OatYMVVqmc1WOsTbaUbaK9yW0Sqqrg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801311411040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <cba8d5dc-f42d-8412-c471-edb5a860b3ae@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:skFjFcZj50ajS00a8JfHCSZbIzredchZrvATIc/qTYcGPRP5Z3e
 qzPpXwfrJEHcqPnybRb7TG77z7WqlcDZsw4P3/UQhDtTfLwGuqd7DrGiV3gwz9Yr0K9tDuX
 usHs0bKK5McbTG2+1WNywun649yW/b9Tt8ulAP1jqlV+1Ih3k/rxZuDJTE3m9V90bNkznbc
 k3iblMtdUi3x0sBLBIRPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:29OYTD04TJ0=:ymNIs3E7Ja2n3Ik3BG7/+L
 BFDUEwmk5OcTUe9jcVhHbiJOxprxw+cNPLdBsefqqznXMhd5s+1c6dtGUJqBgU2nYbqhxMjV2
 l4eRhcVZnt769jdlB8NgCCOVqUbk4GmGto8GXHSRSk2pLdBBLgmlXCQZkVharfyebFNa0LOao
 Gfg9FHdPsdGY81KSfI2tK69ISzp71zvGJYXbPl/ZbnU5M+8/ZJ9lb3YDkvHABEVVfkGdS2VQe
 s+AGiv0z9hnl/jxQ07B8bLVAS4fPvmHMO7KX5CYCTuzwh3+wgOINVVxa2kNNWoIOhCji4bnPP
 cF+cYqLtT9EFB/zk8CyCp2OTaKDevL0moTfpO3bLH738ebptVU1WCAfo2U/hGFX/wY6N96hqo
 3CN5FgzIc9iVr7yKtN1TNvmKWvRNsayTijHo55iI9IVCtYGfthwLXHLOP1SqS7yaN91yYsKYW
 9spD9CK5AN0hIrQY36mk5zPYO7jXrp6wADC/dBRV/6ISDm5sxkJCQB0qj3Uulya+BRxDyGFe0
 2gsihfniK7Db4+yFVaeMAOVBQ7HUJX59GfFtb6IzvM6RVxvMbHyjN6S+Dkg4ltxWQiK3MZmxS
 mwtzo6BcgzgD6G84siJVMbcyXxZsQh2AlbH8kt1CQiB+T8WxsYH4NIohf56hX2outNmcV16xb
 WI++o64GZVFHmtDTNsAjjzJ6hzqCF5iqhkpCjyT0gcMszUiYdUOCEqAjuS+/AVDM+vrBvgqNx
 cGEQf6FZjt4NjGcCa11g0V5uHsSiz87kR0yWPeqP3yk5gvxzgcZJKlmIGSxgTSxD0KUEvhSGL
 D10aaysMNcsuB/U7uAI7SmgiQu4niHdGg7SZfSgRV+DC2KaT6o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 31 Jan 2018, Phillip Wood wrote:

> On 31/01/18 13:21, Johannes Schindelin wrote:
> > 
> > On Tue, 30 Jan 2018, Stefan Beller wrote:
> > 
> >> On Mon, Jan 29, 2018 at 2:54 PM, Johannes Schindelin
> >> <johannes.schindelin@gmx.de> wrote:
> >>> @@ -116,6 +118,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
> >>>  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
> >>>  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
> >>>         "rebase-merge/rewritten-pending")
> >>> +
> >>> +/*
> >>> + * The path of the file listing refs that need to be deleted after the rebase
> >>> + * finishes. This is used by the `merge` command.
> >>> + */
> > 
> > Whoops. The comment "This is used by the `merge` command`" is completely
> > wrong. Will fix.
> > 
> >> So this file contains (label -> commit),
> > 
> > Only `label`. No `commit`.
> > 
> >> which is appended in do_label, it uses refs to store the commits in
> >> refs/rewritten.  We do not have to worry about the contents of that file
> >> getting too long, or label re-use, because the directory containing all
> >> these helper files will be deleted upon successful rebase in
> >> `sequencer_remove_state()`.
> > 
> > Yes.
> >
> It might be a good idea to have 'git rebase --abort' delete the refs as
> well as the file though

That makes sense. I made it so.

Ciao,
Dscho
