From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/21] i18n: advice: internationalize message for conflicts
Date: Wed, 18 May 2016 15:24:57 -0400
Message-ID: <CAPig+cTgQmJG5a8dNjkYcNPG_vEHycyi19sHkO_yO-EfFQzy5A@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed May 18 21:25:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b375j-0007Yb-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbcERTY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:24:59 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36192 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbcERTY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:24:58 -0400
Received: by mail-ig0-f193.google.com with SMTP id c3so5539080igl.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=8/XvvgI3LO4h5lYkJacjFcFf9VLcM15WtXNWjgaPXCM=;
        b=U+hiOamJkccXRtOYsxo0R3Jkfu6GRZ1IKEnkgOVb5y/W2a0zH+zkDEVChloa3v0QfY
         B7nZZGNmeaGtPuShpjw46yk9fVxoPAhhGzIO6x0VsTYW56FuUfx2nzyoD3C+vAbBqHV8
         47302xN8myNQ/wo/LHSsadlpIoh9EOo5h000kGzzzgaSmQaBxxLFs5kQR6zqZ19tV1e/
         AZdl4vZlZ/HsSs+8nOJJ8OmUETrDFdQRh94kQ1blGuZTLqnxVYWUYrZz2bfH505P7dKZ
         xQwHp9PS4emhQuYTqWetqAUDAM5RQn/3eLcMD8c3Cm6tsaUzbPCHlj7SaW5xWcDqaP8Z
         EUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8/XvvgI3LO4h5lYkJacjFcFf9VLcM15WtXNWjgaPXCM=;
        b=cB+xWf1WXuBUejXVst8oOsRoZyOOm4k9GWl09UE0m/AkNhwqT0VSWbRfrCnxlylXLN
         HaQOTPgQITTu0wJQfYDAzc6E+tGnfjldU3/XqyJoLhYlLttwnJZfuhQlQScw0mFHzidy
         PflXPUtbW6k+TRvVtXPTzWI2Zj+dCitycFhY6XZSwiVDwtXEriER7DMw3th/nzXukV3+
         Ayj3MfogcxoLVVqEpF6JUDLfyW4SPYoNfDuE2eOpg+kIXA1NBGgqSEVhPYhhKmqkFLo/
         AiPPdc2gOh7tnpWSDfa1oFRdezRHFU+3UCC5H31mGvWdur3W8eAjsA/RyF/jPekgHOIe
         I3ew==
X-Gm-Message-State: AOPr4FWdH8IWIksOapbr+oCz9E1XMmr7O0i3x+TQzt8T7e+R1CDsU+ST3nbfyxIfvR0oIrUpSbpNA8O4Rc1jGg==
X-Received: by 10.50.6.15 with SMTP id w15mr7098026igw.91.1463599498012; Wed,
 18 May 2016 12:24:58 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Wed, 18 May 2016 12:24:57 -0700 (PDT)
In-Reply-To: <1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt>
X-Google-Sender-Auth: MAMQNkOb6a4EkzDXVdQungxQDEk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294994>

On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> Mark message for translation telling the user she has conflicts to
> resolve. Expose each particular use case, in order to enable translating
> entire sentences which would facilitate translating into other
> languages.
>
> Change "Pull" to lowercase to match other messages.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
> diff --git a/advice.c b/advice.c
> @@ -79,7 +79,20 @@ int git_default_advice_config(const char *var, const char *value)
>  int error_resolve_conflict(const char *me)
>  {
> -       error("%s is not possible because you have unmerged files.", me);
> +       if (!strcmp(me, "cherry-pick"))
> +               error(_("cherry-pick is not possible because you have unmerged files."));
> +       else if (!strcmp(me, "commit"))
> +               error(_("commit is not possible because you have unmerged files."));
> +       else if (!strcmp(me, "merge"))
> +               error(_("merge is not possible because you have unmerged files."));
> +       else if (!strcmp(me, "pull"))
> +               error(_("pull is not possible because you have unmerged files."));
> +       else if (!strcmp(me, "revert"))
> +               error(_("revert is not possible because you have unmerged files."));
> +       else
> +               error(_("%s is not possible because you have unmerged files."),
> +                       me);

Despite the commit message, I still don't understand this change. 'me'
is a literal git command which shouldn't be translated, so how is this
helping?
