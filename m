Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A932B202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbdI1Mb2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 08:31:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:53367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752739AbdI1Mb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 08:31:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1dkZQE0yUT-00MLIU; Thu, 28
 Sep 2017 14:31:19 +0200
Date:   Thu, 28 Sep 2017 14:31:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Max Kirillov <max@max630.net>, Paul Mackerras <paulus@ozlabs.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitk: expand $config_file_tmp before reporting to user
In-Reply-To: <xmqqzi9f1lb2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709281428170.40514@virtualbox>
References: <20170928041417.28947-1-max@max630.net> <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com> <xmqqzi9f1lb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gCLbwIfTZP0b7kjuH8cdu7qiZuNUSrs6b2CfK8eZLffS11VUfAY
 Uf+IB9j4rktvHpdVXxjY5lJl3I84m0tycXL25D3918NlaxuYn1GLvOnkMEuou9epyaChcK0
 W2IhgtG7p0eX9UZHskOjjXa7WAV3R6W5SjupW06d8/6HGNby/Dkgk72/2dbHKpXGdk09Qym
 ajuG37jpAt7Dh0lRICixw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lUHejbv5mA8=:9yg6u9yDdY5zdyf0A71T/V
 M+1Oj3AG4Y0u2lLIYX6b1dRUHJ8UyEiQgXjN0Ob7tXV0HLCPiW4uXSW1yaSIiry4hZfGnFNvl
 giJ8h5TVjqW+Zuxwe3UJpB2upPT16X26HZmoTxyQiZjLw77Dteph/S4B0y97RhbSw1T3YD+bQ
 59khZnwCYQcofaAxQSF+Ign42pS8pv0RPRdCKYJnhQQwOKtx9OVi9N8GXTRBvUdULnog2vTKT
 cEC3I45W7zau3YwhUC62VEBouzZ/XkodSBarbLmMWMzL2wkBZdcnggjCqSA5Ovmzf+HZYYT0D
 CEGaKN2wSBL2xBCSYmC4yOHaqiqd0cNQzgo0RtNhiSXWa37LHTEcHMfZqUe41Qg5yckdzKSkO
 7Z2/EyI9jpLx27lJNnGqksDPQIgg7fzahiNj6tYB8rYe+DJrrLcNgU3vKh8hb0q9OHvnN1iXJ
 nSZ7HnTSpuN8z1b8udwFDA5dX49bSRbD9E3qvg+ePr+YJYaG3fSomA5G5NT1f+W4xCMLEA+rb
 VtOxtCr4oCzMuKdvJi9lPHEipLD+G7fV0qTxk2LH38itTKCUnXUDmgY9htxT0GDcEt6GgCXd6
 WjDUose/HYhO5JKKJGLOO0Jj7pmIyC2XI8TAJ8ECxYGN1iVNpoqzoqKwZqta1jyBHhV5CKFdM
 HoHJSTATt0475xt+JtL42K+ltFElr+BIOhsUAwNopV2XOBWtugnm3A16xIPzeKSDqHoc7hHGa
 OTkDu761hPsbPPr38l6BvYAS/+lCqHR/qz008gqoLFgW2aM+QxbXn2vDon7Vf9xvArLH/C4r0
 4EqwvFcf/oOcVzeaXcU44YIXxhIL0ST7/N+POoexp35RuVEV5M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Sep 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Max Kirillov <max@max630.net> writes:
> >
> >> Tilda-based path may confise some users. First, tilda is not known
> >> for Window users, second, it may point to unexpected location
> >> depending on various environment setup.
> >>
> >> Expand the path to "nativename", so that ~/.config/git/gitk-tmp
> >> would be "C:\Users\user\.config\git\gitk-tmp", for example.
> >> It should be less cryptic

Thanks, Max, for your contribution!

> > It might be less cryptic, but for those of us whose $HOME is a
> > looooooong path, ~/.config/git/gitk-tmp is much easier to understand
> > than the same path with ~/ expanded, which would push the part of
> > the filename that most matters far to the right hand side of the
> > dialog.

Heh, do you want to know how that must sound to a Windows user? I'm not
saying that I am a hard-core Windows user, but I do know a few, and I
already hear their comments in their own voice in my head...

> > I somehow find this change just robbing Peter to pay Paul.
> 
> Having said that, because a set-up might have HOME or XDG_CONFIG or
> other things misconfigured to point at a place where the end user
> may not be expecting, I tend to think that catering to Paul by
> showing the information closer to the bare metal is much more worthy
> thing to do than keeping Peter happy.  Since this is an error path,
> accuracy trumps convenience.
> 
> So no objection from me (unless somebody else comes up with an
> alternative that would make both camps happy, that is).

To Unix/Linux users, the tilde (or Tilda, I really like that nickname, it
makes it much more human and tolerable) is probably *very* familiar.

As familiar, as it is unfamiliar to Windows users.

So I would actually suggest to make this a conditional on the platform: on
Windows, use the native name, everywhere else, not.

Sound good?
Johannes
