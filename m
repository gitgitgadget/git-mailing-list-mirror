Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255851F597
	for <e@80x24.org>; Thu, 19 Jul 2018 13:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbeGSOLE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 10:11:04 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34753 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbeGSOLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 10:11:04 -0400
Received: by mail-pl0-f47.google.com with SMTP id f6-v6so3667322plo.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TOPHoTOlWBkhp5CPnqV2fVVljjbkJdgYbTiBMQgXH4Q=;
        b=p06l79HUxclwQ4rLHt8v0IpfG6i46sXxaKJLgXyJZwY5GYAoTEowJ57U+aZ0SlZtqA
         Mh4D/chiad5fgrih85dkZ1U1z8UBDvMBvz1XCIIyLc3yNAo8tN0AweshI8hZxp9CvCI2
         T+zgAwrsOqo+IJHsztahtz2P7NaglPXvRcLmgjU295y7sVKs5/wdOpUi1dW4mX3v1MO9
         t/UMRfA3z8mjQ8voYQNuVB4PgpA2ZutNZiHRooUHJxjpb0tdbpk/r44Y7M/LT+WMqbRn
         luxmqa9w2+UR6fza2qEkMLYqMxgVEyO/FvbiYmF3IG6a36AxpwNOARpmvhzUeJVuD6gw
         8SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TOPHoTOlWBkhp5CPnqV2fVVljjbkJdgYbTiBMQgXH4Q=;
        b=uGp2YmJooAX/tAI5hj/vBvLpZB42Fvp+RpAn4WYIr4DbFZc95DmqI7MmjJOG0qI8x6
         3qbm15kyFCTFGvY5lVD1Qih4vNs4XkWIbA9PPwut+QNsDazIUlHdFkBQwIiONOgukIbi
         y+VsXMD1IWNnSdxcGg6EMpaU6IlwmQh7ef/LxGjGjEmZXEf9AeQP5N4FuXv5T39Zae4q
         ASzbYUbcuZTmElad45SO6U6rBu0wMenEgcKte5EfQuW0U39hy5mX0/kMV+0eBKeL3hQd
         geAKcJlTtwtDIcPXLcyeB+uTD9hSg4XE1ltDVfFiULXOUxc+NQJJBahQ5zf3eRx/nH9b
         q8Cg==
X-Gm-Message-State: AOUpUlH2wyAZoJ8tE3xEBhpwud6WgBfCel0XqBtEbHWdeJmHXzGKM3LH
        qrMD3f2wxXIlZpZsDuzocZ202kZFocw=
X-Google-Smtp-Source: AAOMgpfWL2/pzPNCgU9TrU0J1rcpsrMor8h2YkHbUBJmmoLsooum7IshwvnDA1VHFlHWcglmvTtTlg==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr10175475plx.318.1532006872946;
        Thu, 19 Jul 2018 06:27:52 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([183.83.81.223])
        by smtp.gmail.com with ESMTPSA id n12-v6sm15326775pfh.146.2018.07.19.06.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:27:52 -0700 (PDT)
Subject: Re: Use different ssh keys for different github repos (per-url
 sshCommand)
