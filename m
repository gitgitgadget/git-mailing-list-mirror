Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB80B1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIQVZc (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:25:32 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:36726 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeIQVZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:25:32 -0400
Received: by mail-io1-f46.google.com with SMTP id q5-v6so11894765iop.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4mP9QTCZLblX9OSKHCA9/yuZn7mEd17TbejN8NEs6DA=;
        b=yfm6z+iXnpb+qdBv4XsIN+OMV4lyNEPPPD9+IcQLU0npZoYABgqvHHrlWB/Zx9lmoq
         P+uKHbdWcC4AAHQA2avPnNgRptBveFSVLoT2504GYKkV9IcxFYiE8uaoL3R3uIcQhmzY
         dW153s3i47YwkVtLKJ9Leglhvwi4hZkp5gYQ9rq0fUJEkPGLbXxKjGgIM3exUU/KKp4h
         U68x9qvUuhFRd/WV6h4C3jZRReKJcbVpKuSE8KhjLmmmzsi2xs0DpLzeIBbN7JsIHnWF
         f/RWlYCFaHzHfVs7UaQ0PkMX7bskF6ddvIDE4+h4jbbRouQy1uQ7IMAtl7leEeg/TjOY
         rC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4mP9QTCZLblX9OSKHCA9/yuZn7mEd17TbejN8NEs6DA=;
        b=XKjlnBYjwjPhs5uX4VRUUealaii0XVqcEH/napYeE3v/Xamz1dhqABokFRH1i4Fm7J
         B+cBRpgVUkaW8Lc+1lw0OhEcJ3WITFycfTbocc5ldXZCAYSfrRKlTSHLQvgO3Ebf+pWv
         AC3wBTzp9sVAs+O1bhmIB7xSJK572bdid9n13P8qn8xs0CdymnzHyfBC6nokoXSU4Xpn
         jGzYSwSdCPI/tHd3VxdKGxoadZPJYS0cPAmfLkHe86b8u1YTHP5GV8MTc8vqwAHBnj6U
         cGCHipdcdTzHc7yRYwLNt6hCVBvUnSJvHECr2KuEPn9IcOIfV2GaMLQkbJQ7kfQ3CLZp
         9lZA==
X-Gm-Message-State: APzg51Btc9A+rWPRjjQI3/HdOaWD6TlADjRtZNosrvuaWIka2oee9J4V
        fS2WK3gT6l+eYrZysLUB6Q4+jA==
X-Google-Smtp-Source: ANB0VdZgzXjPBXMkn8zoxhK0wFUr48SqifXtLMr80UQzYjN1adQRNl/vL85ZcD22dcX+hlkbR1yHhA==
X-Received: by 2002:a6b:ab41:: with SMTP id u62-v6mr21588157ioe.104.1537199853759;
        Mon, 17 Sep 2018 08:57:33 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id p130-v6sm3354866itd.22.2018.09.17.08.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 08:57:31 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:57:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        John Austin <john@astrangergravity.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, larsxschneider@gmail.com,
        pastelmobilesuit@github.com, Joey Hess <id@joeyh.name>
Subject: Re: Git for games working group
Message-ID: <20180917155732.GI71477@syl>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
 <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl>
 <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl>
 <874leokw3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874leokw3p.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 05:00:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >   2. Multi-file locks, e.g., "I need to lock file(s) X, Y, and Z
> >      together." This isn't possible in Git LFS today with the existing "git
> >      lfs lock" command (I had to check, but it takes only _one_ filename as
> >      its argument).
> >
> >      Perhaps it would be nice to support something like this someday in
> >      Git LFS, but I think we would have to reimagine how this would look
> >      in your file.lock scheme.
>
> If you can do it for 1 file you can do it for N with a for-loop, no? So
> is this just a genreal UI issue in git-annex where some commands don't
> take lists of filenames (or git pathspecs) to operate on, or a more
> general issue with locking?

I think that it's more general.

I envision a scenario where between iterations of the for-loop, another
client acquires a lock later on in the list. I think that the general
problem here is that there is no transactional way to express "please
give me all N of these locks".

Thanks,
Taylor
