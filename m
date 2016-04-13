From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 6/6] commit: add a commit.verbose config variable
Date: Wed, 13 Apr 2016 02:14:23 -0400
Message-ID: <CAPig+cTcCyGu5Y8aHbE3i6fXh3T_mD0ZiuxPFh=DVHOE38pE5w@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60966-e9711378-3b22-4fbb-a2c7-f6876a6fb3c6-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 08:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqE4P-0001nW-I6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 08:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbcDMGO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 02:14:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32869 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260AbcDMGOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 02:14:24 -0400
Received: by mail-io0-f193.google.com with SMTP id g185so5507594ioa.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=q9eZMBM09URAr6tAOGMRzryfm6cXIl52lDTk+/n8Ah0=;
        b=o/V3e/qYX7D3PJKiWLqVx8C6Kid9UdFamnrMjsXLoL9SUMlb9S8d/1PP3SYBea4k9l
         cQ44HhFuvJMiTG5tYWmgV7cygiqfwy1AA0Wu463qeLuEzZ3mAXY4H6gD30912nLRjYg/
         bVKtPc0YVdfVFcUSo4Fom/z2sxGHby5aiVnBruFyjAVLaj7TSmqw689GtBaRhP0nB3OX
         /LIC6CG9ZQvGQAj+u8op1QmU3DiCBnqxd5i+BiD6mkphzBBYBFqv+gG54o03Dl5CsvoC
         ZoD+YMul6puEdRv2J2WTTK/wKYBGdfa3gKwQTTq69BU92zWgbsUkbl92bDZJOEHucvOW
         fE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=q9eZMBM09URAr6tAOGMRzryfm6cXIl52lDTk+/n8Ah0=;
        b=dlufQNQaniXPwm/ohzlV/8Ekj+wvEoqu2AreJgq/lYJImB4TbVLNZRBP3dmw+C9r5i
         o7O5xkF53yKV+IEReUskCrdjx7zNYFN5Fp6MFH8cr0WRBIXM1r4fedAQjfRgt1rCfkE1
         J8WJKNTJ0ZEeU0Ci+sbmUAf6zU8Ea0QNPdwUBJdc+gN1T4SdP2bl5FNa6anTSlPyxCBY
         BoXC+5JG4fELMkiwFMKVunke0RpF+mEI8sdIeHPKN5BZ7yAzZuEuAjrVGjhi9jzwECqJ
         2VFBpPSjgT3H7XbRb0NHbRKMb/hUcML3O+IWNeZZkpvzK0Wuh6egdT+0unE6bPtqUkaF
         aMjA==
X-Gm-Message-State: AOPr4FWzLLStxZYL1xYIayDE3y0i9KJODb6E7zVhEQrIlJnuefQIf4afnWOXkgQ5FkFtLVYUqBStDuYk6Cs3Pg==
X-Received: by 10.107.8.141 with SMTP id h13mr9057855ioi.34.1460528063604;
 Tue, 12 Apr 2016 23:14:23 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Tue, 12 Apr 2016 23:14:23 -0700 (PDT)
In-Reply-To: <010201540cb60966-e9711378-3b22-4fbb-a2c7-f6876a6fb3c6-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: jW8DvuNg3E4Nmt-ndsFK0dyGUDY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291375>

On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -98,4 +98,60 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +test_expect_success 'status ignores commit.verbose=true' '
> +       git -c commit.verbose=true status >actual &&
> +       ! grep "^diff --git" actual
> +'

I understand what this test is checking, as it is in response to
Junio's suggestion[1]...

> +test_expect_success 'status does not verbose without --verbose' '
> +       git status >actual &&
> +       ! grep "^diff --git" actual
> +'

But what is this test checking?

> +
>  test_done

[1]: http://article.gmane.org/gmane.comp.version-control.git/288648
