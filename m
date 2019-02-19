Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD871F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfBSONk (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:13:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:51289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBSONk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:13:40 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1hLZ4r1Vwa-00jGXA; Tue, 19
 Feb 2019 15:13:25 +0100
Date:   Tue, 19 Feb 2019 15:13:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Max Kirillov <max@max630.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
In-Reply-To: <20190218211725.GD3373@jessie.local>
Message-ID: <nycvar.QRO.7.76.6.1902191512350.41@tvgsbejvaqbjf.bet>
References: <pull.126.git.gitgitgadget@gmail.com> <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com> <87pnroolgy.fsf@evledraar.gmail.com> <20190218211725.GD3373@jessie.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-630199017-1550585605=:41"
X-Provags-ID: V03:K1:JRBM6KsIunRRxRl0ejkyU/whsGmXCzOx/WefF+jNT/5WspzMFgF
 M+9jtIF60Vxb1Ss1FjwC5nNwSMcnVKu6liYXVE2wFTN4pojLx+CwyQQvMxKj71krjEWKLdv
 BfC6wMnUrc7pKSQmru2IiuGWP1e5oKarmPhtsFGPfWE/BQ5x7WNqCj73xijsecKGGYffsKw
 yf+fWH6lrADTSxt+Xrmfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjjPNgdIeHY=:X3zA5VQQ+IrAj+/od90+1n
 cNZf42gG7DMXpI8cwcTvXl7tXlkQ/gD7uccDSSSerFejqTo5DvO38HDasBbpRZ2YRGa9OKDRd
 GpjJnql9ug2JZtLx1plCiM4A5cVmIzrd3cRaRMjJE0hBnP5gVlvRcLYGMG46k7W5GbD9PKrNP
 /Ii+camIPoL7+KGruztXbyLTal0JHGQTFlJzg9kiAkPTbEoo0BSPpOoJ6TeDfbdmv5HLIBf45
 pOUjP4WOSuGx8cKlusMF8/Lv4P4k2bYtuqqNlwMp2aCgoi4hQSdJHnjkHLWOvHw3cT1p8Yp+Q
 usFdWaL66BbkuQM2mrZg8UV9Q/t1+RQxwmWuKDsChwKIiEW+AatH4RkgFArWb6AN6JwydDDEv
 NfYpKLPMZuoAuw1GRodm/EJ5aykKXeBVaxo5KnHZZPwE53sHTQy/FM2vFqCdRqm/DGUki1Gnz
 WMD7QZMs2ZC+wEb1QKAwe8+t3PERQppAidCvMf7kes5yos9VFqVTbxOctjCmEluVYobdwYrCd
 XTYQUtQgCCiRKDGi0vYCe/Ae4vafRF3S7kpZoM34qhVFU+lVl1wl13LF65GjlnEHP9Y7/E4ps
 eULs2KCRViJDS7o3oDoRBBUU5g7KZ57Q3efuYwfBh65yUOZXco2yhVu40zETwRZgeKpbb/iA/
 FDu2LvqRi/LxLeceXsVVzMRbqO2CW8VBqJ0C20bg9Ul7I1q/3Iy84M6q6wyaQDz17Etj4XDs/
 VMcKLWNG8yoQKzLdvKZR0VNlWTzSAK6wgUKZJw1DplQGE04Hm3292nAUTL5pslskac5d7kvc7
 No0l39dGw1NoOFBk+j3npuETOseyOrbic8rP8k4IuuZSFktqFiHzsUsrrNjvWyQvsDg4/0hoh
 CRU/04mGIOSWhIGBPw9quutWA3KlZ5mQpGkkcJAp06X32b5hSuso/atdtR3mk01rasag3AQFa
 ff3WoMGYceg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-630199017-1550585605=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Max,

On Mon, 18 Feb 2019, Max Kirillov wrote:

> On Mon, Feb 18, 2019 at 10:06:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> But in our attempt to exit(), we try to "cleanup children" and that
> >> is what gets stuck.
> > 
> > I have not paid enough attention to this thread to say if this is dumb,
> > but just in case it's useful. For this class of problem where cleanup
> > bites you for whatever reason in Perl, you can sometimes use this:
> > 
> >     use POSIX ();
> >     POSIX::_exit($code);
> > 
> > This will call "exit" from "stdlib" instead of Perl's "exit". So go away
> > *now* and let the OS deal with the mess. Perl's will run around cleaning
> > up stuff, freeing memory, running destructors etc, all of which might
> > have side effects you don't want/care about, and might (as maybe in this
> > case?) cause some hang.
> 
> * Perl is running in foreground, so it cannot outlive test
>   case and spoil the subsequent ones.
> * From the dumps I have an impression that it waits
>   legitimately - there are other processes to wait for.
>   And anyway the waits happen before perl script comes to
>   its exit.
> 
> Though I am already convinced that I should have done the
> helper in C. Let's see when I have time to fix it.

Perl has this nasty habit of causing unexpected problems, doesn't it?

I look forward to that dependency on Perl going away, thank you so much!

Ciao,
Dscho
--8323328-630199017-1550585605=:41--
