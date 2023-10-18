Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F8F9C4
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOneW4i6"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272398
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:19:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so5573043f8f.2
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697653192; x=1698257992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUXAqKsRWNJ9ype1pHJW4RQrep8LfWya8e8P33GYcBE=;
        b=NOneW4i61z2u1UuPqoEDW1AgfBbnY0I1/AokELafKNHK3WGBNylFKwsVWJsfvumqnh
         DQZP9O8jqFiX3xfgjSqXxILuFD4aPWo3+5d30Y4Vd1iGRMQ0hgtsviHNza+IaS5mrqA6
         lEw42uBh2y5n32hx5SBNeuM8Dtc96GsYE3n8OJaIvGl/JTLyrEXV9FQtjZx4qfq+06J4
         JZzwHd4XrmIjvhkPLfL/B9FMZABiU9WRl7YO+oxt9DRbw3vY+FCGxreBaYIJA7oqw9lS
         E+c5LzLd2Rke/woYXeXfYNgHeVUTQgu3D55YVt46zl2KEKmaz1gwTGKi21rSNTnx9EL1
         v9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653192; x=1698257992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUXAqKsRWNJ9ype1pHJW4RQrep8LfWya8e8P33GYcBE=;
        b=s51eCkHOcK7wUY3KR4sInr2NIBAa1JADMcq9WStmt1h4YWHMHLlxlUwI81gXWeQS2e
         VOo09uO5tjke5mWNTNNmjGhNbDSI4BTQmEZHz5YGVUfxwh633QFTNm2/oyMGz37EZtrO
         yuFcJ9gNyTWsV4/UT2SGhEgNNoUWpliswq+eUdq763q0uhHQ1PCOBHRLE/VTN5GtAMwO
         snOABAGnPlMNV2uLE+Gr3yXHnu4uiTPnQxwiRFpZ3Zr3zA/uvj5L+HsyeHDQqR2LE+A1
         iCsJ3TXe5oM/zItLo/bxjMLb1JPi9fsbXdmQ+S6O9jnYLarZpRwBuT0b2NLawmC5lvNS
         AgCA==
X-Gm-Message-State: AOJu0YzjH38A/uL72msQq295YF9hsv3is+xBhNE0m8ZE6SFINEOa7UUA
	8lI55dPRtUn8coHwuB3EOqk=
X-Google-Smtp-Source: AGHT+IEN8sU/iK8AAw0utudFGWbLmaiarj+xOR/7sqVVFmk+u7qw/wUlcEu64lDEcCbw2/I+pLRpEw==
X-Received: by 2002:a5d:4c45:0:b0:32d:a221:446 with SMTP id n5-20020a5d4c45000000b0032da2210446mr4557204wrt.59.1697653191946;
        Wed, 18 Oct 2023 11:19:51 -0700 (PDT)
Received: from [192.168.2.52] (141.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.141])
        by smtp.gmail.com with ESMTPSA id j1-20020adfea41000000b0032dcb08bf94sm2655106wrn.60.2023.10.18.11.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:19:51 -0700 (PDT)
Message-ID: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
Date: Wed, 18 Oct 2023 20:19:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH] branch.c: adjust error messages to coding
 guidelines
Content-Language: en-US
To: Isoken June Ibizugbe <isokenjune@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, Junio C Hamano <gitster@pobox.com>
References: <20231018051223.13955-1-isokenjune@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20231018051223.13955-1-isokenjune@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18-oct-2023 06:12:22, Isoken June Ibizugbe wrote:

> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---
>  builtin/branch.c | 66 ++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Only builtin/branch.c is touched.

The changes in this patch break some tests, therefore this patch must
also include the fixes for those tests.

> @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		const char *start_name = argc == 2 ? argv[1] : head;
>  
>  		if (filter.kind != FILTER_REFS_BRANCHES)
> -			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
> +			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
>  				  "Did you mean to use: -a|-r --list <pattern>?"));

OK.  The initial 'T' is fixed, but as Junio explained [1], the full stop
must stay.


Thanks.

 [1] https://lore.kernel.org/git/xmqqttqxkmaq.fsf@gitster.g/
