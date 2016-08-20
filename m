Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6265E1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbcHTW1U (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 18:27:20 -0400
Received: from nskntmtas03p.mx.bigpond.com ([61.9.168.143]:20370 "EHLO
        nskntmtas03p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751510AbcHTW1T (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Aug 2016 18:27:19 -0400
Received: from nskntcmgw05p ([61.9.169.165]) by nskntmtas03p.mx.bigpond.com
          with ESMTP
          id <20160820222717.EEMT2042.nskntmtas03p.mx.bigpond.com@nskntcmgw05p>
          for <git@vger.kernel.org>; Sat, 20 Aug 2016 22:27:17 +0000
Received: from x220a02 ([124.176.162.61])
        by nskntcmgw05p with BigPond Outbound
        id ZaTF1t00V1KnNGU01aTGX7; Sat, 20 Aug 2016 22:27:17 +0000
X-Authority-Analysis: v=2.1 cv=H9gmuLsi c=1 sm=1 tr=0
 a=n8emWgr/hVQHB+p2EsdSZA==:117 a=n8emWgr/hVQHB+p2EsdSZA==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=7z1cN_iqozsA:10 a=1f_8sUU9AAAA:8 a=vggBfdFIAAAA:8 a=FXR6WkdROIu92lcalQMA:9
 a=CjuIK1q_8ugA:10 a=YINEebd3GXqNeZDW032c:22 a=ulBnneXc4k8OkFd-VeVl:22
Received: by x220a02 (Postfix, from userid 1000)
        id D9AF1260040; Sun, 21 Aug 2016 08:25:19 +1000 (AEST)
Date:   Sun, 21 Aug 2016 08:25:19 +1000
From:   Zenaan Harkness <zen@freedbms.net>
To:     git@vger.kernel.org
Subject: Re: git rm --cached should be git rm --cache or git rm --stage
Message-ID: <20160820222519.GC5044@x220-a02>
References: <20160820072214.GB24992@x220-a02>
 <91F685E894D94BB89892C695B8C1796E@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91F685E894D94BB89892C695B8C1796E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2016 at 08:14:25PM +0100, Philip Oakley wrote:
> From: "Zenaan Harkness" <zen@freedbms.net>
> >
> > Please CC me :)

> >  or perhaps something like:
> >  "does not unstage a file, it actually stages the removal of the
> >  file(s) from the repo (assuming it was already committed before) but
> >  leaves the file in your working tree (leaving you with an untracked
> >  file)"
> >
> 
> The easiest way is to simply swap around the two sentences so that the
> positive action is listed first - this better matches people's typical
> cognition. Human Error (by Reason)[1] tells us to Never state warnings and
> caveats after the instruction, and preferably be positive.
> 
> "--cached:
> Working tree files, whether modified or not, will be retained unchanged.
> The option will remove paths from the index (only) to unstage them from
> future commits."

That's much better. +1. Thanks.


> >
> >The git "stage" is a primary concept, and a primary noun (one reason
> >many of us have come to appreciate git), and git's cmd line options and
> >help docs ought reflect this.
> >
> >Thanks,
> >Zenaan
> >--
> 
> Philip
> [1] https://www.amazon.com/Human-Error-James-Reason/dp/0521314194
