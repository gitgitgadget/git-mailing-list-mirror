From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] SubmittingPatches : WIP tag in patches
Date: Fri, 26 Feb 2016 03:00:26 -0500
Message-ID: <CAPig+cT9Aqm0+AEGz0F-CTihMJtMw45fq4h6zxKs_7uxHak0bg@mail.gmail.com>
References: <56D05BA2.1090502@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@zoho.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:00:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDKB-0003HG-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbcBZIA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:00:28 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34565 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbcBZIA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:00:27 -0500
Received: by mail-vk0-f43.google.com with SMTP id e185so70546236vkb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 00:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=a5VC7gGpPCh/5XvPCmAmWg0dcQXJgv9njjl5pV6cB/c=;
        b=iKo7RzSzMmSDI0tVrwwmGKPB99TX4U1kAyHd6jcg1lJ8l/9dl8oukNEo9tv5PDy+mB
         AYdm0EahmUeAfNeBykSIoozhPlPGHHv+lnpc6NNmRJaFE81JZFUQkWMJfidsFqLa3xv7
         3FzfCknj/A/1HBz6siphgoWbVQGLVvbzvyPqq1sqHVLafsjxG6CFFTxT8m18UQvwPsvw
         JiahD28gj10bWchphwqVGZnFWnVich6Ws6Z4LKGxl4RheIvx/XJoE3YXjS77axLmeO3c
         fhn1uITjSaWKS2OV6dVko+psQmmFzW05lDXMnjjuPqzzaR11BOxImCCUHn8ofNadkk6m
         ltiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=a5VC7gGpPCh/5XvPCmAmWg0dcQXJgv9njjl5pV6cB/c=;
        b=DIs+SOUNajx/PiKgKh/qjhVUvE3iDqBLyC+JtkXBLFAcl/vkE2xwdy1MSY84CL2eGr
         p2j34N7Q6xwQdnRTtVi2O+RMf8u67+Fqj7avtn5A/lNvOz/J3gifb6ztT3cBL2Hv5xzx
         NgMO/4zdde83VFf40R8PTL3yJvxvzdthO52TGF7bbLHFB9EyKN/Zy02nWh8bFg4QAWya
         lYvp/a3coZ8l2a2CV+M63R4JtoJKRsxYd/rvTkUfKN96WVdNxmqhpPFTv0RHUwBARZzE
         Q9uERN0Y1H9594yAUusEk+5dvZBzZFOFE3SdiqxxfkKLQfohjTPkRb15PDEFt6iKN4mi
         3yaQ==
X-Gm-Message-State: AD7BkJL1rT861ktqy3ej+J0GVqg/y1dxiyBtTizzOYBy0QbeQss1SzzXCDOrdOzqFyvWZJk7XM/I7jliuwchGw==
X-Received: by 10.31.150.76 with SMTP id y73mr130003vkd.84.1456473626908; Fri,
 26 Feb 2016 00:00:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 26 Feb 2016 00:00:26 -0800 (PST)
In-Reply-To: <56D05BA2.1090502@zoho.com>
X-Google-Sender-Auth: 67QpjhxSvelzU87aIhTFjGkNM3c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287546>

On Fri, Feb 26, 2016 at 9:05 AM, Pranit Bauva <pranit.bauva@zoho.com> wrote:
> ---

Missing sign-off.

> diff --git a/Documentation/SubmittingPatches
> @@ -168,7 +168,9 @@ the closing bracket to mark the nature of the patch
> is also
>  encouraged.  E.g. [PATCH/RFC] is often used when the patch is
>  not ready to be applied but it is for discussion, [PATCH v2],
>  [PATCH v3] etc. are often seen when you are sending an update to
> -what you have previously sent.
> +what you have previously sent. [PATCH/WIP] is often used when some

Perhaps: /is often/can be/

> +work is yet left to be done on the patch but you want to get the
> +review on the completed part of the patch.

Maybe: s/review/feedback/

>  "git format-patch" command follows the best current practice to
>  format the body of an e-mail message.  At the beginning of the
> --
> 2.1.4
