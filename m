From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Wed, 9 Mar 2016 16:48:34 +0700
Message-ID: <CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info> <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com> <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
 <xmqqlh5ungct.fsf@gitster.mtv.corp.google.com> <xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
 <CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com> <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 10:49:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adak2-0003yq-SO
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 10:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbcCIJtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 04:49:10 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34367 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbcCIJtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 04:49:07 -0500
Received: by mail-lb0-f177.google.com with SMTP id xr8so55659233lbb.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4+aWQukfsf95gFJ5pCspCx/GwHHV6AmBtRojPcxCLms=;
        b=X97N8I04Sa/+db43eyjTEwS6j8JkSNbUukB7gWDa/zUquyhK91/UEKBHqBAXAjOof+
         zJqoaRVLmKjkejOBonPoulT7ju4AdOMpjEG1OAxl3G3raQajjPGwNQvBw3QroOdlqdAg
         rF2iu5SSltUBfpbyNyY4105DY+bYwGn6Xu1gN8t+2cHAd4PTN34qxF0pALAc59EDBf/i
         WkvYDbJBpTsDpxPCX/IfPSXtHG6bYAhCjQBIEMqkBcZ3niucnpv0uyJ5y+qPxHM3PK9v
         L9rHRoR/p4B9hsMMnPehECT+QShEuELeut1zEiJUdSG3+Bl5IdoaSVh2Z1d7teIu8sRB
         XERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4+aWQukfsf95gFJ5pCspCx/GwHHV6AmBtRojPcxCLms=;
        b=V8QcJAAsUTJQlzdLpSuHjIVdCM+Y8mu/J5yGcOYSlw9lUJ0T1CAgdL4xClD0fK+zYV
         rDKu2ZuyAmJxbrNqlE4CayM5MSOWOHfWsFs996Tj1tUASrQw3YxGR4w7M6VhMncv+tws
         6JbqtRoE3r96TY9BvChHqpj8lbWUhMgTEJ32EExJGiUmS9qnoncmXS3tC3nfAkqwNdlG
         cEc70nx8RekEGZ5zeE8bbdKEKoR8ORFv2RbJaFM8J6dDcMV426a5faCdvZpC8gUE8+of
         bfPwge7985lYyD+Tlkq7fz/Mz6CXvzEzzTceID1nmRoNhV90kCsM7o1D5ayV/7svNNk3
         YKQA==
X-Gm-Message-State: AD7BkJLW3IefgQmDEcmmvHHOyoU027C/694pg5hl0NNnfvLXCNqb0ghuSf6sd3IeV2ukqyBVYWxWHWmer3dhHg==
X-Received: by 10.25.211.75 with SMTP id k72mr6453678lfg.45.1457516944586;
 Wed, 09 Mar 2016 01:49:04 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Wed, 9 Mar 2016 01:48:34 -0800 (PST)
In-Reply-To: <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288477>

On Wed, Mar 9, 2016 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 3ded6fd..91d1ce2 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -148,7 +148,43 @@ excluded, the following conditions must be met:
>     be in the same .gitignore file.
>
>   - The directory part in the re-include rules must be literal (i.e. no
> -   wildcards)
> +   wildcards and has to start with a `/`).

Technically '/' can just appear anywhere in the pattern, except at the
end. But because the patterns in question must look like this

    dir # or any pattern, even "*"
    !dir/someth*ng

even if there is a slash at the end (and is ignored), we are still
good. Not sure how to phrase that though.

> +
> +A re-inclusion of a directory makes all files in the directory
> +unignored.  For example, suppose you have files `.gitignore`,
> +`dir/file1`, `dir/file2`, and `dir/file3`, and have the following in
> +your `.gitignore`:
> +
> +----------------
> +# .gitignore is not mentioned in .gitignore
> +*
> +!/dir
> +# dir/file1 is not mentioned in .gitignore
> +dir/file2
> +!dir/file3
> +----------------
> +
> +Then:
> +
> + - `.gitignore` gets ignored, because it matches the `*` at the top
> +   level;
> +
> + - `dir/file1` does not get ignored, because `/dir` marks everything
> +   underneath `dir/` directory to be 're-included' unless otherwise
> +   specified;
> +
> + - `dir/file2` gets ignored, because `dir/file2` matches it.
> +
> + - `dir/file3` does not get ignored, because `!dir/file3` matches it.
> +   Note that the entry `!dir/file3` is redundant because everything
> +   underneath `dir/` is marked to be 're-included' already.
> +
> +Some earlier versions of Git treated `!/dir` above differently in
> +that it did not cause the paths under it unignored (but merely told
> +Git that patterns that begin with dir/ should not be ignored), but
> +this has been corrected to be consistent with `/dir` that says "the
> +directory `dir/` and everything below are ignored."
> +

Looks good.
-- 
Duy
