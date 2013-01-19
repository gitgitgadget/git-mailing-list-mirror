From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sat, 19 Jan 2013 02:39:36 -0800
Message-ID: <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com>
References: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
	<379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 11:40:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwVqD-0005aF-Ny
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 11:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab3ASKjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 05:39:39 -0500
Received: from mail-ea0-f181.google.com ([209.85.215.181]:64025 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab3ASKji (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 05:39:38 -0500
Received: by mail-ea0-f181.google.com with SMTP id i13so873252eaa.40
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=k4KVp7yfRWYPTN7bNdkvX0FFjmiWX9YGgqRFtkAMZJ0=;
        b=YpmB0ew4LZTxQaNfojHP3jBUYOZQi5Emc8ZiNOB0C+9tQxrwwZuCGEZYeNmE4pz5OS
         DEWiN2CdqD+zATZiKy5uf6WWyj+Zni6Oe02deZ3HQ96rY2OJwY1YlKLyd4KV3m2WoJft
         gShyZEw5gOtnpwjlTrGZYJQbpk70dpKC7HkTRFO6subEeHiBzvH5ajyrAD4t0NhMHAm3
         ZsuXueUxbk6dd+3HA2+Tj4VkjTvj1ZcGn5QAv0/4Ro6ltqC7c/fFTfibF0g5YCpd1Vn7
         2HdZmPWnd494AAw4iEaUuqthPTf20K6l3NoqYB8Kvtfev/IAoxyiWRy7AxCkIVGhwXc2
         0oKA==
X-Received: by 10.14.205.198 with SMTP id j46mr37048779eeo.27.1358591977058;
 Sat, 19 Jan 2013 02:39:37 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Sat, 19 Jan 2013 02:39:36 -0800 (PST)
In-Reply-To: <379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213970>

On Sat, Jan 19, 2013 at 1:59 AM, Thomas Ackermann <th.acker@arcor.de> wrote:
> @@ -55,7 +55,7 @@ History Viewers
>
>     - *gitweb* (shipped with git-core)
>
> -   GITweb provides full-fledged web interface for GIT repositories.
> +   GITweb provides full-fledged web interface for Git repositories.

What about GITweb?

> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index d377a35..0df13ff 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -73,7 +73,7 @@ in ref value.  Log lines are formatted as:
>  Where "oldsha1" is the 40 character hexadecimal value previously
>  stored in <ref>, "newsha1" is the 40 character hexadecimal value of
>  <newvalue> and "committer" is the committer's name, email address
> -and date in the standard GIT committer ident format.
> +and date in the standard Git committer ident format.

IMO some of these look nicer when everything is lowercase.
e.g. "standard git committer ident format".

> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 168e8bf..d364c3a 100644
> --- a/Documentation/gitweb.txt
> +++ b/Documentation/gitweb.txt
> @@ -504,7 +504,7 @@ repositories, you can configure Apache like this:
>
>  The above configuration expects your public repositories to live under
>  '/pub/git' and will serve them as `http://git.domain.org/dir-under-pub-git`,
> -both as cloneable GIT URL and as browseable gitweb interface.  If you then
> +both as cloneable Git URL and as browseable gitweb interface.  If you then
>  start your linkgit:git-daemon[1] with `--base-path=/pub/git --export-all`
>  then you can even use the `git://` URL with exactly the same path.

Git but not Gitweb?  IMO it reads nicer as "cloneable git URL",
which also avoids this mismatch, but like I said that's my opinion.

$ git grep 'git repositor' | wc -l
226

These changes touch, for example, git-clone.txt to make it
say: "Make a 'bare' Git repository".  Why not lowercase?

In that same file it has "git repository", in lowercase,
in a later paragraph.  I'm not sure which way is preferred,
but I think they should be consistent.

Anyways, just some small notes.
cheers,
-- 
David
