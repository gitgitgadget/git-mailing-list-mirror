Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EA11F6C1
	for <e@80x24.org>; Sat, 20 Aug 2016 08:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbcHTIfr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 04:35:47 -0400
Received: from nskntqsrv01p.mx.bigpond.com ([61.9.168.231]:63599 "EHLO
        nskntqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751640AbcHTIfp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Aug 2016 04:35:45 -0400
X-Greylist: delayed 4286 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Aug 2016 04:35:45 EDT
Received: from nskntcmgw07p ([61.9.169.167]) by nskntmtas03p.mx.bigpond.com
          with ESMTP
          id <20160820072703.ELRB2042.nskntmtas03p.mx.bigpond.com@nskntcmgw07p>
          for <git@vger.kernel.org>; Sat, 20 Aug 2016 07:27:03 +0000
Received: from x220a02 ([58.168.229.151])
        by nskntcmgw07p with BigPond Outbound
        id ZKT31t0083GeBn601KT3fH; Sat, 20 Aug 2016 07:27:03 +0000
X-Authority-Analysis: v=2.1 cv=M5iwUHEs c=1 sm=1 tr=0
 a=gm2JgIm3B1ma6n2s4AHsSw==:117 a=gm2JgIm3B1ma6n2s4AHsSw==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=7z1cN_iqozsA:10 a=uPZiAMpXAAAA:8 a=kdnEy5AtthrmS9qHXqwA:9 a=CjuIK1q_8ugA:10
 a=kKlv5diQZ1kA:10 a=svzibyHiZmA4t4YY0eFS:22
Received: by x220a02 (Postfix, from userid 1000)
        id 03E24260040; Sat, 20 Aug 2016 17:25:01 +1000 (AEST)
Date:   Sat, 20 Aug 2016 17:25:00 +1000
From:   Zenaan Harkness <zen@freedbms.net>
To:     git <git@vger.kernel.org>
Subject: Re: git rm --cached should be git rm --cache or git rm --stage
Message-ID: <20160820072500.GC24992@x220-a02>
References: <20160820072214.GB24992@x220-a02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160820072214.GB24992@x220-a02>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

   Please CC me :)

> From man git-rm:
> 
> --cached
>   Use this option to unstage and remove paths only from the index.
>   Working tree files, whether modified or not, will be left alone.
> 
> 
> This wording is unclear and dangerous, and ought be cleaned up somehow.
> 
> Probably also the option name should change.
> 
> See here for examples of community self-help compensating for git-rm man
> page's particularly bad wording:
> http://stackoverflow.com/questions/6919121/why-are-there-2-ways-to-unstage-a-file-in-git


Also, perhaps a git porcelain command "git unstage" to unstage staged
changes.  Something small like this might make a huge difference for git
newbies.
