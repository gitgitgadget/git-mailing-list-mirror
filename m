Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3235F1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 07:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964948AbeCHHGK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 02:06:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:41597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755414AbeCHHFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 02:05:53 -0500
Received: from [192.168.1.64] ([88.26.243.156]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lb90f-1eE99U0G9x-00kfdM; Thu, 08
 Mar 2018 08:05:45 +0100
Date:   Thu, 8 Mar 2018 08:05:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803080804420.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <87h8pvm7zz.fsf@javad.com> <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net>
 <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rJYD5xhDD9o+QFCxb8xmiCCndfapsiiT4acaOVfIS/3tBfcMbKQ
 AVFfXNNjf0ZP4h//7Hqv0+gVVcPIcCKSXdpifDNBs+a0RG0v7FlreSCr0N4G7XNaVM2YXty
 9DZF8mJqE6OelreAYboCrE6ptFt2o6canhCe+w9X27E6u5fZfPZyHE0/QdSbG9GZjsCd6Me
 x2Quw0rNHM9xekfzRSZoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2dHq47Pjnaw=:+hmD2z3PJs/zLcfammULLT
 Sx6YpLx8B5TJ8H3dpYqdUQjiPwQsq4r1rRW/oLLJLd0AUyLrIUKzRBOHU22U6q4g7YZ/e5Y3t
 UpffnT1jkEE40w/TRpIfXgCeLhC+czLod72LtPpekTfi+HPmXuRlvUjN+//obuf9idQUzvl5U
 /vnkE0mvXqoUlvZGLqcXQwQXS4zYfxgijKECRc/iVKjb9KQWyJzMzmTGlRTLy1mB0pQIb5Yj4
 TFkfPAchqImkVO7yLvpEsu5Ge0JOZnDN6CGFVCrkTzPIRqWxuPqYMFWF/OIsnMruyK4ePx1q6
 g3czpS2MsETXMeUzI+STTEXUyOkOjCPYoaxMeuOjXi6zKLSE8kvh1c9/Xu4UW/N/sLaE3xtxI
 ly8Ho+NhURn4+bcRxN1ouJc/jxI0fpLLTv2RhggPsZ1ECpq7KW8MvHFgprdkZGpvQrKe/ddq1
 1PjZ10B/7sIJEiqyIE59EEfXt3FduDAQKXnwOWG6J1aPd26KtUPP2LP90AYijj5Q254ZBnWUU
 FhEJe0+SajUYdMt+Yw+gDRokg/q1BbmGD666Wu66ipulSXctSf9kvEv9ZXeYDloJR44pJh/C6
 fQI/WNaGLmMIqUeN86+d2bX1Lr1TOvomlFHYJEXv1dsp/dl0TZj/92DuPNaCs+Yx9Ba45ykCO
 OqtoT2de+mmq0619EJVh2SK6VeJoyEXXNV0n3nibSUUXM/UrWo46w90KwLuTx7VuWNMBxeodo
 +fGbr+nwl8zgWvXFNJLnwKnTqXzRmybLOauc+uqn0qm/X4yd6myYHGsB21cuDyKMFYBxq+euQ
 kha9bc7BaT8Co9sZ/nsuB6FtK9VeePPX1DiZnq4BGP1NZsF/m0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 6 Mar 2018, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > I wonder if just having a predicable result rather than forcing the
> > rebase to stop if the user just squashes a fixup commit into a topic
> > branch that is the parent of a merge might be more convenient in
> > practice.
> 
> Unless I am misunderstanding what you are saying, that is pretty much
> what I have automated for my daily rebuild of the 'pu' branch
> 
> Non-textual semantic conflicts are made (in the best case just once)
> as a separate commit on top of mechanical auto-merge whose focus is
> predictability (rather than cleverness) done by Git, and then that
> separate commit is kept outside the history.  When replaying these
> merges to rebuild the 'pu' branch, after resetting the tip to
> 'master', each topic is merged mechanically, and if such a fix-up
> commit is present, "cherry-pick --no-commit" applies it and then
> "commit --amend --no-edit" to adjust the merge.  I find it quite
> valuable to have a separate record of what "evil" non-mechanical
> adjustment was done, which I know won't be lost in the noise when
> these merges need to be redone daily or more often.

So essentially, you have something that `git rerere` would have learned,
but as a commit?

Might make sense to make that procedure more accessible to others, too ;-)
I know that *I* would use it.

Ciao,
Dscho
