Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96E11F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 10:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbdHYKUD (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 06:20:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:59646 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754286AbdHYKUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 06:20:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI9n0-1dhKtf10P8-003vVj; Fri, 25
 Aug 2017 12:19:57 +0200
Date:   Fri, 25 Aug 2017 12:19:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Martin Langhoff <martin.langhoff@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Should rerere auto-update a merge resolution?
In-Reply-To: <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1708251218460.7424@virtualbox>
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com> <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com> <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ySXm/vGCZXp1N7M1e8dVyFPFe6AHXvCKVeOWls88HuFz0w3kGHN
 b72WHpQuFP4mmYS63lTzKA2+HLySGd38itTyhDskHNLlcllTzpnHDrls/QuyfDA3w+2WHKr
 nbHkdo4uJz6Zpfsut0JTsC3MZysJWqEplCgRzQ3MHbC8fAVohnGbtqUvSnsqs0YIZwDo9Dr
 QKVVxndGxMMvF48aTa56Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nB52TGhnCwc=:nPEpyvHHOW7zdZpQDIX2K9
 6R6l0d6oUg3fFA2JTqvqQyljT4h9itytH8ywJms+LdiLIfLRsmhThg8QqN4CjGsyx+Mg8KeRf
 GxEtl6ahV0mdFvJ6wpG75+h6E+9C5SHkzqBVw8j4wT6GnldAswNuiE20C3b3UoUKmrX0ctSts
 fQPaj04z1LAXlvM31iP661Vnsy6pXFQprpN/EKzmA+VORkCBMm0aJHE4lwqhw0GtDsqFmwi92
 yznnaQN/Lr9LpYOgBptdC+NC4VTTXcGOf/KVLl1MKOtPwMTEIF7LwL5h1GdxVFa89iKjZTnJk
 YYXSDAISUg8zAdi+1/opYcAHSzFsUozB9G/s3IZ6130cQDyOxXkKcxqmh+KJuFH7L7FycK0sH
 dkwr9e76C1k/R32yKkgAPkF5yjtqDb5cxSgiV58X3IXGhn8bYU7o0qSmbsu3/kLyKtNVDOTVz
 kBIfDVYgjtT7V+3YKlg4+EJjz5EXzdOz4EjElw2FpaQcLkD5zFTPToGstMFa4eER9vKT4BWIz
 XIqoFYAa3wmPCxhub9p6J3x2ktgz2WdqL2MwwSK0Hj5vJhpwqNN5O8K8abuORgkaRUmKSI91m
 qiignuJ4zlxw50amlJHuwCGaxEf45OOB1Yup539IKcXva04gX3ZNj9HtBTD8j/QBTgObU6AzK
 2PUHZRpSoDBYlQZdlHpejChU+ffBAYcpjJ4PiOjHRo+jQpiyElIz2J2JhuX51KO/ws8hoeOBj
 /FgXzXdHfRDU5nrv8Or5YX/ncjS9YsVb5+srmGbP3Zc41LJgsXDiV1wtuKylpnr0kRgh70Bi5
 Up4YP1VNejCE62mBq4KhiMlLirta4Yynt+yGiH3lYt7PNV09Zw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Wed, 23 Aug 2017, Martin Langhoff wrote:

> On Wed, Aug 23, 2017 at 4:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Between these two steps:
> >
> >>  - I reset hard, retry the merge, using --no-commit, rerere applies what it knows
> >>  - I fix things up, then commit
> >
> > You'd tell rerere to forget what it knows because it is wrong.
> 
> Questions
> 
>  - when I tell it to forget, won't it forget the pre-resolution state?
> my read of the rerere docs imply that it gets called during the merge
> to record the conflicted state.

In my hands, I need to tell rerere to forget, *and then recreate the merge
conflict* before I can resolve it again and let rerere learn the new
resolution.

>  - would it be a feature if it updated its resolution db
> automagically? rerere is plenty automagic already...

That would most likely be a very welcome feature here.

Thanks,
Johannes
