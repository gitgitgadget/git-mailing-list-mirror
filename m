Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD9A1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfI3Vku (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:40:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:37981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfI3Vku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569879648;
        bh=lSsTiLXq8mS1c5w/SeJc3ahR3RORNRLKeEQLKo5Ss08=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eQpQHcrXMSjhwyAdkylpt5oX5k1xchHva8wuihU0y9aVY6Kw1n7nn+gHM101lwb7f
         gL5bJtOvMNxFA3ItKziXGVlQGvnOpb8kUhzg2cLScgTWBNNj0x4t0UGgIdAmzcOFN8
         Aqm7lEAg4YEXlagbdOFvo50mvR4NzF6S7fRDAiAA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1i3rKJ2G3H-017COl; Mon, 30
 Sep 2019 19:30:38 +0200
Date:   Mon, 30 Sep 2019 19:30:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kunal Tyagi via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kunal Tyagi <tyagi.kunal@live.com>
Subject: Re: [PATCH v2 1/1] git-add--interactive.perl: Add progress counter
 in the prompt
In-Reply-To: <xmqqeezyin3e.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1909301929270.46@tvgsbejvaqbjf.bet>
References: <pull.349.git.gitgitgadget@gmail.com>        <pull.349.v2.git.gitgitgadget@gmail.com>        <a9c590689931ebc49e91c56d8a095f66193801c2.1569720616.git.gitgitgadget@gmail.com> <xmqqeezyin3e.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kcSN8ZRvjxP9ogy7/cySaSg2BDgmoII0dL/gTGLMcV0QyAlBDQ8
 KxEx3yqfeYdZfXfxq7tCw2qL6m+znMqE4Rwn9UihSRBSyLJBqmDjnY+AIeBGL7AU8N1Jbsi
 ad1N5Q3IRLRwLYofX111p+Fv/uI2yNWIqxTn8kMglZjkUDPFVZFWoMVj2RCB448Xt6fHOMi
 0mQm0Jj9MnOhKty+Yilsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b+EtWKPuBJM=:j1iI/LgvUgZkPIzNanbfeA
 X7YBfgAkqWjd/m96+oK74UR4GNUJw50oMxjwDOgjexY6xQ+ssHVJPAJhhwiH/VhLO0Uu3ApCa
 wLRz/+Kpoy6q4R+/9mVWfRHAAUFB10Prxkttd4sHfd0adlaaTwYUDPd9PHJy2QEj9Tlv5UNy7
 UV+fnjHVGEj0Tcrx8aovL0jNQ+rAOslqARBr0htnIh4rC36AMCyynsshlyA1T9+3mL12mAiRL
 DbfL5X7pzSpniUhaCiVsdO6IzNlPF71BaXpEKfludFtPU4RLHTsiVcwF9UkEvt+FTi437+r+0
 2o5aCXpny3o5mlDLp8u/uEJJcDLHeMG4AXMdeEobT5br9/f8Uuy5G2I6tIjkKHM/2Mhix6t/f
 JgDB8wfhrWCXKD6KA5KgyjaL25Wx08bhGQQyqU87kilzgum0dFgrwQFw/+lZ0WOVaTM8Xb0Zh
 5hRLMMCT0+VxptcPSRF/B455ouYkXryGgZEVZTfIYbwYwoVcdXH2jFBZlYZnRAASOf6xvNmPo
 4AfSquG9ub6UMLeCIzXW8e6u7bG6oP6Oz/X2s8T7rntQRAezL2FY0+GhOdtOP3a1QPWjGZ6Ap
 qnHcnNGfE/ErrT0rfEgozTSjvZMWTMvPedzCpgzeTPyOz/IP5+Jd98PjkxMA0EdM811Cm2Okn
 +GgMzbddPMVjIIFCmx+6BE5DAed8n2yE5ink9uWEHYlCvU0N3Cc3HWNqQk82nFCKW852LC+5f
 sIZZMQ35YGpud5Xb6HcA/vfX8pzdZfekCA09KUHYmN3VmLk84ZlMU/M61+yj/X7Fv9CoXf4DU
 TqIKqJpFlh/y2rXYjxff36pe6Y3WGSm7PbLYaBOFtWdmHIhQe6HpRFxtkT5UmSg9RThITHw5X
 U8TbCvaqfOzmBZlNtJWi0rIt+dYJPMOOBryFtAow0adbb4mB9BgX2QD93YOrkABokMqr4RSX+
 S0+WTenIwevYCcxOo2FWcW65QfEsUwBEO4EfBakdBt/F3hKl9rChUwp+WEmWmjY0yggUIaQhh
 /Qxb7jr68ZYgXsYwXq38yUc/s9UIEubxABpFlIy/gxz5sH5Xwe+089pf4kGGgTs5KnSWfxtT7
 HLd60hFIgI+psR3JLOEIcTdhbuJZFg4esiI24+/fYS1J46Q1A3X1kM0VPSO8PI/eQWYvNqpUk
 HrvBWlrUS26/6gGQBjAm3T0A5psHN660x1g/78vEanrWgBa8k0SieVLSQVLoXFuwbI1XzDKus
 2+A+wY5kHVZbwGVtQpKj7ij6nnjXv8mCENnHolqUrs0WPsOM9MThCavsdwp8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For completeness: this is what the contributor wrote in
https://github.com/gitgitgadget/git/pull/349#issuecomment-536405428

Thanks for your comments. I've modified the patch and I hope it is more
suitable now.

I just used a repl to get the output and sent that as a patch. I don't
really know perl (though printf syntax is almost universal).

Cheers
Kunal Tyagi

On Mon, 30 Sep 2019, Junio C Hamano wrote:

> "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Kunal Tyagi <tyagi.kunal@live.com>
> > Subject: Re: [PATCH v2 1/1] git-add--interactive.perl: Add progress co=
unter in the prompt
>
> Either of these two, perhaps (I'd use the former if I were writing
> this patch):
>
> 	add -i: show progress counter in the prompt
> 	add -i: add progress counter to the prompt
>
> Give an order to the codebase to "become like so".  E.g.
>
> 	Report how many hunks have been processed and the total
> 	number of hunks in the current file in the prompt, and
> 	adjust the expected output in some tests.
>
> 	Signed-off-by: ...
>
> > Adds a feedback regarding how many hunks from the current file have be=
en
> > processed and total number of hunks
> > Also included: changes to the test script due to change in expected
> > output string
> >
> > Change in UI: displays '(${current-hunk-id} + 1/${total-hunks-in-file}=
)' before
> > displaying the current prompt during user interaction
> >
> > Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
> > ---
> >  git-add--interactive.perl  | 2 +-
> >  t/t3701-add-interactive.sh | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> > index c20ae9e210..51c30e08cb 100755
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > @@ -1541,7 +1541,7 @@ sub patch_update_file {
> >  		for (@{$hunk[$ix]{DISPLAY}}) {
> >  			print;
> >  		}
> > -		print colored $prompt_color,
> > +		print colored $prompt_color,"(". ($ix+1) ."/$num) ",
>
> Don't omit space after comma. or around the "." operators---if you
> want to use "." here, that is.  I am not convinced it makes the code
> better to use ".", though.
>
> 	print colored $prompt_color, "(", ($ix+1), "/$num) ",
>
> is probably how I would write this, as I expect those writing Perl
> would know that elements of a comma separated list fed to 'print'
> are shown without any extra space in between.
>
> >  			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE=
}}), $other);
> >
> >  		my $line =3D prompt_single_character;
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index 69991a3168..3a2d9fb607 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -314,7 +314,7 @@ test_expect_success C_LOCALE_OUTPUT 'add first lin=
e works' '
> >  	git commit -am "clear local changes" &&
> >  	git apply patch &&
> >  	printf "%s\n" s y y | git add -p file 2>error |
> > -		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
> > +		sed -n -e "s/^(.*) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>
> Shouldn't this pattern be a bit tighter than "(.*)" (i.e. anything
> can come between paren)?
>
> >  		       -e "/^[-+@ \\\\]"/p  >output &&
> >  	test_must_be_empty error &&
> >  	git diff --cached >diff &&
>
