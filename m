Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073A720228
	for <e@80x24.org>; Wed,  3 Aug 2016 12:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbcHCMM4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 08:12:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:54699 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbcHCML6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 08:11:58 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lz3nU-1b8jEu2FaC-014AUl; Wed, 03 Aug 2016 14:04:00
 +0200
Date:	Wed, 3 Aug 2016 14:03:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Johannes Sixt <j6t@kdbg.org>
cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] t4130: work around Windows limitation
In-Reply-To: <244e3458-4a41-49bf-fba2-71da872e7f66@kdbg.org>
Message-ID: <alpine.DEB.2.20.1608031401370.79248@virtualbox>
References: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de> <9d167448-84ce-e368-0bb4-41aa4452268d@kdbg.org> <CAPc5daW10y_5rat0Au-1NWXUf2QYFrDfQeprqq9NsYPBjdqOTw@mail.gmail.com> <alpine.DEB.2.20.1607301011140.11824@virtualbox>
 <244e3458-4a41-49bf-fba2-71da872e7f66@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wgi2ZPlqYiJP8Jll16R98JIJRLBPOk6YGqhkuPui3iLsTFM2ARg
 YgbBmOttcmZ5ghxqS6R8p6CxmKh1trPzYZtsw5oWWT0NDNqglUm4p9UV7Aw2RbOc22CPhsW
 En4dPcaCal4Z8c8WrGweJJgr271/UQFRaBrygnqqFJZsFromPwfg+4ubNkyjdAcRALm7Dih
 taVfvxGvKL3hUjYWnbLAw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Jau0jcZx+uc=:rMhzyL7Yw5zL5bRlT3+t2c
 K9D42u8XK6VPMC87yfSsxv23OLYWE/Tt5fvrkbk4v5sZ9By2uWaEHu5xD4TbzhRKmk7KdDMMG
 QD4CL1M5SHGfvodY1+gLjrWDmB0Mj+XlBa7U9EydVMtakr+FzNopDpGZZ7o7uaCbBv/xjB3iu
 9Wbn/5ut1Zzow1lZ6W9+f4x9jWwHc4MLsO+GtBaA/DL8Zy2o+ukx8WpQv4fZwyACkRULogHRT
 8XZpWjVP+mG4jRm+mOvin3U0t3a4JDLevknH0npLsV+J6jWAxCNGpqf5Yo4C6orBj/UEuUPxf
 uZd+t0AM58Ln1TEFEA2PyP9tL+kZo/wmSE6y97G/pXmtdwN+DVcHX7kWQkZmqnoqpU2SlXWN9
 MlvvDRnxe3Nm8RrTPGX8llIsrgMWzfPqri3yfC6hEI/ZLtiIYyh6nr5MSeLdOeQY73F7NBUks
 4NrdFvgqMPFCxn8bgtrEMek2tS0hK8cH25Zh/z6JiioywHnqZ44grd9SZFoT4oThMkQ4NIDi+
 JFHX4bsqxyFhBvZ43np3LosARMBAKsdO0wLABWW83B0ymUj1qu+2dA1Qzi/GuxjMD/8RjQVPw
 4iWhrHq6uafI9qcezuwQtZp1Z73ivWtVth6aFvAFFcB3BdH+MOcobGPGcpT7ZR8ct/QmrsOiK
 Ou6mXnUh5L9yGNhwXkNJqNjZ73763IeL30B1DU38gzDtBrAf3GwRVVm9CKHGj+IlUCoQ+tFzR
 9uOrm4Nw5Xj0OFAQtj2RcpOLr2RT9bGYMQ8R3zfE6C1mlUYHjflExqyh+O4sFbq0Zun64GCKH
 Skmn8nO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Hannes,

On Wed, 3 Aug 2016, Johannes Sixt wrote:

>  This fell through the cracks, I think. I marked it as v2 because
>  there is a minor fixup in the commit message.

It appears that it did fall through the cracks.

Given that it would make my life substantially easier (because I run the
test suite often enough to hit this edge case multiple times a day), I
would like to ask to fast-track it into v2.9.3.

Thanks,
Dscho
