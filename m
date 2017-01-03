Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CEF2092F
	for <e@80x24.org>; Tue,  3 Jan 2017 18:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760722AbdACSyK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:54:10 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36481 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760598AbdACSyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:54:05 -0500
Received: by mail-pg0-f45.google.com with SMTP id f188so217424399pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=22mWJn1uMjuNydCFQlUapcpPxRItg43jFHM9KZRKd5o=;
        b=cy3CTscJcHHnnk8ISscQoCgZfj8PhEfap3akw9HQWnr8zfuyQbSLlpvBvTk3KWe+19
         O369YUJ0fSNl0CFZslAIK8mzeo6OqyKYpwJI9w6cQDbhH9ydaJ4ZziD+bZlN/iDoLzHy
         f4f6IE2LDKTwEi8mqHIzFyCbu4LXKxitpoXNd63xCz/B9EMOnDv5Kmq52mj5JV95nhG9
         5GbkggUhm2tAV51r3arjs5QZJ92WJU7oEOl2R1Gsz6/eagAXW8JCRD+fHaYAY02DDq0n
         9jBnqWR+bxf1cltDE1SRRmbKEanhiRSYDmYlTPEotbxBBA43xmps268KVADkmO+I4PYB
         7Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=22mWJn1uMjuNydCFQlUapcpPxRItg43jFHM9KZRKd5o=;
        b=B/XG+jirVQ7SDqOQUUip+sTwSGUc5qIRisWGVxFhMK4u9mmSnua2E5Eq7+pQ2FOfC4
         JJcQe9xwrztngvkjZcoROsjbyghu3Q24TmjCG8kLYT+9B+Rz7t+G/qZPe+vSoZUwdV5G
         4YU+oVq+RXkECegS+jZs4jBRXJLdKJgDRqEZMnbA+JdAgyGOvl6F5+J/H1eipTrEklWv
         i/TeN/jCBKKT3pezCe/0BPKfwxsKOml8Blj/2hySAqFXat1HKsnwiIKO6wA2qEyjabdN
         2vQ8eT3xeWMH6OCSzzV7rp+yk0bG3e7RRoZ+pd9C9f8npHmIVas7ZkSCkO4dZc4NdVEz
         sCtQ==
X-Gm-Message-State: AIkVDXIErW145XKE4LMVpp94WWvFlimSZ/FtEfJtYiT5tt4GHHHG5Hr9aF74aW5eRTH8k6il
X-Received: by 10.84.232.206 with SMTP id x14mr107038060plm.130.1483469644915;
        Tue, 03 Jan 2017 10:54:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c019:d4:4575:9b1b])
        by smtp.gmail.com with ESMTPSA id n24sm141701111pfb.0.2017.01.03.10.54.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:54:03 -0800 (PST)
Date:   Tue, 3 Jan 2017 10:54:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2016, #08; Tue, 27)
Message-ID: <20170103185402.GC42671@google.com>
References: <xmqqy3z155o1.fsf@gitster.mtv.corp.google.com>
 <9E13F972-F374-4126-A599-A8A7618D4AF3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9E13F972-F374-4126-A599-A8A7618D4AF3@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29, Lars Schneider wrote:
> 
> > On 28 Dec 2016, at 00:11, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > 
> > * bw/realpath-wo-chdir (2016-12-22) 5 commits
> >  (merged to 'next' on 2016-12-22 at fea8fa870f)
> > + real_path: canonicalize directory separators in root parts
> > + real_path: have callers use real_pathdup and strbuf_realpath
> > + real_path: create real_pathdup
> > + real_path: convert real_path_internal to strbuf_realpath
> > + real_path: resolve symlinks by hand
> > (this branch is used by bw/grep-recurse-submodules.)
> > 
> > The implementation of "real_path()" was to go there with chdir(2)
> > and call getcwd(3), but this obviously wouldn't be usable in a
> > threaded environment.  Rewrite it to manually resolve relative
> > paths including symbolic links in path components.
> 
> "real_path: resolve symlinks by hand" (05b458c) introduces
> "MAXSYMLINKS" which is already defined on macOS in
> 
> /usr/include/sys/param.h:197:9:
> 
>  * .., MAXSYMLINKS defines the
>  * maximum number of symbolic links that may be expanded in a path name.
>  * It should be set high enough to allow all legitimate uses, but halt
>  * infinite loops reasonably quickly.
>  */
> 
> 
> Log with JS: https://travis-ci.org/git/git/jobs/187092215
> Log without JS: https://s3.amazonaws.com/archive.travis-ci.org/jobs/187092215/log.txt
> 
> - Lars
> 

Simple fix would be to just revert MAXSYMLINKS to be MAXDEPTH (which is
what the #define was before this series).  I'll resend the series with
that fix.

-- 
Brandon Williams
