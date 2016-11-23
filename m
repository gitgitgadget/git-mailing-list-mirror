Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0730F1FF76
	for <e@80x24.org>; Wed, 23 Nov 2016 11:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756167AbcKWLFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 06:05:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:52462 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbcKWLFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 06:05:37 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1c3QYF1EKY-00Bc54; Wed, 23
 Nov 2016 12:05:21 +0100
Date:   Wed, 23 Nov 2016 12:05:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] rebase -i: highlight problems with
 core.commentchar
In-Reply-To: <xmqqwpfvqwbq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611231204410.3746@virtualbox>
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com> <20161121190514.18574-1-gitster@pobox.com> <alpine.DEB.2.20.1611221709180.3746@virtualbox> <xmqqwpfvqwbq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HwhKjdy/J39Oh8RW1aG/0l/NUb54jGJSmH2Gj+UmnNwTjOOBK+p
 WvmEMEZhOt44wyGZqZ7vsvbvSip6KjZL7hEf4Pw2G8Kz8JWkGxxmMVWvY4cMMVTtmw29Mhp
 pohifYmCx2DKLyFocFts4jNhr5nim/0fKRkV+yo44TiIAeRi+nOPt14Zbii9pf2SNfTiL53
 8zyN5mlKxwijJBmLrONlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+VrXwmfhrYY=:fBMpvl+gVcMBbj8t2/spc1
 B908B8hfHc8nGsjcQK+5MupK2M5Dd5/T2bvN3+r190SBJbRqlVD8ejiCWufOcPszUwnBRZI59
 fNAdEfoEWkmYPIDtulQjknSfn4gh3HC1hYwYoo+A+3/bsFLoaNsRF5RTKDg7jJIIkYBSoxkYH
 zk2JXByvCvdddfZY6ntHktpf/+x9qXR2j4oXqqD+/fDJnng05S8enaWzwVejch3GlcW8+p3v2
 WwcjrkQrU05mt19m6pDvw7H8s8XdnUPFFFMSZNWmYg6aBl7onRd+Fk1lzs/cjqmbrzwO7uOuY
 JMK33W0ZEFCSh29E28vUEO6GTmxWzmFo63q0x4iYZJAIft8PfMZ0sOMVQsUse34OYiUfxHTFx
 XGbQyN/kFOUgFyyVjpa6BR+l4rjSguDofLSr3BLQMc0oqJS6H3npSN7AlYUJtYt9AsIl6Zkzc
 m0kNm+Anj5sd2jIDeqA+iAfXb32Hu3I/J15TIevilGi39+ilaTzGk6TvIIFIBFC4r1Kct5ZPI
 wjsfNkkkBvYwFqQY27KCNOUpF46h6o8Dqwkv1SAXgh99AxfoUDjI6UD73JAHT0nXmSSYpmbO/
 z/KRMZ1svy0hDq19ZnFvi4feZOI2cWZIx5g7Sa3jE9GXVWWiSFQqZTnYxGMY0trs/ZogPplyk
 NHkz42cfBWKLaFeql6dX22swA4pip3eSvCwNezYqiBd0EcrtATFX4LFfn6oHszSI0c9U/2TR+
 IbszzRxPCzi7jmYk48UTG4jmkhWknoq9/o+y2La67kXukyymfCajbTRGvrM0Tpfyp2vji1hWZ
 Guqx3DV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 22 Nov 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 21 Nov 2016, Junio C Hamano wrote:
> >
> >> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> >> index 29e91d861c..c1f6411eb2 100755
> >> --- a/t/t0030-stripspace.sh
> >> +++ b/t/t0030-stripspace.sh
> >> @@ -432,6 +432,15 @@ test_expect_success '-c with changed comment char' '
> >>  	test_cmp expect actual
> >>  '
> >>  
> >> +test_expect_failure '-c with comment char defined in .git/config' '
> >> +	test_config core.commentchar = &&
> >> +	printf "= foo\n" >expect &&
> >> +	printf "foo" | (
> >
> > Could I ask you to sneak in a \n here?
> 
> The one before that _is_ about fixing incomplete line, but this and
> the one before this one are not, so I think we should fix them at
> the same time.
> 
> But does it break anything to leave it as-is?  If not, I'd prefer to
> leave this (and one before this one) for a later clean-up patch post
> release.

Fair enough.

As a matter of fact, we do not even need to change it later. If it ain't
broke, don't fix it.

Ciao,
Dscho
