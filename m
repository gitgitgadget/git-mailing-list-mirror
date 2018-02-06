Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2191F404
	for <e@80x24.org>; Tue,  6 Feb 2018 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeBFU0E (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 15:26:04 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:42011 "EHLO
        outbound-ss-1812.hostmonster.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751558AbeBFU0D (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Feb 2018 15:26:03 -0500
X-Greylist: delayed 1410 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Feb 2018 15:26:03 EST
Received: from cmgw3 (cmgw4 [10.0.90.84])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id E8D7F175D18
        for <git@vger.kernel.org>; Tue,  6 Feb 2018 13:02:29 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw3 with 
        id 7Y2S1x00y0QvKlu01Y2VjV; Tue, 06 Feb 2018 13:02:29 -0700
X-Authority-Analysis: v=2.2 cv=XM9AcUpE c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=0WrjZphy2NLBcgfklpoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hF+IXKzo5VudM0EFP/vT30DspnmEdbfhNYEJlpocvR8=; b=bMcb2Q8NC6auxmrRsrTbVfFixu
        Ldyda0b1FyEQ1SnWcuhgR8nuJA8W8VqXbpQ3R/rjzSEAZNqViXDYLTeh33pkcnEEQRWSbBTtddjRc
        mHfDlRMTiUN4R4to8tXDg8x61;
Received: from [50.226.24.42] (port=53250 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1ej9Ri-0007Tk-7R; Tue, 06 Feb 2018 13:02:26 -0700
Message-ID: <1517947345.10111.103.camel@mad-scientist.net>
Subject: Re: "git branch" issue in 2.16.1
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jason Racey <jason@eluvio.com>, git@vger.kernel.org
Date:   Tue, 06 Feb 2018 15:02:25 -0500
In-Reply-To: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
Organization: I may be mad, but I'm a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Exim-ID: 1ej9Ri-0007Tk-7R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:53250
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2018-02-06 at 11:49 -0800, Jason Racey wrote:
> After upgrading git from 2.16.0 to 2.16.1 (via Homebrew - I’m on
> macOS) I noticed that the “git branch” command appears to display the
> branch listing in something similar to a vi editor - though not quite
> the same. I don’t know the technical term for this state. You can’t
> actually edit the output of the command, but you’re in a state where
> you have to type “q” to exit and then the list disappears. It’s very
> inconvenient and it doesn’t seem like it was by design. I’m using zsh
> in iTerm2 if that helps. Thanks.

I think you mean that you're in the pager (less(1), most likely). 
Many/most Git commands that can generate a large amount of output (git
log, git diff, git show, etc.) will automatically send the output to a
pager so you can scroll through it easily.


The man page for git branch says:

  CONFIGURATION
       pager.branch is only respected when listing branches, i.e., when --list
       is used or implied. The default is to use a pager. See git-config(1).

So, if you never want to use the pager for git branch output you can
configure the pager.branch option to set it always off.

Or you can use "git branch | cat" so that stdout is not a terminal :).
