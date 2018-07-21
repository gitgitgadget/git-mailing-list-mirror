Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D511F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeGUW4y (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:56:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:52005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbeGUW4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:56:53 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqQzp-1gBOtC2eKf-00e1xH; Sun, 22
 Jul 2018 00:02:31 +0200
Date:   Sun, 22 Jul 2018 00:02:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment:
 a function to solve least-cost assignment problems
In-Reply-To: <CAGZ79kYBRj-YLM-eCkHF1oMmBfTAeOQk6hTAD47HuoLa4QZjvA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807212358090.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet> <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet> <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet> <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
 <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet> <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com> <CAGZ79kaLTJDmWhS8Y8R1cQh9TRXLawdoWHEzVC6PLHBN+VQekg@mail.gmail.com> <xmqqo9f1a9ct.fsf@gitster-ct.c.googlers.com>
 <CAPc5daW-KoyUX3i7M5YbdQC2mFKAmVBS42-XT84hpm30VFcZ1g@mail.gmail.com> <CAGZ79kYBRj-YLM-eCkHF1oMmBfTAeOQk6hTAD47HuoLa4QZjvA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e4gTOG4tqrAanqLeOOoDV934RxEmrG8VhjvxY2dREGgm4cAp9kl
 LFhFkLVIlOMIrTwxX2ZgzriJKfXQ90kxkAvSQTgmuXO/Kno3DUx2DohwPwMseM8ZwUv4JRt
 LLLDyHCGJ8SMT9UJgH3aoUNmisMhKOWts3OLYK1zbaBA+ukWKbDtyMdJl/XVK4lxl6hJz6u
 pwg858ZmfhFg6fmPoXpxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zSzVzXTFzaY=:8saW5SEGSSc736p2L8TY6n
 sSW/Wbjp0vy52DRNX6Kn56xgEHhW5twQvyRPIsM6a10WzgDZ0b26UuexQzXaky5IVQFP4ocjt
 p/tdg+H2Ms4jxXVd51t5VcuxeNOqHPs9naY5j0xUvzS8kNr1jnaCD/97Qax3rp2kDCqKrepAv
 rDFkvrPCMdFaiuB193egWYrmccwRnAZ8q5IOmMXs6kZzdXH/AoAUZkmp/vLgyIuvRTFPGdx45
 6ovUvd6vgzwksNMqZW4jrWHm6cWbBcUC8ToeySa9zy84fzXKkcjWKO8ljdqOEmlVl3x+dJ+kL
 8MLxxeDJW1YD8kIQ4aaCsuKgXYeHiYW054Ma2zP+cP17eVhQYX33G62hajELfUVYCL/xwj1Ht
 BfEmStOE3lCjlosed3C32kwmwB7GvI7WYogTBapsr4d5V9zqx089vm9iw72DGCliMtdUem581
 N7Qm6vjqjRgiA//Cq+Ey+jn31F7Q6tfFvYQ/gT/DVMaR0EfqEI+Ef7xaxckkxq/r1tOEoQHmT
 VwbuzOGflssN2T7ZfEd9tMJfYrnAFJ0sniq+s8jVvxix6WhMem8stNMdELV7kIRzEHHVl7nu/
 AfHL/Cic5SoBsZx7YJpJ7EFumcTOdIIw0/iPfS5tqTINSWh2D3lvIf0AQrSQwRvMQ0NZ7nJRJ
 3mGkKhu2n//HBmAK1g1RHG+xh1cxBKbsio0imLlkoRMZF4Vu3gGUzB/zKFyrk7sa1Ojx0L1lV
 cWAsSUlAUdIHzTTO21zeKdV0sNhxFOio0huwJrR+dA03nP1pQymzk4s/SdaiYUrHCCv/VD4L9
 oicwlhX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 20 Jul 2018, Stefan Beller wrote:

> +cc list
> On Fri, Jul 20, 2018 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> > ... which means that it does not matter if I have an elaborate rewrite hook
> > that constantly updates the reverse mapping or if the reverse mapping is
> > made immediately before I push out. You wouldn't even be able to tell any
> > difference.
> >
> > And for that matter, it could even be made on the receiving end by you
> > after you fetch from me before you need the reverse map information.

I refuse to believe that the suggestion to go back to the equivalent of
pencil and paper is sincere. We are developing a state of the art source
code management tool here, not some hodge podge project of somebody who is
trying to teach themselves C.

The current state is that there is no reliable "paper trail" of code
contributions. The solution to that is absolutely not to abolish what
little of a paper trail we *do* have. The solution is to step up the game
and correct that automated record.

And I would have expected a lot better from the inventor of the pickaxe
options: why care so much about source code "archeology" on the one hand,
and then burning the library on the other hand? It just does not make
sense.

Ciao,
Dscho
