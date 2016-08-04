Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E6820193
	for <e@80x24.org>; Thu,  4 Aug 2016 14:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbcHDOxS (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 10:53:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:49509 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbcHDOxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 10:53:17 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MQhyf-1bh7Jj0BTx-00U6PV; Thu, 04 Aug 2016 16:53:10
 +0200
Date:	Thu, 4 Aug 2016 16:53:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Lars Schneider <larsxschneider@gmail.com>
cc:	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
In-Reply-To: <4A2D83B3-916C-4FC8-BBEF-4D55C3204DFA@gmail.com>
Message-ID: <alpine.DEB.2.20.1608041647520.5786@virtualbox>
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com> <4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com> <20160804113256.6idrdzfgolm4ne4o@john.keeping.me.uk> <4A2D83B3-916C-4FC8-BBEF-4D55C3204DFA@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dxmk3ZD5Ug7toJyOslaME9ebIf/0xvhLYJxSuJoC/tr5/ZlIIzt
 HkL+kIzBWPLLBP1CRpxglfgUML1uZ/YD4Z3G4aAs8kcyzQqWEkk/I4Bqdjc2LBaN59JxTn+
 XlCQ1tNYjCGS5Qx6+M9BeJy1cKU0Msrwk5TBq2WzlW1jtj9iVaBUIWO9hnMbHC1d9CpWIPU
 xjal2/9ekw51uRBUdGdnQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9bO1gG+Dsrk=:dNwqisft+sTk5kPN+LzcFW
 EU+sslRbh69zyq9wGBMQ3DJhb+WIF8w8MWXK3nee4KexFIwssLN7rUg9Vf7n4tGH2kyWPbA1H
 RSpKxT8H6BU0EHEb31pCbCiJO8/ggrj4dBhggyf4FJ7jPWGf8/TSuk8WPx8wHCMYWrxkc394Y
 gB6GI9nOu/xtKTyjeN2OmvpHsKA0GF/C8bNRz/95lbZYardi8nL4rehLvz8n605Ecoe8nxoNr
 lxHwu1O/haYPKS8wwLdWkXY61bfs+RdrwqbO+5prcEVVieGN6OWmyGItnoRy7b6pvrFemTwmv
 lcxfn2LV3xjcqOW9MkeiaYx5jGsqhyZ1AqE6Qzj02LXBwz0CX7xkki2hIuUMso2O6hhQNPfE2
 FyKXLsUtxfL0SsQYu/pNcdDXQtyO8seTvtG6R4JeK3dUCFsJePlwilhfmrlQJAlVX6x8Be/lX
 HkVqyVa1gek8KPrAxPvVi8EDxAYuKNBo4cVDMVLwy68Z6rfHz8fzTX9asdyjgsYh9e6keZjSL
 xsafHDlQufE+gN3rQ+aLM2Oj2ViDe/cj4qzjf1gzinRsNGee7N7zuXO2AuI1rYq0VJPRki0As
 URR2MHi1Xw6AR/4R5uXr9ZTp1yX217Kh/YTFc9qh0xK2l54XIRUZ1/yLBg/8fCOf2cik3wZd3
 HFmNmj2rOwxXtAVmmtsnk0AkJUgJjkKoV0L22/cI2x0MJP/3nS2ZfWkeOBDpvi//SRhDpuc02
 8mvr81AWco5JtvG+84EKbfqedPJ3uUWG64RCB6aePWNJJ/ydI1NN0r/GIY1++BftEBn6munml
 AD6TXCC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Lars & John,

On Thu, 4 Aug 2016, Lars Schneider wrote:

> > On 04 Aug 2016, at 13:32, John Keeping <john@keeping.me.uk> wrote:
> > 
> > On Thu, Aug 04, 2016 at 10:03:39AM +0200, Lars Schneider wrote:
> >> 
> >>> * jk/push-force-with-lease-creation (2016-07-26) 3 commits
> >>> - push: allow pushing new branches with --force-with-lease
> >>> - push: add shorthand for --force-with-lease branch creation
> >>> - Documentation/git-push: fix placeholder formatting
> >>> 
> >>> "git push --force-with-lease" already had enough logic to allow
> >>> ensuring that such a push results in creation of a ref (i.e. the
> >>> receiving end did not have another push from sideways that would be
> >>> discarded by our force-pushing), but didn't expose this possibility
> >>> to the users.  It does so now.
> >>> 
> >>> Will merge to 'next'.
> >> 
> >> t5533-push-cas.sh "16 - new branch already exists" seems to be broken 
> >> for OSX on next. Git bisect indicates that "push: add shorthand for 
> >> --force-with-lease branch creation" might be the culprit.
> >> 
> >> https://travis-ci.org/git/git/jobs/149614431
> >> https://api.travis-ci.org/jobs/149614431/log.txt?deansi=true (non-JS)
> > 
> > It seems that the test script has already done "test_commit C", so the
> > newly added "test_commit c" does nothing on a case-insensitive
> > filesystem.
> > 
> > Something like this will make the test more consistent with the rest of
> > the file:
> > 
> > diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> > index 5f29664..e5bbbd8 100755
> > --- a/t/t5533-push-cas.sh
> > +++ b/t/t5533-push-cas.sh
> > @@ -220,7 +220,7 @@ test_expect_success 'new branch already exists' '
> > 	(
> > 		cd src &&
> > 		git checkout -b branch master &&
> > -		test_commit c
> > +		test_commit F
> > 	) &&
> > 	(
> > 		cd dst &&
> 
> Confirmed. This patch fixes the issue!

Funny. I worked heads-down to have some kind of Continuous Integration to
run on my laptop, and this breakage came up. I fixed it locally, and only
then did it occur to me that it might have been fixed already, and then I
found this mail with a patch identical to mine.

Will send out the patch in a moment.

Thanks,
Dscho
