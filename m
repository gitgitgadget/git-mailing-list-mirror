Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7A820D16
	for <e@80x24.org>; Tue, 31 Jan 2017 01:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbdAaBMt (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 20:12:49 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdAaBMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 20:12:48 -0500
Received: from linux-7ekr.localnet ([89.15.67.211]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0Md04s-1cpLbh1dZq-00IGKa; Tue, 31 Jan 2017 01:54:55 +0100
From:   Cornelius Schumacher <schumacher@kde.org>
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC] Proof of concept: Support multiple authors
Date:   Tue, 31 Jan 2017 01:54:53 +0100
Message-ID: <3204990.cGxpkETTLk@linux-7ekr>
User-Agent: KMail/4.14.10 (Linux/4.1.36-44-default; KDE/4.14.18; x86_64; ; )
In-Reply-To: <xmqqinowuvd7.fsf@gitster.mtv.corp.google.com>
References: <1485713194-11782-1-git-send-email-schumacher@kde.org> <CAP8UFD3=vaFupEDay-5vrMBwK_YJezysUUvySxnUUZxuW7m_WQ@mail.gmail.com> <xmqqinowuvd7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:7xJNZFmtrkjndqOdjsUtTCeOJRimXZQOtDwRMxX3q6qMGb/FJJs
 A+BA9m/2rXLsW9kBYi3Uydq3mR/dNjC9dgjsUUgea2zGMcx97c80NieQbDYgI3yiLkxcUk8
 E5/YugT/WSuYVWdX2e9E/4zlTbsPFC/FwJWXR6tukdf48CW6pRF3p9lv1YvlehsE0lDYGUI
 vQYOzHmvhzA73rl0p2pTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nUcJxxsOEdo=:72ZIMffzzQxADcRk3qxCy+
 xI3Dqy8yXF3Z5jhzXVQdRegRUXFKA/i8jySZQN3aa90j3OCtSZeUMPUkkXw2FppsYevmvTijS
 qp1kYZyH4/QkytzJyyy91N32Cb3HLR01qqMtLT8AMDcbKz4uI4It7JKC+a7jVj7sMj2q89cgL
 veiAD3LmRdzvh5pDJUNyQozFmeeKTn0EOBZHNyCeShvODBtLPGM8O0MxKJ+OuIsfdjCOf35vD
 HdqRsnqsY2YkmztmPfpkb/6UJpcHSbxTvpRq6jObQWpXUHmyVGRn8ilx+N2egNNms50gGQZOq
 +MZJtmehIw8/KXfUHyCiZi6QnsgXLSHDSGstu1pDQ4+JtdhnQ86VQd1QVH07jGZuNvhQSguYM
 o1LzRVYC0u10HvVdHhT/q2uEqT/T+1YvfSzwjb/+yZLhcqUF5Z+dHSTtewBLsByITbCkCeut7
 LJnmSGmSQ+fnYmAvC/m22bQ9WxUxaY2ZxWZnuzz2aVp6vsN1Cmvd3V7Mnjl+ALEcRTIrslbki
 xDKZilP7cjPG4MNjm8ZYlJRVqMyKQeifJRi2oiWjw+PztiAS7SWOC55YRe5PdLPLs9ORQfmWf
 BbDA+JYMeV6W7+nk5JH5L3qvFbb4ONCGztifjXPSr3vXdIaU0kyNIaMsE48XINBpR8wjrfvMG
 Zh6YOvfciIhPjkGS0s+8cYIACohLU6bPUun70XlQtIR7s+ozFZsu1A4WteBxES5GIC8D+OkqB
 Nlvx2scez5W97ntX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 30 January 2017 12:48:52 Junio C Hamano wrote:
> 
>   https://public-inbox.org/git/?q=gmane:83880
>   https://public-inbox.org/git/?q=gmane:146223
>   https://public-inbox.org/git/?q=gmane:146886

Thanks for putting the links together. That's very useful as a reference.

> The older discussions already cited the cost to update both in-tree
> and out-of-tree tools not to barf when they see such a commit object
> and one of the reason why we would not want to do this, and Ted Ts'o
> gave us another excellent reason why not to do multiple author
> header lines in a commit object header, i.e. "How often is that all
> of the authors are completely equal?"

Just to give a bit of context: In the pair programming environment where I 
work we usually use non-personalized workstations and switch the keyboard 
between the two people working together quite frequently, sometimes every few 
minutes, or even within writing a commit message. There the person pressing 
the return button on the commit really does not have a special role. In this 
style of working I think it feels like the fairest and most practical 
assumption to treat all authors as equal.

> My advice to those who want to record credit to multiple authors is
> to treat the commit author line as recording the primary contact
> when there is a question on the commit and nothing else.  Anything
> with richer semantics is better done in the trailer by enriching the
> support of trailer lines with interpret-trailers framework.

Thanks for the advice. I think I will explore this direction a little bit 
further and see how handling a situation of multiple authors could be better 
done in this framework.

-- 
Cornelius Schumacher <schumacher@kde.org>
