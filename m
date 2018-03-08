Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6BD1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 06:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935311AbeCHGqE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 01:46:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:54211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935294AbeCHGqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 01:46:02 -0500
Received: from [192.168.1.64] ([88.26.243.156]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTBsk-1f4Eul3iz8-00S8p9; Thu, 08
 Mar 2018 07:45:54 +0100
Date:   Thu, 8 Mar 2018 07:45:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     phillip.wood@dunelm.org.uk,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <87ina8ymxs.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803080741160.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
 <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8pscw0r.fsf@javad.com> <nycvar.QRO.7.76.6.1803070756550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87ina8ymxs.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+W86WXd74TNcyubbXoRjF3U7S3YDLUEIL9QIDkT/PEgOIf6mvuN
 cN9eMV/wBKQIxJKIHFz5OuJICC9maRFN3m5idbFSGy75soZ//+5Mzr0zByhPLCvKABCDDlO
 drNFberIhyq4KmCoD7ZV+g0HVf3E+skEI4OoeTsOATMVHZqD4LJvjX6ZdbKJOdGEt3PCNZx
 Juj/NnGzDL+4xclSdGUrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z6vD1gtY4lE=:YvyeJy9RXUN8m/rRrmX955
 mqjItXF3wQb0LtQ+aInc1OG4EHLWqHOtjCyjIxUrvrMONsk2BNsUzricU7UdxceEkDBxCjQOW
 5ycoA37VDnnQ9/WAnUVmFZgDe+4o4A7L0/iL2gABdczaIfw6dhP50y4S5byYPRFzKhMNpwC13
 9mBSfdDekrwhzRMW6VRToJEiDBgLfbLZGl7ka091mhd/0Yy2szar4iNN6yZASSt2EA0oUfZ2f
 uBfBs4eUeAaoqaNAFrVDwvtR4auGq4BeKs+yk7cj7HkdX40+pVL6Tsh8C6hhoqkLdRHPQT8z5
 wZsrN47vl/QTX9NRmU1JkFz14tE8FF/TXYC3ufdsREKiZIx41GCGjJjShFrostXhi1h2ZvAiJ
 eHXd/09S98wGoAySqiFINqp20zLR729FiTTCshQABtlmZezIQYjAVpoH1nyu+zhbpWBRgLQue
 kMsZLwFP4MJokh+UDXQMcjpSN1WQLxDZGSy2Q2ZDJatGXm/cbDejfgHR4D+oiMMbcKWsEm6WN
 k/UgK7/q8nE/VOZkTuxT8XZYH+WIARMfIjOv74IudNvAlIMz7qFvVqJgfYqWqsnPsnHVMzaVD
 0KM9lMBFJe+TQRxVqmCcEpBzCqVDtTfQ7qxZsddAhPiw3/dPKqiOgNBNzWWaA+fWUHDbQystX
 tj/23FKemgyPaURO70pv+6FUQUBQlsPyU4G0H9SM5z52fbkcQ6iXj1O6D4iRNph9yzPANRy5u
 pYKEsh5tXd6XKOZCtYNYHaX4MJtw7P7/vOgVM019wP2E5TsFTvgc/qRbW4+0G2euYOWge7eCG
 P47hBY/Sx2lO09cPOz9emPEb0VVMS9AZG3m9gwYLjs/51Qh8Lg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 7 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How can your approach -- which relies *very much* on having the
> > original parent commits -- not *require* that consistency check?
> 
> I don't understand what you mean, sorry. Could you please point me to
> the *require* you talk about in the original proposal?

Imagine a todo list that contains this line

	merge -C abcdef 123456

and now the user edits it (this is an interactive rebase, after all),
adding another merge head:

	merge -C abcdef 987654 123456

Now your strategy would have a serious problem: to find the original
version of 987654. If there was one.

> > What would your approach (that still has no satisfyingly trivial
> > explanation, in my mind)
> 
> Here is one-liner: rebase sides of the merge commit and then 3-way
> merge them, using original merge commit as merge base.

But I already pointed out how that would undo a commit having been
dropped.

> > do if somebody edited a `merge` command and let it merge a completely
> > unrelated commit?
> 
> Don't see a problem, sorry. The method should still work, provided you have
> original merge commit and two new parents for the new merge.

That is assuming a lot. That is exactly what this consistency check is
for, that I mentioned earlier, and which you listed as a downside of
Phillip's strategy (forgetting that your strategy has the same downside,
so...).

But I guess that you are still talking about the non-interactive version
of the rebase, and missed that our conversation proceeded to the point
where we want that same strategy to work *also* in the interactive version
(and not have a completely different functionality depending whether you
use --interactive or not)?

Ciao,
Johannes
