Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D6182A4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xoMXmw8c"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85ECF3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:09:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7789577b53fso393037485a.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698779342; x=1699384142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6c5RnsBQAM1dunV+CAJDbpk8REPk1TQLabnCRBaN3S4=;
        b=xoMXmw8c92SsVPBfPYuN1MgXEdjAW57Np/+2c7qOsSKfUgE/24WuhtgeCpPoGjiO7A
         wvs6nClFF5ELlmVkG3vRPS3RQ9f4u/YqISUntuB/G7NngLbY/DGNicKvK8N9Ip5d47QZ
         qm5GcOoud9SUSXxckfcZH6DxkfG7aL8ibx4PLtOkqJZcMkxibhQU+iNu3lZBR1ezlivd
         NwjJB/ZVb4O8YB+zWOUHJuaWx3lJvGJSUekVNmf42abKU0Hgm84mxynsx29fPB+xfbVO
         nPEhjRzOK/aHDDzVwyi0q7uSnCD+ttMPxK/2tjevgPEGdqObgAHKTmnDyEf2cx6DTDRA
         XH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779342; x=1699384142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c5RnsBQAM1dunV+CAJDbpk8REPk1TQLabnCRBaN3S4=;
        b=PV8w14JCG9OIzkixHbEQmSL4c4v+0MFEDNuE5N8CNA8PmdLQxCYyH4YEe0UQ0ONBaD
         8MZjkM0sLIlSMrqGF/s+tMMKJ/XzXXkV6EykDttHOTQrj6OM9lMsEw7XCt5Vnr6rwXzz
         P8/361nB+QuzzQKu8cwulquL1pDDhJzgepCJV3h7/kE6GQ1YP4ysNv222mONF2vmvH5R
         /8LsIicAQTi1OR9AdAXQnRB+rp6IfIpjOEplmUy65uSacJ1YJxg0dS+dzPcET6OplfMC
         LMlmWJdkwzePekyQyP9p0G0S5IiBQiPNR9MRyISdZqghAmH/nvLtTtB8MGaGmL3PKKlL
         2UEA==
X-Gm-Message-State: AOJu0YxbhuuLwQrtpKlzG9lCHYbHRCgFzwHPeksV/EaRjV4K6AVkhnzB
	jfroXoMDUeCaJhf0xUugKXSEtA==
X-Google-Smtp-Source: AGHT+IGpEKD/1FcEAp+603I158t7v6z4rkaemT3LD/yFl1xHTCtV9mCXd82UrPul0LHIBRFN30XGLA==
X-Received: by 2002:a05:620a:4088:b0:775:7703:ace5 with SMTP id f8-20020a05620a408800b007757703ace5mr16488159qko.56.1698779341774;
        Tue, 31 Oct 2023 12:09:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a166900b0077890c8896bsm743887qko.134.2023.10.31.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:09:01 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:09:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aditya Neelamraju via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Aditya Neelamraju <adityanv97@gmail.com>
Subject: Re: [PATCH] chore: fix typo in .clang-format comment
Message-ID: <ZUFQzFcgGdJsPJ8G@nand.local>
References: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
 <ZT/gQZlVKfgn/+BZ@nand.local>
 <xmqqpm0v5vtg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm0v5vtg.fsf@gitster.g>

On Tue, Oct 31, 2023 at 12:12:43PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Sun, Oct 29, 2023 at 08:23:07PM +0000, Aditya Neelamraju via GitGitGadget wrote:
> >> From: Aditya Neelamraju <adityanv97@gmail.com>
> >
> > We typically prefix commit messages with the subject area they're
> > working in, not with "chore", or "feat" like some Git workflows
> > recommend.
> > ...
> > That said, the contents of this patch look obviously correct to me.
> > Thanks for noticing and fixing!
>
> As a comment for a new contributor, it is a bit unhelpful not to
> suggest what the "subject area" string we would use if we were
> working on this patch, I think.

Good suggestion. I would have suggested "clang-format", which is
exactly Aditya ended up choosing, anyway. Thanks, Aditya!

> I also suspected that valuve may be a valid word in some language,
> as the indentation in the example looked as if the six-letter word
> was meant, not typoed.  https://www.gasolineravaluve.com/ was one
> of the first hits I saw in my search ;-)

;-)

Thanks,
Taylor
