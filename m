Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilZsPZgG"
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A42CA
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 10:43:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so1735492a12.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701715412; x=1702320212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0dJIJLj71DEFFHyaub+HQtg/1clHmLhDn6WRnPM3zg=;
        b=ilZsPZgGRg0zJ7PjVqMvDZWRs6a6OU2ucQtz0jA8fE4bbAdUaud4TLTKtEXcD1KIGR
         pETRxV2rwvzWEGHJBHsMwBPoXyEP7S4QEHVfo58Ax1t/aMVyBtoBBK5kWYRaw78MfwVN
         OxN9OLm5QIHBkUu+7FFDPm8JjG2yitYxzT2cIyryOSh4J4qPS/9G5D6h1uFzMWtINqHy
         AtpnzlIyzFSGzH0kFlVPSad3pz9r+9FjjqJyod1jGZJ3alkQDQCj5sZbQ7NRqwv7Aq3o
         o0XkuwYxyufbLO5gz7pYAHNj0DGvsPsHP4Bqtj5kV/4NBdDNoAdi00ErkWwEYxtzcLwz
         9RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715412; x=1702320212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0dJIJLj71DEFFHyaub+HQtg/1clHmLhDn6WRnPM3zg=;
        b=cqU+XPf1YZWLP7cs6JG5K8yEz0o9iXsNzzBF4ax/rZ8H36iRSq8PBM4guVX5/mZ8Ou
         LdeB07/CQXYLrjojQnW2hmytkO/PlHn4ebb5XO561iDhp/rKzt+yptIcuW+brV20jdaS
         zzecvfOtJh6OsS9B6j4h5sgWpvDVlHR+oxWh69rDoW87KiSsqro/JFtwMgGchOvC37Ae
         2u8OflTqPF4sbYZou/Bsc7nkEsu/amTjRIL9Uey+oTBdUHGEuywqjlwd/3qBgtxbMBr0
         nFRtia1chny0cCoSt83hLboW9fga1Kd1zSdikhNK+Scf92nGAknG1zO/uQUWMXUV8vU1
         Nreg==
X-Gm-Message-State: AOJu0YxcCO94Jr0nYComLu4xKFUaprLIozYx9YS/p4qWoOUl71wZq9M2
	vrLbTpDHzFVUXqv03TlhL1Kmzgg6FOz5bw==
X-Google-Smtp-Source: AGHT+IEXJMnkda1HGjfJsiD1mkFYy4kMbvRBEZJpO4rWnYjc1gRB3r9hs/0/YT9vfXz5Ms54JNS0iQ==
X-Received: by 2002:a05:6a20:8f15:b0:18c:159b:777 with SMTP id b21-20020a056a208f1500b0018c159b0777mr30686272pzk.26.1701715411542;
        Mon, 04 Dec 2023 10:43:31 -0800 (PST)
Received: from five231003 ([2405:201:c006:31fd:3de8:3115:babd:d7d2])
        by smtp.gmail.com with ESMTPSA id it4-20020a056a00458400b006cdd6792faesm7948713pfb.43.2023.12.04.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:43:31 -0800 (PST)
Date: Tue, 5 Dec 2023 00:13:28 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test-lib-functions.sh: fix test_grep fail message
 wording
Message-ID: <ZW4d0M3X4MB6FpON@five231003>
References: <CAPYXD64yCuMta_iGE+ZwgxrJn0U5shcwcB9jaiNkFhvff=R7MQ@mail.gmail.com>
 <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>

On Sun, Dec 03, 2023 at 10:47:59PM +0530, Shreyansh Paliwal wrote:
> From: shreyp135 <shreyanshpaliwalcmsmn@gmail.com>
> 
> In the recent commit
> 2e87fca189 (test framework: further deprecate test_i18ngrep, 2023-10-31),
> the test_i18ngrep() function was deprecated.

s/In the/In a

is gramatically correct, but probably not worth a reroll.

> So if a test employing this function fails,
> the error messages may be confusing due to wording issues.

Isn't the confusion due to test_i18ngrep being displayed in place of
test_grep and not the other way around? Because the formation of the
sentence makes it look like the latter.

> It's important to address these wording changes to ensure smooth transitions
> for developers adapting to the deprecation of test_i18ngrep,
> and to maintain the effectiveness of the testing process.
> 
> Signed-off-by: Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
> ---
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 9c3cf12b26..8737c95e0c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1277,7 +1277,7 @@ test_grep () {
>  	if test $# -lt 2 ||
>  	   { test "x!" = "x$1" && test $# -lt 3 ; }
>  	then
> -		BUG "too few parameters to test_i18ngrep"
> +		BUG "too few parameters to test_grep"
>  	fi
>  
>  	if test "x!" = "x$1"
> -- 
> 2.43.0.1

Rest looks good.

Have a great time at the vacation Junio (and sorry for pinging in the
first place... although this email will indirectly ping too :P).

Thanks
