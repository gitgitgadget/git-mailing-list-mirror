Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609CE208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdHLQUZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 12:20:25 -0400
Received: from mout.web.de ([217.72.192.78]:58291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdHLQUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 12:20:25 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVcZf-1e7Hke1um7-00YxCF; Sat, 12
 Aug 2017 18:20:23 +0200
Date:   Sat, 12 Aug 2017 18:20:23 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Soul Trace <S-trace@list.ru>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git am sometimes unable to apply git format-patch output
 file
Message-ID: <20170812162023.GA21045@tor.lan>
References: <a6e69bd1-b91f-3150-c3a6-9378793e5e43@list.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e69bd1-b91f-3150-c3a6-9378793e5e43@list.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:mZh7KdIqx9eSM4SzxPE1fNmXVUnR8J+CQbK/JnzoS2IGR9kaezX
 2gm8yWk73rQpQst23kAGE7lkrWgdyQFuSpyuHoU5LXWcYBKWzWMCw8nV0xRLn04SoNSdlO6
 Wym18zl+iTec+XyKNUz6B8DMsHmFyVjdBHkYaOaJGsRH5R4dvTmPeY8Xj5FGasMpA4xNONp
 m4ZW3gl0l9lq3Bp1zquTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F4S8aj/G9gg=:8VYDzkRncbdUlJt7xBdNIR
 mz08S8IYFa8jG+6ob8PxCZDikB6wZZk8/E3hka9BKZQXMkCu2bsQZ3yQx5txcaREizECyag/F
 wfyRWsukv28OurwZD/+mRXk0nMcD33O/o7qO1LE5jTNH0WybKcAmm9NxzoJkq+CVbuLbUK4gi
 eZEOJnUzkEXoYeHnpLpYZ0HxOJKIEn+Uoy5z6uz6aZW69Plxom5UFgiROw+kTlmMWjiPbIriy
 ON8RCiOX9+gf8FseWmp9kOUF+tPbiRago2TS7r53emp/Cn50JV2WLRSDuatwSQIkaHGpXwvtF
 bdYX2EXGqs6Hr4zcYiVeIwaC7DYdz/5+BJTEw9fxHyzmSKiTz0f/83nn8eSTkAgGj/nUPaJrf
 vIP8JaPFc601wqqgQ2/2Whf6FvzUyCAO/MEkWiMq5NHVJkkwhD2JRzXsxxMgHmN50dj0s082f
 O0Jkt3TKo667Dy9LGtnBqVZTrTRgbbjaNczTlu1CSixm16P308zeFMJc6ZN8P2CE4GJEBTtXf
 Wlz7r3mUrrDgSJOQMRFpl/TYU42TSHSijfB4aLfzCO6y3XhYJ6lJqwTi3gtDP44jbBtX6KCTO
 CZ6AHbq8YlFryT1rtuAzhGEW2vLgMGAN/Hcdb/wIPQkO0JtRIJj3RyXYi8QYmCNkvX2fmCFV6
 4gzFLqO/j1tXwreUxV28ECLWHjVPw+6W1XBdYu+SRdc3DnOMXq/q8FEmlaBXouhmK53EixWGJ
 oLwPnK2IdRwotrZfo77v3DbTuq4mRpC395+XrXr9E6d2dPN2CySDGZNvrivAWzVBjIhb5X0TT
 XufGiY4j6AJ/EHU/ShW1krgpfp0gg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 07:02:59PM +0300, Soul Trace wrote:
> Hello.
> 
> Using git i have found that git am command may sometimes fail to apply patch
> file which was created by the git am command.
> 
> 
> Steps to reproduce:

Excellent, thanks so much for the detailed bug report.
This kind of information is really appreciated.

Why did I say excellent ?
Because I am working on a patch, which -should- fix exactly this kind of issues.
I send out a patch earlier this day, but it doesn't fix your issue, even if it should.
I hope to have a fix soonish.