From:   Sitaram Chamarty <sitaramc@gmail.com>
To:     Basin Ilya <basinilya@gmail.com>
Cc:     git@vger.kernel.org
References: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
 <20180719132247.GA16497@sita-lt.atc.tcs.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sitaramc@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBE6mhzsBEACmTM+ti1ERumLFqPze9AWhVbM20VaXUzAl58s8zTOGVMomnla+tQZL9PRU
 3BP78/CMsomOhlIJOsLsSzS2K/A8nF/kZUkQgVPhshydFmMyIbcNpVb+rWKCYmztfjuUR/P4
 6ooaTw3JgiZXKyEhO3OPhRdxRGdcfGCFRjwQ8gEyfMy+o0SULC13CiEmP4psxW+g5OmUzrCt
 F3xn+AcMsINVP9KO3NtkO9CZoD2MkT8rfS6eb1h4758Bw+B9zm5VEWs4OiA+0gdNmj/JjTlg
 p4vqJ2nxJGZsw95Jr252BANL7rdLFHZ7j+OmCnVg/wvxtp7M9xIVlorExRWlxnjTW1EgQSrJ
 ulq1On7BJdmV2VAGSnuumKVg1g0Wpwf+pXMC37ADWTUNX7JrbIHD0UqBYwTgHjwD9Ft3pRai
 JvLxgcJsaNJBR+vfTiXgfqPfJytHFvU3+KsNBRgoyMmeO/jYPmD1/jyaOGD+taJoDZr08AAA
 7AYO6WGMhaqFAcCmwCpT5xMkRK/SmoL+OCH1pzIYLAf82Hd4LkBK5cdaYlmav1EC8AZRfnOm
 yBXTHTayKqXd/DnDPiYkvvkb7cWddPFfRQu8KVpU7f4wrpbJ6CfDC76sIwzbeD8GLxsc57yn
 A7vQhg1LVrA+mm19bbPNpn6ntDdcfxUriHb8kOtc4yyeTqHyMwARAQABzSVTaXRhcmFtIENo
 YW1hcnR5IDxzaXRhcmFtY0BnbWFpbC5jb20+wsGSBBMBAgA8AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBFYK2mR1QoFvQS5YkaRCkIUIgjelBQJaO6EJAhkBAAoJEKRCkIUIgjel
 9RsQAIbo2Sgl+pLbGowXRKr1IU1Lnimwg/jeeY67Y6f3tiucXylK4+NCLxPHwv6DIIK/xXjg
 ctVNU2KOsce9ICgHPHZJZfiJ5/RAosbKt0cVSRb5G+LNU4BK/uRKfiVevwrUf3CZ0S2O5kfb
 zeefwAeAwzlAk+FPYLtSeQD0EJg7KYWEvwYGEBpGLuXdntvJp/mDYcZ02AnJnxCtI1MhJVnI
 NNLEs0PkTaRi8ct54vnaKxOw6kX9tcexHnXIY/2NGkJoTGMT3Sf5h8VqrbK3J8IUNO37Wz85
 lXY7HfVtNtZhS4c6NhCddLpzrCsp7A7D0flB3E6WqIdIKOYawvYMTuxx/r73KuNXedovR0Ub
 RlWAruxTQapmx7esB6d9061Qv9vp4jm8zt1Atq0Fe0J3IHgB3nnjo/K37cU+4ILx8NxOU61J
 4cQtpnFYqzK/zKr3XBy8/DYx2TwpIA94aOO+2DfV7Ze1PA78ApS7qneqafWQJzHhIE7b3og1
 GIKBtED+pviBR708kdbcqXW0+W+XciquWo0k19K3q6W/jpuKxPsMqb4+tyYNUbL33RWAax05
 uC1wP/8vFjogdQ3Gk/rj09qt6QgOcHZ9MOrnbGLxvuUZjvhN2oSlOKFRYOQ3oSmhLahYWxFU
 4u/sRvuPXZ0jaSEd/yIf7O2XOLnxo+hR+aoMvRvozsFNBE6mhzsBEAC3wQQGWLx78QWXOvN9
 oJlwDJ+oqbMwgMlA8p8raELagVgfdD7H9cWSCTThWxlCii7OHTPIGI/qNIa6eAoEtLUjo4BM
 m2IewK9oHlrYd9+H01NKNBKRMAB+xsuPq7whn6g3cUSpc9yOshclHsPcYXg7M6drE3LZicw/
 sEYNvdRdW/IsbFBjtVT/cPx6w4absBQ1AReR/tOJfLAw8G96HiuFbmbXaioyPkr7+qLVGrCx
 f6FXeKWHBFg5uprZJp78NEuoUltcBFK8PE51M7+zDtU6h+SxxVrs11HC2Nn2epnm58uueBYp
 UnEQST5TFg32Zah5Oz2ANfuiuCtdnXGPbg7Fak2AInUruR4gQmftuJssIVmvO7xRNutKwuTs
 1cggvnPXW/GT1oIPNf9XCvtlcVkf8Fw/fCGK1ahd1SmPmkr77jt/7BThTkGFjzoWaOM+E42Y
 flBMAGB2X/MMe3hM2DYbpGFm/TdWgPGeYQjjGCMfB1OT6Tg1lQjXqctm3gpWb/Ip5otHOhex
 6DSTMTyCgIHcSD2s//zG7+o2RGrq4WGdju3rWzdv4F4TjJppnSdN8tU/bo7n/U9VDZrx59ip
 tf3Cw/tiJ37K4oFbkSP2TbkZrtAqqTI/Yw7Yll8fj74KszmbW6kcnJtG1Q1WLuCMKd8KHQq7
 UThs1cve2RKeG0QGCQARAQABwsFfBBgBAgAJBQJOpoc7AhsMAAoJEKRCkIUIgjelU54P/32A
 xO1HWc6nMWXAzqyYh+CtP7iIg65vouI1D9LoGRu25QSB5nlh3kmxn0C3beDmqVFE1DXuDonQ
 EQ7SGv7etPycpioDTaCe4UyD8ECYtu/x6JkWFD2Tnf0xvsPcTRSOHMJG51HgQEYVJc1YvAsZ
 7xLMsrGOUIMN2UPioqoMfyLJpDIcYrwnWx2Q+IX4o2cW6dxDK22/9mhwgCr+xdWCWm4hoCu0
 Qq14ZX0mIvwmw2gsRLy+pqUrPSZFWr5QPvG4nJQdvbqvYTNEaDQrw83sEXmIIhTe0hc5MCnK
 hF8yUsaxFZE/MLC3vIweMmYHDFvXw2v1Naos8+DQw6h/EwoFqwue0DeThldTCkrqsSRfISkU
 yYC6vgpK4OK9PyhKnGwHez3OrJhCktKO8cBSB/Xwpuznh5SS6iLxoUIe6/902GuOTPOCnVpO
 Az0X7MjkTf/3YWGTtM/6NO/W1CD/QaASxhZiaA/DqXj/5GBjB1yD9p1oj69zXfYRkRfbb2Fz
 3zenTaXuUjJUXLtr/9YBUh/IfPsZiQ0oL27l6cNDHJYJWx9wBsBOtVa5dqYA6RIy8R8VNYGS
 b8yxWrUeGKScfHF8SpFqWq4B+5sU8ClNFY368bixhAqPOVzBVNYu5tYSGNar0kVhjAnUJ2Gy
 ZNJ7wKEHInRBmycqkB/ksby8tHy6yfE6
