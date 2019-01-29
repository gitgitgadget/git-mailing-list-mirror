Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0391F453
	for <e@80x24.org>; Tue, 29 Jan 2019 09:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfA2Jzo (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 04:55:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:59861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfA2Jzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 04:55:43 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4R6-1gxBYf3mlM-008uit; Tue, 29
 Jan 2019 10:55:38 +0100
Date:   Tue, 29 Jan 2019 10:55:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 18/21] t0061: fix with --with-dashes and
 RUNTIME_PREFIX
In-Reply-To: <xmqqzhrk8k1n.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291054280.41@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <d613c79aff9c65ab9c3723a876c99e6f35a2f133.1548254412.git.gitgitgadget@gmail.com> <xmqq36pdcz3o.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901282337550.41@tvgsbejvaqbjf.bet>
 <xmqqzhrk8k1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hTWbWRwsn+Xl04FOBIXzM37tmWxsDz7lBqzWsJNz1MG6NP47jT+
 HZ9hmkEz+Lx1th5tftzJGMyBSwXts0UFNSwPdeOns6y8RUyxYvY49S0O4Ngr8HxjihQeYLD
 SlO+YdJycUyfhLA37+YhhEZaw9Xt+kEUswqJ0SLfk77vDyczadIB89W0ZL59/wOWfJXvjSc
 /H5K7gvFgsonMQG6nJOMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PcW7VZk53qM=:yiDsyy06mc8O94nAlscGBu
 WFDjWK/vJEZmQeuNiHmTX8TeLx1HpZBYorm1isiCTl5RpLxms2f8Ay4zhYP+TsOXWcIjaX0Js
 DpRTBxMKZTRy1D815Rkawbb/wOMrHe+MZE+Jkb5XW/oZuMUltRfuxDL0UC7/vfkZEN9iLGwa3
 ifFw8YNYn+G+rsCVKqwsyyWSDWTiWH5rSYNEnyGJ+pawhfxlcCs198ffOHMKLBpXr/6iLIuVF
 Y2U+k72mDKpi4g/+c4jWHpG71XASaOT7kCpaVd9FENX0ZTO+9k5S+ouyg4VKSxYQg44EBGa7b
 axlfioUBPvzg0BDLGe4whKXgHUh12Mfp6BzfcMR+ej6bWfFxfTt1jpixv5xdseb4p9N4NJ0zn
 TWzfEeybzZLYnqUdwXuCPmbrMVwPpFSfdwUjKkor+Lqp8rjUyaSzn8lXaLNMohlezvsJQY8G7
 62zdVaZsKaTImH0RtHvgC9u4yrvt8hxQHIi3fdp/Q0nGFl8vYC4BCQIFwy0dfPrvT0JY8xvv7
 7h69rQNhL7iI93AP4Zrx5Z+f4+aoNITW1K9Emz9GpvLTg9jgfH34jnR5X2xTwSllWfdUp5otK
 XXVLAb7eDMkZzAMnqg74VTS4ZTlk4OFpq1aztAQLPjKYsCl+mSeYzV7zQeMfrTozrj0LEvi+6
 u3brHMdm4f/awm8DwFP1atCS2MdmV5/yrKg5SusZINsGHxacDrYt4i7b7YQVKZv2WsGeBcD0E
 npGAh62pGB14oGJ3b6LG34o3h6hmu3YA1KuYaW3D1FnLwd8JONzG7ec5pXUz5ClUPB8JysoZY
 2lpc0Z/s4vKcK9KjH9z+w28ejl21CSzMwnTv3hiRpno/+kP2ElFGpj9wfsRFiLLQ1zC/4IHQT
 kMs7r323exOdDnvoM63S+dXf5eVUaFehJZOWtdJTK5GoDivH393nlaL7eA1+/ET5Sl/qQMuFf
 w/0i3i9+Rqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Two questions that would come to the readers' minds are
> >> 
> >>  - Why "it fails to detect the system prefix correctly"?  Is that a
> >>    bug waiting to hurt end users?
> >
> > I recall explaining that already in a different thread (one that actually
> > *was* about the RUNTIME_PREFIX feature, where you asked why we cannot test
> > for it in the test suite): to verify that we are in a valid Git
> > installation location,...
> > ... But that was clarified already to your satisfaction in the RUNTIME_PREFIX
> > patches. Or do you want to reopen that case now?
> 
> This is not about me.  It is about those who read _this_ commit ---
> if the change is justified to them clearly enough, then we'd be
> happy.  I did not think it is with the proposed log message, and
> that is where my comment came from.

You know what, I finally start to see your point.

Will adjust the commit message accordingly,
Dscho
