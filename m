Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5741F424
	for <e@80x24.org>; Fri, 30 Mar 2018 10:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeC3KjH (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 06:39:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:52057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3KjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 06:39:06 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaaOf-1fHbw00o6D-00K5fG; Fri, 30
 Mar 2018 12:38:57 +0200
Date:   Fri, 30 Mar 2018 12:38:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Sergey Organov <sorganov@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <87zi2r5swc.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803301235560.5026@qfpub.tvgsbejvaqbjf.bet>
References: <87y3jtqdyg.fsf@javad.com> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
 <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com> <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
 <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87woxyf4lk.fsf@javad.com> <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <874ll0d9nt.fsf@javad.com> <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
 <87r2o48mm2.fsf@javad.com> <CA+P7+xo19mHrWz9Fy-ifgCcVJM2xwzcLj7F2NvFe2LwGbaJiDQ@mail.gmail.com> <87zi2r5swc.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sw3wF0v7M7zU4o1Ly9nvcH4l/Sojww6H5TcMJxByqfWWRPOfI6l
 f2T4spWhVwgSPX614CUPTbZiCLKePEr0EnAROohrkmYRuzCwU2nJ4Qw/uLwIZqZ2PAcTSic
 hyRtUcdqZimbJjon+DBpXBklmFx3k6c5gw9lrG4G/ESNeClnB0j6S763+3q7ugdgOM7hH1+
 SjvdQxviDO9MYVx9XX0Nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:erjPNDz3b7s=:Eeo8yWKRKRymG6g/8RAjUl
 XCnR9Jx+domvRYBsoXEhtiDK3/0xGqxQ9OXcR9mRg6sOK7qz7xaYjlmvp75mGDE1K/TuGVPYR
 H8kqhklpoFMJ00Gdy8+VAvdZC8nU7tkpkQ0Vkn6FwIvFNSwEwYRwTceA4DXIbf5VzXEGFKB7v
 IKuLPXR2SuJJKzR/dLtIvxUb8MXUJNbHvI0PrFWaB0Bsd1vztw5owv9NMgw0kcPJUJPNvCFmc
 PFcC89QLSdM5cXDQEzqhgdnrqnCIUFwtP12UfE8VHssd7wJTD1vrZQAukAxtKwGFX9PQV2Ooy
 +9bgSLkbApwveNMIVRLlgYenUV1Io3YoikXQqnO6SaLm45u0VE7i2WCfi3tuqpvWbtbYJ9331
 UPpB03pU4R03TLZlzLta6zxILUA+NC3f8uqOQ11LtB1xomihg52JgAT8LQ1XlySf6gB/t6jFa
 /BUhBxB/ONlJSwqbgpaB4oONgL9R2DEFeQoHlWHK2kyTW/dcR83kZDnyrIN+NyLFRIjs3GYsL
 eRY+shwXDxrHZyoigtgw5WMj8pu+VesHCHOXCllsPxRfFdLx6DXWIl/wlQMiBQKERciGBR/Zl
 4vbvytl7tRwIw0WW3vEKJg5FAIpXgT1xsn38rVcwTs2u7tbAZpQMXqlqrD2GbenZ/g9fZPkrl
 FrOLa6IpcnvkpB29HhAvajk8ILeYLz3bnfDn8n7Jw9UeBlbNG4ZP2SKYfDv1yQHRWzlX7yURl
 zk1Tinx6F7OGiWGxaGzTM2DvNTKQyCaJ3UHphB/9ZsofaSBL70RCnEsl/+90JDDC/RWfd2xOA
 182MV9UjQhh+MQ2UXu2JWqC34C9pErKzjjtNh1sE5c/NKyE74vtyf1rRqtR4RXdapaQWsUN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 29 Mar 2018, Sergey Organov wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > I care about the general compatibility of the rebase todo list
> > regardless of which options you enabled on the command line to
> > generate it.
> 
> It's a good thing in general, yes. However, I recall I was told by the
> author that --recreate-merges was introduced exactly to break backward
> compatibility of the todo list. If so, could we please agree to stop
> using backward compatibility as an objection in the discussion of this
> particular feature?

That is a serious misrepresentation of what I said.

If I had changed --preserve-merges to the new format, *that* would have
broken backwards-compatibility.

So the entire reason of introducing --recreate-merges was to *not have to
break backwards-compatibility*.

I definitely did not say the *exact opposite*.

Hopefully this clarifies your confusion,
Johannes
