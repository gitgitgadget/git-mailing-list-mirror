Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4619BCF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UrP729/F"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D8E6
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:59:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778a20df8c3so249564985a.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698080391; x=1698685191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5x3D1eEZnT5GGbskJwm+QvFNH10E4hR6//bvfv2g70=;
        b=UrP729/F81Lrxm5ycJLFXi/r228hwFf/9oIlE7rYmQMgqbS8Be/G9SUB0kQZ3EEz5J
         AQ7yP7Zoi0ttBVtEZl67UE4+MHyoPJDLyd6wbJISL6CGWuiu3zepRURm2MxmzSUhoTmw
         j6dIgqPaC/YATFdii6K2ZkLKNCyyJ9/qfY46WM1FC/Hzu1RDhYRV6g6a+Ff6q6IZt+Pt
         deKdc/XIUOcARh1fyHgdmrL2v51XWJJvmXARQNdRotH/M8zjZF4G9Ac8e105LVoLtBUQ
         rEy0lV80hfCe+Dlxy5Y7ItOI1srKsFY7P6mqDYsEUqa14qR1k9e5Ek4zc4/BRAQQLRgE
         B1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698080391; x=1698685191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5x3D1eEZnT5GGbskJwm+QvFNH10E4hR6//bvfv2g70=;
        b=VW89iV8Oy3S8OEwMD+s4hG/0eRBFdftL4dC6atXZnTFYLMMVtGFeI8rAQT6OtqL3ih
         BatYY3vBkl7aR/yaCvH7e/K46PYcuPOJaVWs59sY8x/mNeEE8rPnIZpTp7ycvS6bM+3m
         Nzkt0Z1bMuVP2BMFDLJB2jDBlp2rM37Ym05xkX5UskB7jCAaV0oD7mlHPRg5b5TqQGWh
         vFh81Vl+kENAx4oZ1p+pFIvcetROiU5poAaF0inN+albtBdPNfhJkjAxPtAID45dy+XJ
         UbwJ4cvVFCZuzR4NvsTHJHngd5sD7zfuTJotd6zPQjFuw2n5XWoaAoUFlwFsIB6IsH5r
         BF/A==
X-Gm-Message-State: AOJu0YwcGd11Z0fRRRTULnCoW7pKNHKlKXubkG1VoQ30skbb5fB0SipJ
	s0EPzpbXFXo3IWpzysokioANXA==
X-Google-Smtp-Source: AGHT+IE/ptaL00AATIIrj9rP3+avjxjyLhspA1aHb4FGgxtcQtKGRiwo9JsIGKb3qXQahakIKRWwgQ==
X-Received: by 2002:a05:620a:240c:b0:779:e171:3356 with SMTP id d12-20020a05620a240c00b00779e1713356mr2237994qkn.53.1698080391251;
        Mon, 23 Oct 2023 09:59:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2812816qko.115.2023.10.23.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:59:51 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:59:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTamhY1sTpp1N6n+@nand.local>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>

On Mon, Oct 23, 2023 at 03:00:16PM +0200, Oswald Buddenhagen wrote:
> ---
>  Documentation/git-rebase.txt | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

The new documentation below looks fine, and I don't have strong
feelings beyond the proposed modifications.

The line wrapping is a little odd: it looks like each sentence begins on
a its own line. Did you mean for there to be a visual separation between
those sentences in the rendered doc? If so, replace the single line feed
with a pair of them.

If not, this looks good to me as-is.

Thanks,
Taylor
