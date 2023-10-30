Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C018C15
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At4nsOVM"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E7DD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:09:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32f78dcf036so1356041f8f.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698682173; x=1699286973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fUim6QMxfnMGLdndmXJocwjKIAafhUavfbjjLwmEwDk=;
        b=At4nsOVMQBXJoNCTMXbUj1XzEwKOtR54S0SkfEzqkt/7It1tZi4OpWrDvs6FR+xrjh
         9It6EkqhcIYq32VLqOWl3+wkipFWXzElrLCsxcvkBF9asoLrOFtdSdl783oyTfB6kcII
         vdiGkxnPqX6daNX/XSNhUWQIQyJtovMayiMKq2p+BdQ38dhzXomcfvO67wu2vWfFOKgn
         t3yjBWEAKmQ9a5+fpmPs2zhK/JcZcwmmIQX5HEn8jV0QTdfoqzu3ej0sbmMsq9kPEs2w
         b9qpbylw3foTS5w2hPmn9HSz+lbOBbsC/S+kYXx1AVddVGlvjqs28VMPy7q05w8O1sWl
         CZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682173; x=1699286973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUim6QMxfnMGLdndmXJocwjKIAafhUavfbjjLwmEwDk=;
        b=jYgC8jQWV6qZ1waN7RGNqfaZawv83vT7nUm6FSexPWAXN9beQ9D9MoHOy5A2BYiJDH
         010zE+0j4RHAI2JGI8ZN4ARxxP6Vj4xLg8WzuB9MCwuEcsJdQt+HoDNteCcOYt8Tzxqn
         Fi2Xaa9awfEMVdDoNjzFxG4+npr4YsRZZds6qAqc9uzpxQ937CvsPa8z5JXjvIJsMWMH
         lReWsuuUnBJQH/P94e6ZyIjP5vTQwBjzUNh4Co1gtjtfOXboV4kIWHgIYY5NFdKmopKh
         R0tDPltGTCGxh44/2xcBC6qvRkjCo8Oug3XbwaRl09FgSLS8L8ZJo16KdzGJakXO/zry
         EmgA==
X-Gm-Message-State: AOJu0YwWPL/7mzsTc3nNI2Sl4NMWhjBCwZUiAnS6iintnqENEMxmEKCn
	dNX0VyLFlfsxkY+9vaZkfBI=
X-Google-Smtp-Source: AGHT+IHRDl4DWxZeq5DoOgywvHUCcfEtpZiHI8GHOCe7+UoaxCDbPy80tfn9BKqwmSuJ+vzvvMWy/Q==
X-Received: by 2002:a05:6000:2ab:b0:32f:8bbb:fc00 with SMTP id l11-20020a05600002ab00b0032f8bbbfc00mr92036wry.12.1698682172697;
        Mon, 30 Oct 2023 09:09:32 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0032f7eaa6e43sm5509184wrz.79.2023.10.30.09.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 09:09:32 -0700 (PDT)
Message-ID: <ba7a7a8c-bb0c-4f12-a7fa-d05b1c246d5f@gmail.com>
Date: Mon, 30 Oct 2023 16:09:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/8] ci: install test dependencies for linux-musl
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698667545.git.ps@pks.im>
 <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>
 <ZT-l4qDDNloizjxl@tanuki> <d675b51b-c50b-43e4-b127-650c0e24d3d0@gmail.com>
 <ZT_KWjxkPEIXHEeH@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZT_KWjxkPEIXHEeH@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2023 15:23, Patrick Steinhardt wrote:
> On Mon, Oct 30, 2023 at 03:13:35PM +0000, Phillip Wood wrote:
>> Hi Patrick
>>
>> On 30/10/2023 12:47, Patrick Steinhardt wrote:
>>> On Mon, Oct 30, 2023 at 01:15:10PM +0100, Patrick Steinhardt wrote:
>>> But once fixed, tests do indeed start to fail:
>>>
>>> t5540-http-push-webdav.sh                        (Wstat: 256 (exited 1) Tests: 20 Failed: 11)
>>>     Failed tests:  5-11, 13, 15-16, 18
>>>     Non-zero exit status: 1
>>>
>>> Seems like another thing to fix in a separate patch series.
>>
>> Yes, or we could just leave it - I had not realized before that it was only
>> the musl job that was not running the httpd tests (I thought
>> install-docker-dependencies.sh was missing the packages for ubuntu as well).
>> Given that, the status quo does not seem so bad.
> 
> I of course couldn't let go. The following would fix this:

Great, that was fast! As you've got a fix I agree it makes sense to 
include it in this series.

Best Wishes

Phillip

> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
> index 5e28adf55b6..48cb2e735b5 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -21,7 +21,8 @@ linux32)
>   linux-musl)
>          apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
>                  pcre2-dev python3 musl-libintl perl-utils ncurses \
> -               apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
> +               apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
> +               bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
>          ;;
>   linux-*)
>          apt update -q &&
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 9791f94b16f..9ea74927c40 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -128,6 +128,20 @@ else
>                  "Could not identify web server at '$LIB_HTTPD_PATH'"
>   fi
> 
> +if test -n "$LIB_HTTPD_DAV" && test -f /etc/os-release
> +then
> +       case "$(grep "^ID=" /etc/os-release | cut -d= -f2-)" in
> +       alpine)
> +               # The WebDAV module in Alpine Linux is broken at least up to
> +               # Alpine v3.16 as the default DBM driver is missing.
> +               #
> +               # https://gitlab.alpinelinux.org/alpine/aports/-/issues/13112
> +               test_skip_or_die GIT_TEST_HTTPD \
> +                       "Apache WebDAV module does not have default DBM backend driver"
> +               ;;
> +       esac
> +fi
> +
>   install_script () {
>          write_script "$HTTPD_ROOT_PATH/$1" <"$TEST_PATH/$1"
>   }
> 
> I might as well roll it into this patch series now. It increases test
> coverage on musl libc and doesn't have any significant downsides. In
> fact, it uncovers that tests on Alpine Linux don't work right now, so it
> fixes real issues to have the test coverage in our pipelines.
> 
> Patrick
