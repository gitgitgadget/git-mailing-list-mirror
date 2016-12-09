Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC971FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbcLITYl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:24:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:63433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbcLITYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:24:40 -0500
Received: from [192.168.178.43] ([88.70.156.94]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MdKDb-1bx4x02Cbj-00IWZs; Fri, 09
 Dec 2016 20:24:33 +0100
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
 <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
 <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
 <xmqq8trprn7f.fsf@gitster.mtv.corp.google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <e0780f7c-ccb4-29fe-3d72-80e45a202f65@gmx.net>
Date:   Fri, 9 Dec 2016 20:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq8trprn7f.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:seF4pTiSnEdwOv59lk5MrM9+Dasjah6E3wdRhUgl8HdxJOdve3n
 tw5+eEJBkS+pZY5PzzaRwvrtARtOuiJyfFbY6Zhk4EYFLWkKoY+phpTdClQgLjlxCxj8aKh
 qWymfNiqYo8gOhnnoxc/vgkNWpBV/qAeq39IS0rh3OGBu7vnCHfE6XCyCcc8Lh9afyaNTBT
 KA/0kZW849cOv29pRAxKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8wExFboZQOI=:cB/mMPQ0u7ko7rBzf9lGMI
 RBuG6TqLX7lOq1Scv/2UZUNwUvnW9fSPdnVXRwMBuaLUmVpFZ0ETjwf+cVShuA7Xdbhxxdxw8
 RJYnIqWP+dpTKhx2JXDVBCtEYWQvH0pDUvw9mDKEhL/QE3X/OXdXZGcpuKzxuv+OWgzObTrV4
 PUwBuqQRVzfqLFQdUCAuJA3MQGG0d2WVp32bR55S3+hlpwiqau1mT1EMBx9WLOGVLQYBZyDjN
 z6Xj5TRyfZYSn1g+8PHRb9EGsPcxtR17kADkPWdBlBeQ9bUlYP7OH4mqcRTcbF5yhyRNbYnBS
 kB9iHp+lZlVs3lC2OLUAlu+L4VP3S3EA957Hekg9vsvNQQLRoCry2C9WgRUN8idt1BKbPO9bO
 bVEYdsRUpaE53A/ShDcujBImZYyWxA27UTlcKy/qjoPTWP/9LeyhJ8XaXVoxd1gPbPDtexgeF
 TZZTyLj1uDUzEbJyke0wDLqOvV6Qmlte+VhSB2RyiaYal1qMBk5OuC5QhR3Bn/1FHh/z/dvvC
 TDO0RciFQCZyGTQvVHSUvLa/mU//BbFbZ/XFwhRARou1wqMe2Ham7MjIGikOhfTFUGimfXq9F
 EL8pleQHCmdPvhgej3AK4dNI/2+KtRP+yfst1XeZ7at6QzL0XXb9PkQV/WA681L048CQ8PLlE
 qhwIxj3Bmp7d1gBB1VSKYOIGIMRhi9fKDoDyTnzzL8zWXFJA+t0ZD9AKS54gQwHGoOoMPnW3T
 /QxCuoYB+AzCs7GRlF3txKTjCPhCARzKS16+Q2EFtmKjoYF1A3JpkCAgwhBprHU/kYT6OYTB6
 KPJvWTK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 12/09/2016 07:07 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>> Having the same operation with different names only increases git
>> reputation of bad/inconsistent UI. Either forget is renamed to quit,
>> or vice versa. I prefer forget, but the decision is yours and the
>> community's. So I'm sending two patches to rename in either direction.
>> You can pick one.
> 
> I actually was advocating to remove both by making --abort saner.
> With an updated --abort that behaves saner, is "rebase --forget"
> still necessary?

A quick change in t3407 of the "rebase --forget" test to use "rebase
--abort" failed.  That's because it checks the use-case of
forgetting/aborting without changing the HEAD.  So --abort makes a
rollback, --forget just keeps the current head.  I am not sure if that
tested use-case is a real use-case though.

A quick change in the pristine_detach function in t3510 and t3511 from
"cherry-pick --quit" to "cherry-pick --abort" works when one ignores the
return value of "cherry-pick --abort". The "--quit" is used here to
ensure a clean cherry-pick state, and --quit always succeeds, even if no
cherry-pick is in progress.  That may be a real use-case somehow that
could also be used for "rebase --forget"

t3510 also shows another use-case for --quit: the title says it all:
"cherry-pick --quit" to "cherry-pick --abort"

With this additional information, I'd vote to keep --quit/--forget and
just make it consistent.

~Stephan

