From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/GSoC 3/3] Nousage message in error
Date: Thu, 24 Mar 2016 10:44:08 +0530
Message-ID: <CAFZEwPN2vp+zOMdGY51LwNpgNcYxsGD4GBXHNOA8_qJ8vtE5OQ@mail.gmail.com>
References: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Diwas Joshi <dj.dij123@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 06:14:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aixb5-0006it-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 06:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbcCXFOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 01:14:10 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34315 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbcCXFOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 01:14:09 -0400
Received: by mail-yw0-f175.google.com with SMTP id h129so46511430ywb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 22:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=aZM9Qm2VCohLs6VzgTZv5tZ+QmlsNl0WryglXrakLb8=;
        b=ezHueTloFR2cLHoChlj7GrZWB/wGUkXFIsiD50rC/B7i5dI3PykcWhG8FC4wlufrgC
         r2kEIWmZFvXzZoaEsuQpAGh1qcmBjey4eLXARzimPLPS4mVqV6g6p0MEL9yCBtDrstge
         yEDcxZ4Yyi5QQ8ZgAXS+fYP8s9pQgrIhjs5FGhrTBPSjQGU7OWyPvImUeAQNG/M26PL/
         XVgjvxCNHLvcJ7Lxp8BDjA0IaElfKAoCC+Z0WfXXEuAfX4Jl0/Yzi+wRQI8gAKn1FEYA
         1BBf4sIry+IWKXZUzeHZ6MrZ7F4AjziyM7umLzJvUlHYIrr8JvPGWJPqBuEnjbNLwjEa
         VjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=aZM9Qm2VCohLs6VzgTZv5tZ+QmlsNl0WryglXrakLb8=;
        b=Fp5MU4IhMgWiYkhXvWAwjP7+1Sjam0SPNWWMZbTao7Gyj3hYVSEJ4KvqDlJiQKUq4f
         mAQQdGoaPpO7JtMVq6/0s7QZkTn7kQyAWq2m6oIxW3NRQ3TF+IL3JmpZDNm/2lFUyWxY
         mF7Nw4WU88z35727CyGwOtPHHV7AXcqTynADivwpO2d8EvwBL42c8tOTI9O7CyyBbMc7
         BRu83iSa1oYDtI56Y4I2ze9Vw3hYS5Ln85YjXuVU2YQ039vxrElfKToxsCYC22JggirN
         Vt8PJiMY6BcAMM9UJdFexEU6M94OIkXdQB/04hoeU1ixardoS0AWrcGLMACqMnQ2qmhR
         +uWA==
X-Gm-Message-State: AD7BkJJk4kP0k6GhkGk3Owri8vhHBKSswMEJuT7pIBpvA6mYLqrfrYUWWMA8oJP1MCoaywNB9FAHekdJpxN1kA==
X-Received: by 10.129.37.3 with SMTP id l3mr3196318ywl.128.1458796448350; Wed,
 23 Mar 2016 22:14:08 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 22:14:08 -0700 (PDT)
In-Reply-To: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289709>

This is my first review. It can contain some mistakes.

On Thu, Mar 24, 2016 at 7:33 AM, Diwas Joshi <dj.dij123@gmail.com> wrote:
> Subject : [PATCH/GSoC 3/3] Nousage message in error

Mention about GSoC in the notes section (the one followed by the 3
dashes ie. "---") rather than in the subject.

> - To show only error text instead of full usage message
> - Adds exits to callback function in parse-options-cb.c instead of returning -1 which results in display of usage message.

A general convention followed by git users it to write the commit
message as "What he did to the code?" rather than "What problem was
there in the code?" And of course after writing what you did to the
code, you can definitely mention what problem in the code made you do
this change.

>  parse-options-cb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 239898d..b7321d1 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -85,8 +85,10 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
>
>         if (!arg)
>                 return -1;
> -       if (get_sha1(arg, sha1))
> -               return error("malformed object name %s", arg);
> +       if (get_sha1(arg, sha1)) {
> +               error("malformed object name %s", arg);
> +               exit(129);
> +       }
>         commit = lookup_commit_reference(sha1);
>         if (!commit)
>                 return error("no such commit %s", arg);

Maybe you could describe a little more on why this change is required?
Why would the user want to know "How to use the command?" when the
actual problem is that SHA-1 checksum has been compromised? And I
don't see any consumers of this method which *directly* interact with
the UI.

It seems that PATCH 1/3 and PATCH 2/3 are missing.
