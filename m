Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81A42070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcGGPXM (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:23:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:49585 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbcGGPXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:23:09 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M92ZJ-1b9KeJ1InF-00CQxW; Thu, 07 Jul 2016 17:23:02
 +0200
Date:	Thu, 7 Jul 2016 17:23:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
In-Reply-To: <xmqqmvlusi7v.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607071721590.6426@virtualbox>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de> <xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606301019040.12947@virtualbox>
 <xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607020933080.12947@virtualbox> <xmqqeg76vmzb.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607061733200.6426@virtualbox> <xmqqmvlusi7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GkFaB14m+kruF+Q6haVcXS7sPkF4u3LC4XpTO9qfYxvZSrV3dAj
 WcX1Clf6j5dJi1Z5LLquDp2sfqDbaupCQ89+I2IYftrQfLd768ysEigEO+FWiWKgWa8MW+E
 H+GHFE8qeAiowiCbiRWgbQ/Z9N5EsgohdBnWqZnYPKe+PIZUKGel4W1Ikr3UldEwCWu4UiF
 LE9OdP268kxyh4+RMDYAg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/Ry9unuwpgY=:CzcwkCVAYiSruK11W1UT8u
 d+bq151osKhk5qb+HMv9o4ZjDf8/ZNMm3my8g5IqFmRVbPZ0LZc/CYu5GPVTm241/dSRoD/W/
 oH16i3HQwFlIHmdUlbyOFLxsOCqwLdNcnW6Li+SUCm7Qpl62rV0wyjLP8hqny49IPt4ovIDG2
 w2q95RMPr7NokWpGtxH5syBdbvtoJSiCsC+aRfUmA856071x3TU9iMwzy/JN8o0qBoabQEHwc
 obBhmvSrt+wP2XyX9BQAQwiUqKPVo//bqsiBQfTQaRtmnZ8COQbrxY7sk8v4jgfoDcXetkppb
 h+aYJtIl5lw31xDnph3NSjTopLaXfFAYJw+Pho1Qcrom3+LgK5C5cliV+xltNjIwiomzf7NXa
 l3hyyk9jfPAE5PyXr4+hCoye1RwwFJ7YYICrnhOpYBHg4UEkBwWFqQv2SMk3i/6r7LNSFJ8dX
 w2vvVjfqByahVvZe39XfLWjhpY1pf4ZIcY+ywrcAC8Qsn5MsazD0FECdbKoJNJqcAxkgnWpAt
 DnTLZQV4cOEfguQDz+ekUrfXTwPyYYcDuFrY7dSXMmNgEjcBkwm72w0GLOUBOW4CcqMvI/DAS
 JQyMikV/Edt4fHs30kNI5fkzHGjTi2GMYiCuxbP0sTrI45zsyxJBC7N9UMl9Yj0iWTTLPmRdH
 1xx/vBxNKUMM7FKA0kNiLrWpzrQP/EC67TFY4QDyZYNI3jzSU8CAZtnVdoIYr09m3M3lWGJrA
 07YRrSkGFkpzwgauGy3t8j/0EJbwnrQL3IxWsGDSYN+qn+u6WK0BlU8nD2Qs5xE31eIVbYDwo
 9v6Rs1T
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, so here is the deal: on the development machine where this was
> > developed, I do not have gpg installed. So please take this test case just
> > to make sure that things work as intended for the moment.
> >
> > Before sending the last rebase--helper patch series, I will make sure to
> > add a real test that requires gpg, and submit that, too.
> >
> > Deal?
> 
> I do not particularly care if the latter one happens.
> 
> The only thing I care about is that the earlier round documents that
> we know we probably should test the real driving of the GPG program,
> but we deliberately do not do so in the series, and hint that such
> an enhancement can happen later.
> 
> That might even entice others to help writing a test or two ;-)

Okay. I tried my hand at editing the commit message, and threw two more
tests into the patch series for good measure. Will send out v2 once the
test suite passed (it's still running).

Thanks,
Dscho
