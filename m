Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090652022A
	for <e@80x24.org>; Tue, 25 Oct 2016 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756912AbcJYLj5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 07:39:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:53429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753776AbcJYLj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 07:39:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MUoiS-1cQU8g1o32-00Y6xy; Tue, 25 Oct 2016 13:39:42
 +0200
Date:   Tue, 25 Oct 2016 13:39:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] doc: fix the 'revert a faulty merge' ASCII art tab
 spacing
In-Reply-To: <20161024215432.1384-1-philipoakley@iee.org>
Message-ID: <alpine.DEB.2.20.1610251338520.3264@virtualbox>
References: <xmqq1sz9b9ex.fsf@gitster.mtv.corp.google.com> <20161024215432.1384-1-philipoakley@iee.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eKasFd+3Txtx5XyoeXXOM/5qtsVtWW29IumtCNbVYc9MPb+HfBZ
 QM+czaa0BLvqX1z7frVuNCMEoHbRABustVKO1mpgN69TQneLsZtbGFheSOF5YsQMUWeRuNi
 DEBiGgA9iUugV+SrtslC4lt97MBc01o2plemTwsFN2u0cT484cjn5wGjlHIaSUx5jY/niZL
 42fGKCzlXwikCtQjr+ycg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IKuNVl5FhPI=:8+X3G31hT+B4BHlMmHTE2v
 o+goZjWzwzq4VuTEYfXMMIXqxESXHNqTyCTvHtNjlVrW7HEHBTdFG9VxWVYiFS8SFrFXZv+vd
 jG4y00tYeMCdGSvmKd4guFyaiBGkg/GA0BMwoQ/OB+rwGhqb/txDb1difAlIn1bW+fEpv45a7
 8G3NwgnbyGnd2Ow8bkZ4b5zf/jgWkna2VeUEFVea8okyKhL+m7CvTmdDG1kwQWRnrp0kpAqii
 Y4u/bEH8y2b5zZVZFrqU9IK34dvf6nLOOM/zu919C+38UmrO4tN3qyxqoZQyCrEnDF6Js59Qm
 x0wobPLNVI3zevNh/yLvuL31Z1A0IQqE0H5oQno16uX8JECN4kOGMD7ZffaqDh7dyxK3y0JNV
 jKv3alUya0hpB5WmCOJe7KzRP2gFrMtpXLbgLDBNIuWzc0EPiQxLgC/c7wxLV3FzoCbw26dr+
 mwknQG611ln8kR8piH/Fk0UrQb+5ytNp74tCK/PYJCUqLXs1X1an0nXWP1bGMjmtUat0T88nk
 LB9JhLGbUYAnpzcWwg9MPJniJ/JmyhgyEHYrLqNbcNkRSgVIjTuXd6rTWuWPHdAFhH3WOU945
 xcLzgLTKnqm8x+2x8Au1Z/0w/jo+GjZfquWqFxlQevKaVEAnQ08nNk/Yj+s47QNSm1t3hZrDJ
 96j37GugLxzGexJD5Svqn05zvCu21+E5VjWHLPkTZB88nhSSGRXT3UghBmXHgHSyatayyU79O
 RLp8kf8JK/IpozxKXYsPBlba1QlJ0ECch6n25J885FMoDJtRRMJVHeKiPmOz7JvCY7Dyk8Yyr
 zVSQzAf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Mon, 24 Oct 2016, Philip Oakley wrote:

> The asciidoctor doc-tool stack does not always respect the 'tab = 8 spaces' rule
> expectation, particularly for the Git-for-Windows generated html pages. This
> follows on from the 'doc: fix merge-base ASCII art tab spacing' fix.
> 
> Use just spaces within the block of the ascii art.
> 
> All other *.txt ascii art containing three dashes has been checked.
> Asciidoctor correctly formats the other art blocks that do contain tabs.
> 
> Signed-off-by: Philip Oakley <philipoakley@iee.org
> ---
> The git-scm doc pages https://git-scm.com/docs/ does not convert this
> how-to document to html, rather it links to the Github text pages, which
> does respect the 8 space tab rule.

I confirm that this fixes the misaligned branches when building the
documentation with asciidoctor 1.5.4 in Git for Windows' SDK.

Ciao,
Dscho
