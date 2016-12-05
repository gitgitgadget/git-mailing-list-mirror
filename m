Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AED1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 05:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbcLEFPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 00:15:17 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34972 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbcLEFPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 00:15:16 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so7024649pfk.2
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 21:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYb62rFf54vk51r24zM3OVeNtfgiXVsnGAxK+aH7Q5E=;
        b=oe8isDWtQEB2leLRY8+D2bg8qkV9BbbEpHxmxDsiwVVeRRKwcIAqX1A2vhgK9mz4vP
         6JPEjQmh6T7N5k8S2d/LYdi7nQuECuaPvYBMEV/42MEu07Q0Su8cpMDnBspWlFJCz0JK
         dNXRDjA/gm9LFPXTLEzjFDh41I0xuROZP2+fVWv54olOgir19W7sF7ruP4gielWv26Ns
         pAzMES9c+LZMiouhLp+4CpdRUGjtnhe5kOtrkjQ2VHmp+2YJZR+9X6/1Byl9zwVreQEx
         K47/y8F8KDvoe/bth94/0SVuoF3ttkfZPqI5AODZXL2m7vsHx4Uan9uNtlGKRUo/qZuC
         ZBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYb62rFf54vk51r24zM3OVeNtfgiXVsnGAxK+aH7Q5E=;
        b=Ik/hITldjq+hsviHWtOAeJzisNypahisjsVwAaAmA25fXyblxjAZ3W62fwkxJYXp40
         t6M2yGeoNbREl85W6Bzd5zhK8s7mpPizlwPHyooT6v0hKWvF883K6wTwuu258ycT+nNM
         XAjVL3MfqrNa+vbpKznCqPw9tsQURDO3fkjXLgimsP8BcifeVxFr6MATuFfn/iyf8bik
         n27YyADUSZHzFGvQ5LcmS0iw7GzANXZ1Kq60OuniNvHuSiHnWg5IX6DuKa2Wfs158fS5
         F8H4WJAxhqvyGGWuyoWL2Fx8s4ML8QeQsO/kQjxxpaDMUnNk2V0USTKWkBQfjE4acbfO
         AA/g==
X-Gm-Message-State: AKaTC03PLeJYALHGsSNqcKaComYC2rZEzVK1UpLAiHfMXM0GS12yB7Y7mCBj1WdgiRL3+w==
X-Received: by 10.99.108.8 with SMTP id h8mr97823614pgc.93.1480914915983;
        Sun, 04 Dec 2016 21:15:15 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id v82sm23645050pfi.6.2016.12.04.21.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Dec 2016 21:15:14 -0800 (PST)
Date:   Sun, 4 Dec 2016 21:15:10 -0800
From:   David Aguilar <davvid@gmail.com>
To:     "P. Duijst" <p.duijst@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Error after calling git difftool -d with
Message-ID: <20161205051510.itftw4hyzkv6nnxn@gmail.com>
References: <5f630c90-cf54-3a23-c9a9-af035d4514e0@gmail.com>
 <alpine.DEB.2.20.1612021704170.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612021704170.117539@virtualbox>
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 05:05:06PM +0100, Johannes Schindelin wrote:
> Hi Peter,
> 
> On Fri, 2 Dec 2016, P. Duijst wrote:
> 
> > Incase filenames are used with a quote ' or a bracket [  (and maybe some more
> > characters), git "diff" and "difftool -y" works fine, but git *difftool **-d*
> > gives the next error message:
> > 
> >    peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> >    $ git diff
> >    diff --git a/Test ''inch.txt b/Test ''inch.txt
> >    index dbff793..41f3257 100644
> >    --- a/Test ''inch.txt
> >    +++ b/Test ''inch.txt
> >    @@ -1 +1,3 @@
> >    +
> >    +ddd
> >      Test error in simple repository
> >    warning: LF will be replaced by CRLF in Test ''inch.txt.
> >    The file will have its original line endings in your working directory.
> > 
> >    peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> >    *$ git difftool -d*
> >    *fatal: Cannot open '/d/Dev/test//Test ''inch.txt': No such file or
> >    directory*
> >    *hash-object /d/Dev/test//Test ''inch.txt: command returned error: 128*
> > 
> >    peter@scm_ws_10 MINGW64 /d/Dev/test (master)
> >    $
> > 
> > 
> > This issue is inside V2.10.x and V2.11.0.
> > V2.9.0 is working correctly...
> 
> You say v2.11.0, but did you also try the new, experimental builtin
> difftool? You can test without reinstalling:
> 
> 	git -c difftool.useBuiltin=true difftool -d ...

FWIW, I verified that this problem does not manifest itself on
Linux, using the current scripted difftool.

Peter, what actual diff tool are you using?

Since these filenames work fine with "difftool -d" on Linux, it
suggests that this is either a tool-specific issue, or an issue
related to unix-to-windows path translation.
-- 
David
