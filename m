Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45720F5
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmCNCDz8"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB9B8
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 03:13:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079f9675c6so5349073e87.2
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698574380; x=1699179180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6AsjNqg8Zyc6VM4OyMRzq9QOZiZfmtIupx044yG0I/4=;
        b=AmCNCDz8TT3NnHHUdROPsOkG1IeQN7MKzCl9Amxw1Dk2MgR6LpzBd1QEcsdZktMSd6
         K265gg1c1vAMRNwfLa4vVNMxGgRkkGEunLmCTUVHXQ9suztUMGvuitAdxNqI85p+elY2
         ouB8C0BkzHUQl2m4lUOLvxJZashVkfJR1jGmnOMwS+nHOwC4qrxo/RKmE3Z8NJXO+kUX
         gWczISLnBj0Ces4s9jP6VeSr5/yANtrTt+YKMQ4NuDgn8LmAO2D6nQFySrCYCeYzaDt/
         dR0bXGMkC0tWVScwPKOmA6hvVJAK6DYb2dOnbOk4nLOkZdi1QxL06oEt+jsfcVnEvLJe
         hoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698574380; x=1699179180;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AsjNqg8Zyc6VM4OyMRzq9QOZiZfmtIupx044yG0I/4=;
        b=lbaoIEbafGioVQ9K85M8FZe1i0fomnsr63NkzmQ96NC3b5KonoDO4NqswGqZuiUyhF
         TJd22OB5K0G7JqxVjnLVzimZ0VcNObkt7nZ3GTii8Xy2c5HFuGCZ8PiDCFjuWZf6sA1n
         7aFmf+INNcWeIYjjGd5K+2HQOgFY//ImpA3L/FX/bh0r/5gviSJuzAtqou23EuS8OG+d
         R/ucqB7crWGEN4iIiNnewsA//i/P+B8k4dWaBlEMHzguiDKTMpwsYuuLKa9ttngOZzpD
         hTvkjOICf0TV9D8NuF/22Dh2T6LbF80LcQAtZihUVzUhB9FFMuPnlaE5YDIUcQmjCILv
         Ixkw==
X-Gm-Message-State: AOJu0YwB+0H6/YXULCoRB9C05xQpezCKSURpYIoqMd5qlbj9xK1wMRpb
	xz727RKnVMaV/LEgd+ADbFM=
X-Google-Smtp-Source: AGHT+IHZd8oLZ3qJFbqnixq2L7eQOkMdxp0ArrI5VcJB8yC0CwCTnut+xCWPrKFL6ivRjPUUHVE3EQ==
X-Received: by 2002:ac2:5448:0:b0:507:a1e5:74fe with SMTP id d8-20020ac25448000000b00507a1e574femr5006303lfn.54.1698574380239;
        Sun, 29 Oct 2023 03:13:00 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id bs27-20020a056000071b00b0032daf848f68sm2037071wrb.59.2023.10.29.03.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 03:12:59 -0700 (PDT)
Message-ID: <fec21bbe-46da-4f1c-a9b8-6be44403d68f@gmail.com>
Date: Sun, 29 Oct 2023 10:12:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
Content-Language: en-US
To: Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231024195655.2413191-2-sandals@crustytoothpaste.net>
 <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
In-Reply-To: <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

I agree with everything Elijah said, I just have one more comment

>> @@ -80,12 +88,21 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>>
>>                  fname = prefix_filename(prefix, argv[i]);
>>
>> -               if (read_mmfile(mmf, fname))
>> +               if (object_id) {
>> +                       if (repo_get_oid(the_repository, argv[i], &oid))
>> +                               ret = -1;

It would be nice to print an error message here

	ret = error("object '%s' does not exist", argv[i]);

none of the existing error messages are marked for translation so I've 
left this untranslated as well.

Best Wishes

Phillip