Message-ID: <ff64d8b5-44f0-603e-fd87-5b8db86bd623@gmail.com>
Date:   Thu, 19 Jul 2018 18:57:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719132247.GA16497@sita-lt.atc.tcs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/19/2018 06:52 PM, Sitaram Chamarty wrote:
> On Thu, Jul 19, 2018 at 03:24:54PM +0300, Basin Ilya wrote:
>> Hi.
>>
>> I have two github accounts, one is for my organization and I want git to automatically choose the correct ssh `IdentityFile` based on the clone URL:
>>
>>     git@github.com:other/publicrepo.git
>>        ~/.ssh/id_rsa
>>     git@github.com:theorganization/privaterepo.git
>>        ~/.ssh/id_rsa.theorganization
>>
>> Unfortunately, both URLs have same host name, therefore I can't configure this in the ssh client config. I could create a host alias there, but sometimes somebody else gives me the github URL and I want it to work out of the box.
>>
>> I thought I could add a per-URL `core` section similar to `user` and `http`, but this section is ignored by git (2.18):
>>
>>     [core "git@github.com:theorganization"]
>>         sshCommand = /bin/false
>>         #sshCommand = ssh -i ~/.ssh/id_rsa.theorganization
>>
>> I thought of writing a wrapper script to deduce the key from the arguments:
>>
>>     git@github.com git-upload-pack '/theorganization/privaterepo.git'
>>
>> Is this the only option?
> 
> This is what I do (I don't have two accounts on github, but
> elsewhere; same idea though)

my apologies; I did not read your email fully and went off half-cocked!
Looks like you already tried host aliases and they don't work for you.

Sorry for the noise!
