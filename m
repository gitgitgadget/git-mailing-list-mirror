Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8F31FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 09:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbcLAJ7l (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 04:59:41 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32915 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbcLAJ7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 04:59:40 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so45551470pfd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 01:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MuOpzPBs8VGwFrW33d04bgC6AkB+scyW/1zhnlSY8g=;
        b=T8ueVWF33FI4FSAOWte0Ia5alYmnlenK6T/FvnzI3IQKhdAIOJDrDmikH4p0TX6LFR
         ln1ErqmZbCXbbR3rLqS2lru7ecnBEIV+JhibzhLHuNPTlkjYAsgY7wWTmpyG+o9RllM+
         GE65IHIA68H+j3Uv5mP/wL6znrr8+MgE6b5CA1fxzp+Cx/+DT8f9J7gN9cUBxiArJ3vs
         l/1cnHuPXsXrcrJ7PSr/fWs7jFEUkabykOMvO7lXC82Y2SnkbUWYB1xc7DfaFhAyM9xD
         LesFDfUP6mAw2x7wO1gyDLCbZOvpddrlE32Iik+LV8zIOghK8T4cYSmaDZblbMeU0Rat
         5Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MuOpzPBs8VGwFrW33d04bgC6AkB+scyW/1zhnlSY8g=;
        b=ei7hk7/5dvtoEtD/5iU7e0oNeyRMSvSt1CjLP4f/fEwAMU0wSnQJTzmntEL7+B8f/A
         uNpHThCvsDc3R82iMf3dmaZojLt681k5QOY3BRFV4y9k1Y6EMlpgSCc/TsHMuIPFx5LP
         I5DOrumMRooqbCbcSCriE96VVnJ/Ts0szZ390q436T6H9Drv8FmD2SMZqUXW14Vx7Wrl
         SajAckvcrZIXsR/rRqR/fyLKMELZj5GkKOJFxiV2yUUD05p4450EQ4TnxxrEwRHUu6Ue
         W5EUKxLLGqJ1MhZxWegsUOgSoeJyu8sYyyY71CKYM+h5zSr6FUQ9qcPr366Hke1fz+PM
         IYkA==
X-Gm-Message-State: AKaTC01lzvKWKWTbCCltnN7uvrqFFFSQ90iUKd7ExkLwzRUForWl5YypEUi3Wy81OD4l3A==
X-Received: by 10.84.217.203 with SMTP id d11mr83167676plj.164.1480586379518;
        Thu, 01 Dec 2016 01:59:39 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id s4sm103150672pfb.55.2016.12.01.01.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Dec 2016 01:59:37 -0800 (PST)
Date:   Thu, 1 Dec 2016 01:59:33 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Yojoa <dmoore@vailsys.com>
Cc:     git@vger.kernel.org
Subject: Re: CVSImport - spaces in CVS path
Message-ID: <20161201095933.GA1550@gmail.com>
References: <1480539395581-7657459.post@n2.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480539395581-7657459.post@n2.nabble.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 01:56:35PM -0700, Yojoa wrote:
> I'm in the process of moving an entire collection of cvs modules into git.
> I'm working in Mac Yosemite. Everything is working fine except for one
> thing. A couple of the CVS modules have spaces in the paths. Below is what
> my command line looks like. When the path has spaces I've tried putting it
> in single and double quotes and using escape characters.  None of that
> matters. I always get a message that it can't read dir/dir/path and then
> messages that it can't find the modules "with" or "spaces".  
> 
> git cvsimport -v -d :pserver:MYLOGIN:/usr/local/cvsroot/
> dir/dir/PathWithNoSpaces/dir    
> 
> git cvsimport -v -d :pserver:MYLOGIN:/usr/local/cvsroot/ dir/dir/path with
> spaces/dir

Try cvs-fast-export + cvsconvert.

http://www.catb.org/~esr/cvs-fast-export/

http://www.catb.org/~esr/cvs-fast-export/cvsconvert.html
-- 
David
