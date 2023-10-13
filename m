Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05223741
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyrqRsMa"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4C91
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:25:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d3755214dso2275491f8f.0
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697221511; x=1697826311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcyfenvIapks0Sx4n6StdWqX51C1sLlV7XR9pAD0bEU=;
        b=XyrqRsMaIyPLxCh0Jx4tgkXBssaDaS4hBmg4B3wgY7baqwsq//TQNcKP4NPFRHihl4
         97szOzvz30fDuGn69hDVzkOfpnJoeTd+KpJYYtm/DqCswTkNJ/1GLv3/cexGMEW4Nj5E
         tG5HT0YY/cAS9iFoZzZgmjFWXUSurN90xoIwkgQGh2D9T7ODDAyTstNroGI/4G4RM+f8
         N48tlNa833NkwzchmbeVcBmaTYm4hkwOEZuvbKCwCJC7sO0N0oByknhbjXz6wZPGQWQ6
         9rDY6iTZOx6a610Aiw/Ge8CO37nqPSCokqQgl8sX/iSRSHzs/PaKVRp4k0szylf6gXyX
         qRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697221511; x=1697826311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcyfenvIapks0Sx4n6StdWqX51C1sLlV7XR9pAD0bEU=;
        b=ss8wKlGua8ng6zdo1q2D5R4RrUAEw2AsvZIonWfrQ6JkNRiFM5Y4pFE/IFBdmAjxr/
         aSj9diDQiBYZq7mYbssLj0enl+QJY4Oqx20EwcMjynPBYdtLBgvEtC0KgCdKt9E7kxGP
         OCgcqrA1oM4wLAURozgnKnlNLegkSz5Am4cv8r1WauX+84DNbLUeRpoOjOKTx2P8SKoJ
         4VfZo6CbAM//L0o+mWSZiHJpC25h3kUex+U8iiNJZnNfmgYVafFqyLpU+Quv2upEfzxk
         bQb9aBgxSubZNkWcq99G+b77kDeEBtGy4oQGOrbFIOFQVBSOaDHvM9un1BWtZvqQlGvV
         XzvA==
X-Gm-Message-State: AOJu0Yw84JAIM4LLxvZuDUIHFF8J2vs5WHzoOcWOM0RLuNO/r/cyJ8J8
	G30evzwjIICBHe4BJdTSXCfiwp3Cq6M=
X-Google-Smtp-Source: AGHT+IHi9jlQ9UlwzwnPex9Qrz6+eo5ZPNJQdDsFtT4c4Mc4cBGJeku6tRUYq+H219VRPPI/YTv3vw==
X-Received: by 2002:a5d:42c4:0:b0:32d:a0f7:40cc with SMTP id t4-20020a5d42c4000000b0032da0f740ccmr1175595wrr.68.1697221510474;
        Fri, 13 Oct 2023 11:25:10 -0700 (PDT)
Received: from [192.168.2.52] (93.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.93])
        by smtp.gmail.com with ESMTPSA id ce9-20020a5d5e09000000b0032d687fd9d0sm9670076wrb.19.2023.10.13.11.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 11:25:09 -0700 (PDT)
Message-ID: <329f635f-2050-421e-bd0d-943f8ad0de22@gmail.com>
Date: Fri, 13 Oct 2023 20:25:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] branch.c: adjust error messages to coding guidelines
Content-Language: en-US
To: Isoken June Ibizugbe via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>
References: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
 <91e4ad3984147fcc277254a3f6836bf79f5c9550.1697211227.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <91e4ad3984147fcc277254a3f6836bf79f5c9550.1697211227.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13-oct-2023 15:33:47, Isoken June Ibizugbe via GitGitGadget wrote:

>  	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
>  					      logmsg.buf))
> -		die(_("branch renamed to %s, but HEAD is not updated!"), newname);
> +		die(_("branch renamed to %s, but HEAD is not updated"), newname);

Thanks.  This change is not explicitly suggested in the guidelines, but I think
it fits well in the spirit of this series.

> @@ -965,7 +965,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		const char *start_name = argc == 2 ? argv[1] : head;
>  
>  		if (filter.kind != FILTER_REFS_BRANCHES)
> -			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
> +			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"

You have mistakenly deleted this full stop in the previous [1/2] patch.
Therefore, if you stop doing so, you do not need to add it here.
