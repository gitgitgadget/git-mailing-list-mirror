Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D58B1F78F
	for <e@80x24.org>; Mon,  1 May 2017 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764357AbdEAQVj (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 12:21:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33738 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764241AbdEAQVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 12:21:35 -0400
Received: by mail-pf0-f169.google.com with SMTP id q20so22804857pfg.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m+TqKQnhGjee0/jKlyIfE0akt0eiE8t66ZiZOqTM+NI=;
        b=jxbSXaAKYwDMc2EGGyDF2DGV2puhss/a/yKSmbm9r4FIUZgl0/IKB1QNQPmx1s/hxE
         GKOOUcd/l808cIpVu23Z48Ck6voUvaLbNPTemQGKTVTywZY/cAbrhn60Gd2VHuzXeqbK
         Vxc7JM5kumwuqTgGfS9uOgbiy8ZZa18fR1IxYi2wlhAzspualVe+ngYcb20ah5zM/d6V
         tqHjz4SShvrM0Yalcezn1v2jrsrstPWaScm/bqocn4AdZUpGmiz22LZ4DCF7NbBYPLPr
         YUUhBFo3gckhdsFBD1IPxf7RYtTHY8LIHN5khKjym+5wkk0YxtbeAqXUYhofU+leqH4w
         WE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m+TqKQnhGjee0/jKlyIfE0akt0eiE8t66ZiZOqTM+NI=;
        b=Pm1FFqrMkxHw+Eg0qDk8/k+9VL9lnGqIXt0+r+Pyy/zASLheT8OLOGBeYgempkI0hq
         M/UR81jSdlsggPIhFk/B7lUvHfSgn7F4K4Slv4oQAw780L3BqGhdylBv4+20oRU1YLlI
         om+CZ5ABwvMpOhGKaISSj8skfwssN+1CvNP+5ZgrR16eFRGFzgiRWinX5LfoRoHFPmi3
         5DsK/4VaHJDhnLcpQB0jZTzFwYH8GwdwiN0EsHMYFhUDilwI4+HjngYQ45WQxktZqKTV
         utvuxGPCHsWOtKcKQYNBpAXH82b0+L3EVU8xUYnDBFUaD9Su3W8kVVmFT5yOc+eKRbQS
         Z5+Q==
X-Gm-Message-State: AN3rC/4k/E8DrGeI0pYYbJ3XGWQpgUBYfyJhszIWC4GkRJil2dkYQqSH
        ov+dUJ/9oZnj95lS
X-Received: by 10.99.109.141 with SMTP id i135mr12572927pgc.33.1493655694224;
        Mon, 01 May 2017 09:21:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id p16sm30681873pgc.4.2017.05.01.09.21.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 09:21:33 -0700 (PDT)
Date:   Mon, 1 May 2017 09:21:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
Message-ID: <20170501162132.GA39135@google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 1, 2017 at 7:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > * ab/clone-no-tags (2017-05-01) 3 commits
> >   (merged to 'next' on 2017-04-30 at 601649896a)
> >  + tests: rename a test having to do with shallow submodules
> >  + clone: add a --no-tags option to clone without tags
> >  + tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
> >
> >  "git clone" learned the "--no-tags" option not to fetch all tags
> >  initially, and also set up the tagopt not to follow any tags in
> >  subsequent fetches.
> >
> >  Will cook in 'next'.
> 
> Thanks for trimming off the top 2 patches. I've dropped those myself,
> if someone (Brandon || Stefan) more interested in working on
> submodules wants to pick them up that would be neat, but I don't need
> it myself & doing it differently than the existing submodule options
> would take too much of my time.

Yeah we can add it to our backlog, though I'm not sure how quickly we'll
be able to get to it.  If you end up needing this sooner just let me
know.

-- 
Brandon Williams
