Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0349620248
	for <e@80x24.org>; Wed, 13 Mar 2019 09:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCMJSQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 05:18:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:45861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfCMJSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 05:18:16 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MADqP-1hAtvH2IrR-00BLmr; Wed, 13
 Mar 2019 10:18:10 +0100
Date:   Wed, 13 Mar 2019 10:17:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command
 'restore'
In-Reply-To: <20190308101655.9767-2-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903131014380.41@tvgsbejvaqbjf.bet>
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-2-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-602836542-1552468690=:41"
X-Provags-ID: V03:K1:rf2T00x7H4AZyQQjWDA5ze21CXvpQIfuGfr8G9nbQcvmBPzvFGE
 VavSD/LOXzxnNWy0lGGeMJUbsUmzHrDWngcNlF57r5vmKHHZBuqJYUXxf7UvIkVFm1vjWSl
 fp9AybyYkoGmuxqFhEGGcf8OFIcD/AP2SW3uCjLVfVIWiOK41haW3Vj5Z4y5WWtWBYhwIqv
 aqYf7dubsEb/dyNDk1yrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MyyLJG/6MZ8=:oGzVWDT3t9PSY5Uv0DSZYk
 yrKTV6wRQue8cxtwCOO++9mGz1KNq42Bhx9tUuGg2i/9e6hPhypn/cOZKYoNKq5b74mPljkkF
 RL53WT4SGuzhu9VN+jbnQMKy+8PhqXvRQEVeLnOnnACBE7mX6SDUkJlYNiLAFQ5WXFRVJVcRe
 yg+B8Z0+yTZgaT+0RZ7j+3NbhS6SLgt2F2ktI+9q7BuELW4194pjA2WWVAbK75ce84j2owVGv
 wcjRyfVP5NmVmkLMnMDZWmpddcybQeV0jblUiLtlJcKPd1/uhH6NgHznqJDa+UAVcj3JbfDar
 WxdyrBg93JOjlljXPEecbrXikHIUpbT5ajDF9zQfG7FnJ8r8JEISMS6w2TRKprjqHCy74lti7
 2lOf19Rsb8TdJRsQMNYxmOv7Ywid+8k+BJX994CGP/lQMXmRavI3lMD3b2adXR0VB1N0iw9O7
 +wJjl9AqNsqyEx34fmmpwFKVYz0hHMLoopNGac5S3lRehjapCNmTAMYt+/y+It2Fm/FywGOEF
 U2Vrna9dW5YB4+5WRGrao2ymHUjQxacFn8DD+Ejqm6dbWZ3kcNYFKkU7gCitZvbgUMeH3Rw/Y
 43MPXtAKX60pSeJ7S0E6Xd65rLBU9JZeoOIeu4s0LCbDOyk4qIon78QOPpJXX9QVw+dkFrjHY
 a5CE1S/VtHji4DzXPw5icUgStiaLT95zqBc5ZnE+z41UpX8Q3SP8j4vzy/EIteWq1nA2ftc6M
 91HObzmfBOrVTxEyjVIgNoobIdyPBvthBxb9GhWrRXgAVER9cvWb8Q97z02JulpfbvE67S85O
 6Fp+EvdzMpqCb8Dq8iI7B+TgNkM2dcJeQTjqBKDpS8VQTn3rjlR7Us+jn/a/NY+8lau22HBBR
 zwixGAcRSk1SFt0/ExMyksd7FuCC+VIU3OkqsE9vclKohkV4N6pCT9Plz67tNQGp6arLf3iG3
 rK2uT/idtlg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-602836542-1552468690=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Fri, 8 Mar 2019, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> new file mode 100644
> index 0000000000..a667a5ced4
> --- /dev/null
> +++ b/Documentation/git-restore.txt
> @@ -0,0 +1,172 @@
> [...]
> +
> +To restore all files in the current directory
> +
> +------------
> +$ git restore .
> +------------
> +
> +or to restore all working tree files with 'top' pathspec magic (see
> +linkgit::gitglossary[7])

This has an extra colon, breaking the build:

https://dev.azure.com/git/git/_build/results?buildId=386

You need this squashed in:

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index a667a5ced4ec..1faeee50593e 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -144,7 +144,7 @@ $ git restore .
 ------------
 
 or to restore all working tree files with 'top' pathspec magic (see
-linkgit::gitglossary[7])
+linkgit:gitglossary[7])
 
 ------------
 $ git restore :/

Junio, could you please put this as a SQUASH??? on top of
nd/switch-and-restore, to unbreak the CI builds?

Thanks,
Dscho
--8323328-602836542-1552468690=:41--
