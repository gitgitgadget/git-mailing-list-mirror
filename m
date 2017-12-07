Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA2120954
	for <e@80x24.org>; Thu,  7 Dec 2017 17:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbdLGRzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:55:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:56518 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755894AbdLGPst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:48:49 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaG7C-1emw2n1jna-00lzGO; Thu, 07
 Dec 2017 16:48:43 +0100
Date:   Thu, 7 Dec 2017 16:48:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
In-Reply-To: <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com> <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GkbmkKSpHVh0zlGNM/s9nurN0FYNO21Mi9mBc2DwOtmpGOeFrwe
 hXxxx9AsjPAj4n1/ikyGuxIH3thgCJ650dcKu5c8N6rpNinIw5U3Pq82SUQ+Ovko9Tqduff
 gulVbehDOA96dDqBEUBIwyRTRpiXDzbD8n1syIEGHTKdbupAtUB/vBmIe2pQckwppU9zeNR
 FT+y1KWLe5K1ydukQy+UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oEZmSv2yfec=:dfl2790U4Vax+6eg/KOo94
 4AbL293FCIHU6BeHwUyW2eKG64Zd8OUVr7sK5gEZiLHc2x3AuPke1jcL3wDBH9TdEHA7Xe+3v
 7k684J9ZjOZAmwNYp0wCjsvMfLcZLBJJHKjy3cDiL8YWRmL2xPPuxTCRiGuR6e2Eu0u5/DZI7
 wtwUpgWRa2xnJ7dgrP8g/o4DriiuyiwmmmqSkTy0kGVeuvfN0nhs70AzFCfs5NnvO0Om+ERmi
 jkwHHN0lz7EmibUKOb2JHCwKoMmSdkMmygYt4vHUFlEzpArcuHea7/INr3upb2KtmSWbFc23Z
 JqkO+N7/k0guBzFdcQHbbks8xH86RarP58szor9AAP485WgPN2mrOT734NKxZTEeaXAQUvac5
 kXdko44XGgTUQuupxcmQbvG/K0BlkBG2zWwmEwKVWmdw9dE29cCzZCQs+exugyShjWsqYEiZW
 vXzBqdp/xOMsTLkyvPBo82sqpQ6E94w/u5wsukli7lo8CSwSeVuqx5GlFSmdJkUizsC7dejQF
 ijDbBvnFMT2IxvOIaM65fdLNGODBhNqd0uSUytFUN6h5xZtTE5QMYpNw2hC3ENJNvQLIuOtV8
 eLvE9IgA7sIDKk+eveAyxlD9Vj8jMM/ApGWJNNgAEmgURgQgkrqeKmih7QtSbVKtJvG+uWxJA
 OSLVMN7cuck7IEDRafnpe93An4C1hTr85SCW3XNImPZoWiixezciEplXEIYLeKdAU7EXIzZyi
 yjX8Ut87+ne8y/KI1KeV3pXN0TOHDA5FljJyW/yyTF8M2Fpvp47CAISjaCT/NGqcgRWPVy8OP
 clu7RyDYfnPB9WMg4Nb38ZFWKKS1HGeHCfjuL9HmV3tFaGLI2E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 6 Dec 2017, Lars Schneider wrote:

> 
> > On 04 Dec 2017, at 22:46, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > 
> > * tb/check-crlf-for-safe-crlf (2017-11-27) 1 commit
> > - convert: tighten the safe autocrlf handling
> > 
> > The "safe crlf" check incorrectly triggered for contents that does
> > not use CRLF as line endings, which has been corrected.
> > 
> > Will merge to 'next'.
> > 
> 
> Looks like t0027-auto-crlf.sh is failing on Windows:
> https://travis-ci.org/git/git/jobs/312135514
> 
> Could that patch be related?

That is not the only thing going wrong:

	https://travis-ci.org/git/git/builds/312551566

It would seem that t9001 is broken on Linux32, t5616 is broken on macOS,
and something really kinky is going on with the GETTEXT_POISON text, as it
seems to just abort while trying to run t6120.

Ciao,
Johannes
