From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] merge-strategies.txt: fix typo
Date: Sun, 21 Feb 2016 12:21:20 -0500
Message-ID: <CAPig+cTkTxGJAOy-CDFJHwOg=C3Mq9ZHNyqBZ_+S0wTXh_SHaA@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-3-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:21:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXhF-0001Ij-Pq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbcBURVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 12:21:22 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34270 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBURVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 12:21:21 -0500
Received: by mail-vk0-f41.google.com with SMTP id e185so111774457vkb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=bOQGZUvjhbYxZP/zeuExs2n816NIL1Fjq7loOK6nfmw=;
        b=H+ecs6FBxojQna1r9dE63Gu30bPf/BkOcyNzOjCpdF1Sh7zNJoFT3IDJ/4uaqM2bL2
         x4hP6hILfOrr4trDeQqNdC3BuD3TSpE11rizHa6zjj7jgjprDJ4h3MnPSaz+FWvoBBUV
         QvDvgfqnxoCXsqU8BxhFoo9QAfpzpyBCo52zc+fKaEdORwz9P3cZ+DTnSPYHBUJc+Kof
         AHsblQ+NaI1OuiRdzOhDF9MhjGw8KO6yGR4Ds9WLv3v88c4Ztu9oHy1M9UIQVstr8Oua
         GWrQlJ31wlWwKMkkwJU4GbV8tdWkjek8Xw3veaM7HzknmGpbe/LKddnF5Jg25dHjEI2W
         fCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bOQGZUvjhbYxZP/zeuExs2n816NIL1Fjq7loOK6nfmw=;
        b=OkX+OjtQTq7LoQjqPtyR+d51TKUVHxRb+YA4m2CWltLXUlgi6KTp0eoGgUKebWDcOY
         WbwY+QZKBf3Gq2eiJNDBwuSa2jtM0T7J3jbdBfyu/Pi7oeoCnA+xSjWVKleUcQVDLoRH
         aTcywkZSTH4rcMb6+0ZPNXx4L9Cy8GACNmLe2UoZk2vBt9EPLNIeqqVYb7jmIwwv1jOy
         9//ujhmN9H1mNBa7Wvbq7y6LRnAfi2h3j+h33GKs1zpbnk9YWbHrXyBXsbdXihXCYZr9
         2xSJtvKFvMKyDrq2V1isB6kUF4M3j7ezQ04R6Ic033MNeLfrJXuptbuY/3AcHHI9y8A9
         JSCA==
X-Gm-Message-State: AG10YOSaougJuWYfl8G/7qWdxUjnG/qG1EOAR9f/OdStlhgV6qXubd2bm6YIXIGKeEXUFFUYOYKmorjZR5UGrA==
X-Received: by 10.31.47.135 with SMTP id v129mr19980622vkv.115.1456075280453;
 Sun, 21 Feb 2016 09:21:20 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 09:21:20 -0800 (PST)
In-Reply-To: <1456067358-19781-3-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: pvWnLz6MQzc_i9LoFbCmr6MxG3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286800>

On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge=
-strategies.txt
> @@ -86,8 +86,8 @@ no-renames;;
>  find-renames[=3D<n>];;
> -       Turn on rename detection, optionally setting the the similari=
ty
> -       threshold. This is the default.
> +       Turn on rename detection, optionally setting the similarity
> +       threshold.  This is the default.

I'd probably have omitted the unimportant whitespace change on the
second line from the patch since it's just noise which distracts from
the real fix, but this alone is not worth a re-roll.

>         See also linkgit:git-diff[1] `--find-renames`.
