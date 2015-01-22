From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/4] apply.c: typofix
Date: Thu, 22 Jan 2015 15:17:42 -0800
Message-ID: <CAGZ79kYR7AcgTghwLoTejvaB=BRW+YxJdHZtjteXVbcrNqh8LQ@mail.gmail.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
	<1421967505-16879-1-git-send-email-gitster@pobox.com>
	<1421967505-16879-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YER0W-0006Je-5r
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbbAVXRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:17:44 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62190 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbbAVXRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:17:43 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar1so4334567iec.6
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OSy79CrFYfe4q9hBr4qzXQm3qoLJ4eVZWifhGupyCPU=;
        b=XE8a+qaqVanYri5i7fa90CEIhGsoZH3+Ydxrp5BJ1Mrp8Qt5d/pvUjWsdEIoa1rLb/
         GjseFL7+hQfcFyNQaQmT3niAXoZef53qnWQ9+K2MGF2Fakn8f8b1KhPi0k4bCESp/843
         RC0SqwQj3qF+sRzod0k7uBQCHBdxrGqNOHaAJmljOvMQ/uBBIUI54GOoC7RsfY/vtbGi
         DCANXstaorEPe4D0ybv0BFwH5H3NOHC+UrffJsGs/4wfjks5bFUAI4JCk55/GptfNek9
         YCmrY1hybDexfy2CUUvuL27jzG/bSG45eYGlUXzeRpBgxprdzAO7QUr+9KJH+TO9W2Sa
         dvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OSy79CrFYfe4q9hBr4qzXQm3qoLJ4eVZWifhGupyCPU=;
        b=RiY5x/cLVZlY1h9jxBYMYtv0mjse4ka/nyBjrBOLcMMeN8Ci+LvqeLjkEzp8Jb1Irg
         FctmUHrlxVpbU2XZ2iBaD74K+Lj+pG2A8/BVTOAaA+6xEhubHlihmJ6LBSp9nV8Ish+F
         dCqGU8PzoZlRfIwS9bKkCJhQ9K13ixQ1LmFYRQsFTj4FhjC7+e4gAglg3xYUSCshUWgq
         HPqWle2teq1Szueev92YHVqy8oLFezr8pYQ7cjiQqGL7z93zMjt9RSPJDprk5xs0QkVf
         ofrh5LHkpv2Q08Cr3orAgpanvp24H3mE1VKj0+z78jbCDHzXl9LyvzUgWh1r8w9pDZTG
         Dztw==
X-Gm-Message-State: ALoCoQmkIinJtwkBO1BOi7/V1Zo9LgyO272FjSTyJW48AxxX0CyBtosAtIRL/MyC/zPdTjgon70t
X-Received: by 10.50.222.70 with SMTP id qk6mr7880790igc.47.1421968662797;
 Thu, 22 Jan 2015 15:17:42 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 15:17:42 -0800 (PST)
In-Reply-To: <1421967505-16879-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262892>

On Thu, Jan 22, 2015 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/apply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 622ee16..31f8733 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2326,7 +2326,7 @@ static int match_fragment(struct image *img,
>
>         /*
>          * The hunk does not apply byte-by-byte, but the hash says
> -        * it might with whitespace fuzz. We haven't been asked to
> +        * it might with whitespace fuzz. We weren't asked to

(not a native speaker):
A quick websearch reveals "We haven't been asked to ..."
is quite commonly used in the web. So it's more of a grammar fix or a
rewording of a comment instead of a typofix(which I assume are miss
spellings)

>          * ignore whitespace, we were asked to correct whitespace
>          * errors, so let's try matching after whitespace correction.
>          *
> --
> 2.3.0-rc1-116-g84c5016
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
