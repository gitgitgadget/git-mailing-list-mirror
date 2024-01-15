Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048418E1F
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAg3k1NO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so7991207f8f.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705346698; x=1705951498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnGNs5e8y/PQg4jturUYZxgzwdYYqfYxeYJhneVsmdQ=;
        b=HAg3k1NORY+dCr22VyGI6g9nbBMJZS6jRpqCDYSs9nEAcUBMX0b+eNPHdq42bCpIau
         ulR+busTu4Rb1px+8dOjSXP3nFGy799K3CYyg1nF1D/ieuLmbuoi+ZmYFWBmRtSm8vQB
         JFvj7yj0qj5eRgcLhgaEKLEcqrvshkO4a/5XOxm2fnMi5gB417Gpxk9I5VCu4uZbXSb0
         sCRsHbNocvr7EZc2dSaETRDlC3+F/mYdY0JFVMe/i2by0cBGRSfjDbA3SlC5n4n3rgYK
         7obgwE0oVAEByHtsiUn3cSHqT7iRw2YQw/GBjDtXzkqbSamNLqD9A7BMQ07m6OkJUbpk
         yqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705346698; x=1705951498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnGNs5e8y/PQg4jturUYZxgzwdYYqfYxeYJhneVsmdQ=;
        b=ZGDH5/CglUUeTTtTseSpiOIz5zz1BIs07Lq8Wp8YtJ3vJcq3jDd4c9TaGhA5svNcFm
         rsJDnhRgcglpVaRy/7hyvuwUuIo6be/yWdhT1evmBXfA8RGfZQiPY4x4rOjkbp+NBH45
         H/SCFP31Dx0nClATRkAeeTSn+4CzJWdV7wv2fDZxs/ikOBtwgJAthLpAzW60cKxTelh5
         itYrQg9R6Ha+3V8ZQ2sVj6lF+xyodMMQciKD5u1FuAgoKINM4eJRHy+WVocAuOxHttBC
         IOfYb528geDU4c3pMeTAf1EhnQbZU80gVtMUgUx2+XAes3O+S9nhjRH9er4i7r4YMxNx
         +kfA==
X-Gm-Message-State: AOJu0YzNk38Vf4TrD9EtxjJS84VmDJku9oWjtR+kVqTtObCDyjZGB29V
	wMJ9XEV3cHNUfNKezk+sM3JShM/3Xyw=
X-Google-Smtp-Source: AGHT+IFgSuq3Vw9cBn3czt4DaIkQPPX7L9on7OjcMkBrT7RN8M3/3TtLbSSKhbDwXvAedflnAOb3+Q==
X-Received: by 2002:adf:fc50:0:b0:336:1feb:27f6 with SMTP id e16-20020adffc50000000b003361feb27f6mr2910932wrs.100.1705346698357;
        Mon, 15 Jan 2024 11:24:58 -0800 (PST)
Received: from gmail.com (195.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.195])
        by smtp.gmail.com with ESMTPSA id i16-20020a5d5230000000b00337405c06a6sm12552272wra.48.2024.01.15.11.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 11:24:57 -0800 (PST)
Message-ID: <6b6b455e-26b8-442e-828e-506f9a152407@gmail.com>
Date: Mon, 15 Jan 2024 20:24:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH] Port helper/test-advise.c to
 unit-tests/t-advise.c
To: Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com, Christian Couder <chriscool@tuxfamily.org>
References: <20240112102122.1422-1-ach.lumap@gmail.com>
 <xmqqmsta6uju.fsf@gitster.g> <93468f5c-5f62-4f22-85ce-b60621852430@gmail.com>
 <xmqqy1cq4ide.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqy1cq4ide.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15-ene-2024 09:27:25, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> To test the effect of setting one configuration variable, and ensure
> >> it results in a slightly different advice message output to the
> >> standard error stream, "test-tool advice" needs only a single line
> >> of patch, but if we started with this version, how much work does it
> >> take to run the equivalent test in the other patch if it were to be
> >> rebased on top of this change?  It won't be just the matter of
> >> adding a new TEST(check_advise_if_enabled()) call to cmd_main(),
> >> will it?
> >
> > Maybe something like this will do the trick:
> >
> > diff --git a/t/unit-tests/t-advise.c b/t/unit-tests/t-advise.c
> > index 15df29c955..ac7d2620ef 100644
> > --- a/t/unit-tests/t-advise.c
> > +++ b/t/unit-tests/t-advise.c
> > @@ -6,6 +6,7 @@
> >
> >  static const char expect_advice_msg[] = "hint: This is a piece of advice\n"
> >                                         "hint: Disable this message with \"git config advice.nestedTag false\"\n";
> > +static const char expect_advice_msg_without_disable_hint[] = "hint: This is a piece of advice\n";
> >  static const char advice_msg[] = "This is a piece of advice";
> >  static const char out_file[] = "./output.txt";
> 
> Yup, but ...
> 
> > @@ -44,7 +45,7 @@ int cmd_main(int argc, const char **argv) {
> >
> >         TEST(check_advise_if_enabled(advice_msg, NULL, expect_advice_msg),
> >                 "advice should be printed when config variable is unset");
> > -       TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_msg),
> > +       TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_msg_without_disable_hint),
> >                 "advice should be printed when config variable is set to true");
> >         TEST(check_advise_if_enabled(advice_msg, "false", ""),
> >                 "advice should not be printed when config variable is set to false");
> 
> ... I cannot shake this feeling that the next person who comes to
> this code and stares at advice.c would be very tempted to "refactor"
> the messages, so that there is only one instance of the same string
> in advice.c that is passed to TEST() above.  After all, you can
> change only one place to update the message and avoid triggering
> test failures that way, right?

I see.  Maybe you're expecting something like:

diff --git a/t/unit-tests/t-advise.c b/t/unit-tests/t-advise.c
index 15df29c955..15e293fa82 100644
--- a/t/unit-tests/t-advise.c
+++ b/t/unit-tests/t-advise.c
@@ -4,14 +4,15 @@
 #include "setup.h"
 #include "strbuf.h"
 
-static const char expect_advice_msg[] = "hint: This is a piece of advice\n"
-					"hint: Disable this message with \"git config advice.nestedTag false\"\n";
+static const char expect_advice_msg[] = "hint: This is a piece of advice\n";
+static const char expect_hint_msg[] = "hint: Disable this message with \"git config advice.nestedTag false\"\n";
 static const char advice_msg[] = "This is a piece of advice";
 static const char out_file[] = "./output.txt";
 
 
 static void check_advise_if_enabled(const char *argv, const char *conf_val, const char *expect) {
 	FILE *file;
+	const char *hint;
 	struct strbuf actual = STRBUF_INIT;
 
 	if (conf_val)
@@ -32,7 +33,9 @@ static void check_advise_if_enabled(const char *argv, const char *conf_val, cons
 		return;
 	}
 
-	check_str(actual.buf, expect);
+	check_str_len(actual.buf, expect, strlen(expect));
+	if (!conf_val && skip_prefix(actual.buf, expect, &hint))
+		check_str_len(hint, expect_hint_msg, strlen(expect_hint_msg));
 	strbuf_release(&actual);
 
 	if (!check(remove(out_file) == 0))

This implies a new check_str_len() helper, which I'm not including here
but it's a trivial copy of check_str() but using strncmp().

Maybe we can turn the screw a little more.

I'm still not sure of the value in the changes in this series, though.
