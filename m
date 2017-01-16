Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2EC1F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbdAPAlO (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 19:41:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:58434 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdAPAlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 19:41:13 -0500
Received: from [192.168.178.43] ([88.71.187.213]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeLKt-1c4VPM2BPr-00QCUC; Mon, 16
 Jan 2017 01:41:03 +0100
Subject: Re: [RFC] stash: support filename argument
To:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20170115142542.11999-1-t.gummerer@gmail.com>
 <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, kes-kes@yandex.ru
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <c0d46a97-b1c0-d9c9-e475-28e0368ac61f@gmx.net>
Date:   Mon, 16 Jan 2017 01:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:aDhYoUgjxkCJ1dzq7zR0ToROmhe+H+Oia3723zTuZ05D8D77wQa
 psGRtD9jgoAMX37lGM8x6WUtxYQPPFoCfWk1+ozroOA30K+XzMaEmVbslVQd7HaLQST0xbm
 3zuRiXeYcAdYEl9hbhHxCRmbYe4juIb+T83QkLKcWq7CnS//LbGNfGNcn4LZ+zgPeCnHHuM
 VptTznk8182L458XAjPNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kpUeaUHdBdM=:rxYxaNpjlPxCUoe4G/oKtr
 G4YaNGnzUXmLCzOREGfY0rczbKRLdZEdCEB1VmhOIQ8jrBhFF/mc8QnKy6gA++ARt2VsQnFRj
 rbdVuaeZYQEv1pxx5fx28l8az/y6AEArW5pVqdHW2WgEJfnihwnv/g+b5mDBjbMNIfrLoc/et
 WfLsZ1pCpfSe9mxq+SP4LEPG23gV1kOiPay68KQb9rEBEWEatvFai3yghZSTYmXkPZ4VzE/sl
 25b0SKcYHPIDW61hvrMdiB+kPEaTvVk5wjpYEveTgpG0iPcE7Tpp9TgpEMQ+L615Dt7/nVSl5
 WUh1ZbX/8uOUJ6G3/wjkGL1uLultEtqJYF7870EaVO4tu0MBXSJkP9Y4ag47rJeBDK+eujX/r
 S+9xjYQEu4m1Wf9TueUpJG57bV+4+4CblSAABgwlVptxuuj2WObj+nnE8FTbinJ2hxmVYoLDL
 Sjs4AyI3bLkwXdSXu5uJD2JhHMDozq84OEjKVtOyVhLGEpkZ79oyZbRgtk8ig4HUy1Yrpy6VP
 MlY0TuJhKEhhLpKkcsIVew7V6AhIOTI8749H9VyQwG8UWvFu3ySxoo2o+9afkrOhMEb6IyPqr
 XEsc/AdI72X+fOGyq0Rtlc2IURdnZvNtw+uOYpYDJw/UNY6tkxhB35kP2BsCKMhc/ibZWl8Xr
 +ZVmHmGxebOllneZDk+YAGsk3kFjn1pLKFrbGBA9o30pmeFkmf19P8DHxXu8eUirpkj00sSm6
 n8BRDdgfBaYwq+5dcSXjcnqeKWnPaaqN659APyAjjDYCwIz5Y/WFUQJSrDJQ7FPbKnCwRbcL9
 MK/P3k7HLyFGIuLM5YnNXv1pfdkINSJ48O5NwWeCFCNHMTalVYAXQrA+XnfE/ZN4fZ0QaoGRC
 vXW7vUQM7kfV1s5zQe7jQvjmHNGbC0md6caHRt517WuZtS46ez2fULfsiwNcuARMWdCs11+/O
 E/R2kHBAFNUvNbwiefl7QaE0+KXXoRQVcWATKTCaECUnMH2SN+CiZzjZipvoEwYrE4Wb242Pz
 2v6e9gCXPq6hnCJaTzFr5aU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 01/16/2017 01:21 AM, Junio C Hamano wrote:
> I haven't spent enough time to think if it even makes sense to
> "stash" partially, leaving the working tree still dirty.  My initial
> reaction was "then stashing away the dirty WIP state to get a spiffy
> clean working environment becomes impossible", and I still need time
> to recover from that ;-)  So as to the desirablity of this "feature",
> I have no strong opinion for or against yet.
I do remember that I simulated that feature a few times (either by
adding the to-be-keep stuff (hunks, not only files) to the index and use
--keep-index, and sometimes by making a temporary commit (to make sure
to not lose anything) and then stash). So I think there is a valid
desire of the feature.

However, going further, the next feature to be requested could be "git
stash --patch" ;D This leads me to think that the mentioned simulation
of partial stashes might be something everyone might come up with who
has basic understanding of git features and "git stash", and might be
the more flexible and probably better solution to the problem.

Best
  Stephan
