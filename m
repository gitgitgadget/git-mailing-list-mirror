Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604591F404
	for <e@80x24.org>; Wed,  5 Sep 2018 13:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIESIl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 14:08:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:51799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeIESIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 14:08:41 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdoR7-1gFsDG23UT-00Pbsr; Wed, 05
 Sep 2018 15:38:19 +0200
Date:   Wed, 5 Sep 2018 15:38:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jc/rebase-in-c-9-fixes, was Re: What's cooking in git.git (Sep 2018,
 #01; Tue, 4)
In-Reply-To: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1809051536391.71@tvgsbejvaqbjf.bet>
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fI4Lj66lW/XgkB2NMv01HC1+Y3gVEHRSA2WYwh2K6nnnFskVW6s
 XbHdsLF2qXyZW4Dj74MoXp/coGc3Ccf8G/I3Cum7xQRABO00bywOXIkPj5Jc33CPRfvAX0f
 kc4Vciwq8kz2s6jAAkYdMFR9g1tcBJyQdhlGKKbR+u7WB0BIjpwmDmakbEoBHMmD+CHZy6l
 f9nOjumjbvGCpPK88l+Ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J9Pd5ZffH5g=:kAtOnzgGF4e6ea3TiMo/gr
 RRhdF3bGF4SOW9DgAATjCH8Wf2GKqhFO8DFp55HCWU+2nN0YHYbzgw0gYKyDpzZHzTtqe6igV
 gFamOPFR8qvoR+LntdW5+/MGT6kz1+QvNWJI3kLwLdrvl5bg8ZJ1hIyHgn4N1X0VqxFuN+w42
 nc7TucpCzT6g832I8NgYNoL9lNo+j8LjnldGOQNeK7JQz2JIfF8OBAPgDUzQGZWJRWSWIItrW
 SbPf9pkcnbxR/46oHTw+2lB3YEnvdrCCDDXSN4xgBkKO/VYvNShlkBpBv0uICYEk7Hx93kUyD
 cTi2XzQH6c2MTfChMNqOQv36pty89jQ7wY25dLb2jMg5wmZ+R1VCOMnP67nYqKaX8n3kzQ8Dc
 yCjfVdvNNULSeTjLXrXrJClhF0mN+UwCMSramprpecztyoFizjT2/u1WxcK2ysIBzw2MKD9Qh
 3Ghd+/YG6I1WOpI6D/1UFPT99RbGL63hUf0m45iJqnlHqkrQpNueM+O34ZOH2GFe6HuXoDum6
 88kZVTfimqtholvgNrXE7o9rXZGdigyUpeeHC3BTdtZFnIFYb614kk0dMkiOQIwLttegebmBq
 0IjZYdb0RxfmP3yeLB3wXDJHJrJH5CfIhYf7VAzogN5ENLKl8YRp2IYRqqTFMDJPOTGQrSmN5
 R7swTQKS2iRxcLndbwICq12YZ/Aaj5VoGZDg0jXiiAP/r3Za7uMNl/eSGGGTGHhSGgVtZkusO
 QptnRWmh37N9wDRuiprNOff+7kt9o2Ua6F0Alyq/6FG+gqUwa9akn6vZHYIEuyo5dwshXKhoP
 yBxHSh/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 4 Sep 2018, Junio C Hamano wrote:

> * jc/rebase-in-c-9-fixes (2018-09-04) 1 commit
>  - rebase: re-add forgotten -k that stands for --keep-empty
>  (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)

Quite frankly, I'd rather you pick up my two v2 series. I promised to take
over from Pratik, who is busy with exams, and I did. I even announced as
much in that mail where I pointed out the missing short option originally.

So there is no need to do add-on patches, as if the `rebase-in-c` patch
series had already been accepted into `next`.

Ciao,
Dscho
