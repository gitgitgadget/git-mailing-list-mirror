Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C6520798
	for <e@80x24.org>; Fri, 13 Jan 2017 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdAML36 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 06:29:58 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34800 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdAML35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 06:29:57 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so8120664pfb.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 03:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=531mjx5qG3jf/rRB75ZQdr8kRbL9WFlKHs/Wm/itHSs=;
        b=vhTAOxjXl7aw+n+ASD35LSne8YAlQm0zpsuagWcdkHyzGBuCD7JWHpMvzBO2pHBeGr
         0Hs4JIKh/g5Fw+ZOdceiWNXXOm40sORhFZ3a0DDNPEVVyy0j0NYz+XKavd6YSTqSr4Gi
         YFVIlYP6Ok5AJYnCyONnR1vJLmRibCg4jaRFdW4nCNf8nvH+f9eZM7Gh94T3we76mdOG
         a41wVHbnT+zUQH0sLkbLO8CUVuxeHCG63i9VQTLIhCtcAnZmrel78OPpLA0fpyZ0lA7R
         MQZH7/I9X0ELudiDBgG6ihGudYDkH35LKLmzd+DMahnXPgGyA4cYFzJntdFhTdbLIAc8
         au5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=531mjx5qG3jf/rRB75ZQdr8kRbL9WFlKHs/Wm/itHSs=;
        b=CigIJEQSBXPqjg67XaLJh5UMyIsyVafO+vrV7wUZZyjdiZKZc971L490koH0P4otHM
         LYAE7ceVnzgCUjicMY8BHuHY7mTet2kv+FAQMASwfgtN+wZvaP/VRAVHTTikqpWL5WSq
         QQJ6MQv06VU18ZmWOX+A3aGupu7ksBtkvr5rdc5I9dhMuR2Jsdgcm7O6B79v8lVH9eLi
         lsGNLFh7tOigVkw+NgN9rhw40wbEWCX5TFEi4SYI4a9SYW/lLSXhCR3nON556ukOTsXi
         VoUv1g498otEczQCQMxN9d0ME9WYrwTKQWtimjsDi45U+A6LnmD1l2chWJ0uRai8Qyme
         y1LA==
X-Gm-Message-State: AIkVDXKgVrlhaLhZ4VkI85LVmVksYf6Qn45WfIQcMp7Hzefzq9Fp8v8bpMS2yPm5yLbcow==
X-Received: by 10.99.53.195 with SMTP id c186mr23659359pga.24.1484306448537;
        Fri, 13 Jan 2017 03:20:48 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id l3sm28771305pgc.41.2017.01.13.03.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jan 2017 03:20:46 -0800 (PST)
Date:   Fri, 13 Jan 2017 03:20:43 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Andrew Janke <floss@apjanke.net>,
        Paul Mackerras <paulus@samba.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk: "lime" color incompatible with older Tk versions
Message-ID: <20170113112043.j7nowdilolswyk2k@gmail.com>
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
 <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2016 at 09:20:43AM -0700, Stefan Beller wrote:
> + Paul Mackerras, who maintains gitk
> 
> On Sun, May 1, 2016 at 10:03 AM, Andrew Janke <floss@apjanke.net> wrote:
> > Hi, git folks,
> >
> > I'm having trouble running gitk on Mac OS X 10.9.5. The gitk program uses
> > the color "lime", which is not present in older versions of Tk, apparently
> > including the Tk 8.5 which ships with 10.9.

Ping.. it would be nice to get this patch applied.
I can verify that gitk on Mac OS X 10.11 also has this problem.
gitk is usually pretty good about backwards-compatibility.

> > This compatibility problem was noted before back in 2012, in
> > http://www.mail-archive.com/git%40vger.kernel.org/msg14496.html.
> >
> > Would you consider switching from lime to a hex value color, for
> > compatibility with users of older versions of Tk? A patch to do so is below;
> > only the file gitk-git/gitk needs to be changed.

I can recreate and resend this patch if needed; it's simply:
:%s/lime/"#99FF00"/g

Would a re-roll of this patch be accepted, or is it not worth
bothering?

Google for "gitk lime" to get a taste for some of the fallout
caused by this problem.

The fact that multiple pages, with different OS's, have examples
of users stumbling over this change is a good hint that it's
worth fixing.

Thoughts?
-- 
David
