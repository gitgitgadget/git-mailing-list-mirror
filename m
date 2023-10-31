Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982722306
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="k8kpf9/9"
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EAF4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:09:15 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so3647844b6e.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698779355; x=1699384155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzjWRlou6u6XaA2eGk472VqQWx2QX5RzBmVoSHmvm7Y=;
        b=k8kpf9/93AafmOF4afa+CHMGanIWJzaRaqMvMWV9YkEdm2ksl7E0GBnAwLYkk+E2RY
         Zjtz8/oJwyOwgORqOEc0qkWgoXMPLRTYmeqzyVkC70NyxK8G9CGalGtXY2SnF6ndIXPK
         585/rSfrh36ML0uIQzrU8++Um5GeKmv6e7TmgvD/BpMO2QUMeYfsOmXMnstiYjgr0ysc
         S5h7N2I9K7k6DFMfHd83nwfI/wP3oqGQREsdpjE4wxtO63VLL2BgHVx8magIMIvii7S0
         kjhB8Ec/983+4j9m72Mdx9uK1nhC3ivQljiW4FFXJpZjmJFT8sQrGbEtC54sy6DMhLUy
         sJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779355; x=1699384155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzjWRlou6u6XaA2eGk472VqQWx2QX5RzBmVoSHmvm7Y=;
        b=EJHpoqwsbiEtxMQ2XIzFXwqOd5SVbYq5VHrV8bSmpyjEanYpviKTe5PtC/0DDgPpI+
         acyOU8Koi2peRxazH/UhzcGCutllfwGNZdydyioVyp7jupBuikR6G/cSaley8Q203d4C
         ti75GEIx60NmUWMDES4vMGmFTxeVKtnn2PyRq7JCmu5EPpmFKolnpSQVob9kvwlsZ5Rt
         k4RWdsNECqVIXKnYHvPCzcNq+oegEuCquCSZNvoTiteElFVbWj7m2u1p3SSkBZl68CMF
         gxS13HiS2Gr4VKjNuI9h2I1hNU1kSEflNRpx2To+dRyxy3cweTRml8sD8ACqnXKe/eBD
         MWtA==
X-Gm-Message-State: AOJu0YyrtiXaZZlyd8W6ny8NOkuCpuZaCZgqSIDrBWSYkZxLVFuQfX0L
	K88mqik30bMPuy8k6lOuI+6A1g==
X-Google-Smtp-Source: AGHT+IFm5Fds9VNWAzVX/KO4aJoUy3DKhcnxdEZprtptkjoqOBwcgKOSxAEkRbeixoLq13AYdCWqLg==
X-Received: by 2002:aca:2202:0:b0:3a3:6329:4cb7 with SMTP id b2-20020aca2202000000b003a363294cb7mr14892261oic.9.1698779354892;
        Tue, 31 Oct 2023 12:09:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a148f00b007757f6558b3sm747085qkj.95.2023.10.31.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:09:14 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:09:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Aditya Neelamraju via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Aditya Neelamraju <adityanv97@gmail.com>
Subject: Re: [PATCH v2] clang-format: fix typo in comment
Message-ID: <ZUFQ2bvWu3qX6s/L@nand.local>
References: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
 <pull.1602.v2.git.git.1698759629166.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1602.v2.git.git.1698759629166.gitgitgadget@gmail.com>

On Tue, Oct 31, 2023 at 01:40:28PM +0000, Aditya Neelamraju via GitGitGadget wrote:
> From: Aditya Neelamraju <adityanv97@gmail.com>
>
> Signed-off-by: Aditya Neelamraju <adityanv97@gmail.com>
> ---

Thanks, this version looks great to me.

Thanks,
Taylor
