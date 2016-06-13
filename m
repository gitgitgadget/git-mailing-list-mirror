From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Mon, 13 Jun 2016 12:29:08 +0530
Message-ID: <CAFZEwPM5qnzw7RCUwOkJFo+U982kVGU8_3GUTXvHAypKtvEgTQ@mail.gmail.com>
References: <20160612191550.GA14160@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 08:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCLq6-0004VJ-UN
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 08:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbcFMG7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 02:59:11 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36825 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837AbcFMG7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 02:59:10 -0400
Received: by mail-yw0-f171.google.com with SMTP id v137so16014281ywa.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PWuiu0rIikBQCReYazFtJ9iGOkqLrCO38ACCV8/iVpI=;
        b=sw3AraCjBUeCzqrzp3lYRXYJxTpZk1Rizmbnd99T6OYpWN5b6ZvQhYbG7gOqxAtyF3
         mnbB8pQmwJhX0HjCxEBefA9p47G0o+/uInFFc5tJ2z+rTn+tdfW2WGNqPDgO2Ci1d4hl
         yd4uBAzMGBFl9WXAjlyRlc6uPfe6SNGxPTAcujXjvOU4fDCl+zdCosLNU8AgHSyPz7CU
         MhshRQpPOEH8/BCnmfQEn0FGH1BJps50iRjwR9+0IK/tzbKevMbSEFfuwdpa7K9duYJu
         8nLsB/DlBtHs5k5dBd5ecyTM2qVPHEju/33nuNcZK2KOyr4JOuQWVAg1LdLZXaySU8KZ
         7kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PWuiu0rIikBQCReYazFtJ9iGOkqLrCO38ACCV8/iVpI=;
        b=asBfbt+3e2EiHyGx2KMI96sKaH66cQAWnxUkTHACJz7Ll9+Evi2zUDBfDfzuNBjOwe
         Xz7ezOyuSt6HZHVYXlUZGg4fWGuh9BdzrPHOrQziY+LrG45b/Um3zTgoD+sD79+W1qDa
         JTIdteOhYfZNokM9vEJD2xq337QtcA2wmtImBT4sYStZoMYQFuRMNpCWEfRhbpm/Qy/v
         b7kXVh9jRUlbc0XIwFvzW/UNjuaihgByZoyqeQJNV1ah0CLm1ULn3Nw0lYHJGo7j7a4O
         q1NO07yJzC/jvqmB5itvdATcd/nKHxKmp9lOrngWrwcswDB/sxnq0K1p7CpgnEbvL2Ia
         N+vA==
X-Gm-Message-State: ALyK8tKe1rG/4Oj0SHSCJkgiAdVthKhIZ1MP91ZzqpXlliWKKmFh+qtzNZCqmvmlV5fMkDx3Oim+ekMde7srVw==
X-Received: by 10.13.224.6 with SMTP id j6mr7632678ywe.72.1465801149235; Sun,
 12 Jun 2016 23:59:09 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Sun, 12 Jun 2016 23:59:08 -0700 (PDT)
In-Reply-To: <20160612191550.GA14160@elvis.mu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297161>

Hey Alfred,

On Mon, Jun 13, 2016 at 12:45 AM, Alfred Perlstein <alfred@freebsd.org> wrote:
> Junio + all,
>
> A week ago I was requested to provide documentation for the
> 'svn propset' command.  I have attached a diff off of the
> 'maint' branch for this, however it seems to apply cleanly
> to 'master' as well.
>
> Thank you for your patience.
>
> This is also available on my github here:
> https://github.com/splbio/git/tree/document_propset

I am not particularly sure whether the above could form a good commit
message. I think you wanted to include this as a comment. git-am picks
up these patches. The title commit is taken from the subject stripping
the '[PATCH]'. Then the body before '---' is taken as the rest of the
commit message. Then the diff is applied. To include comments add them
after ---. Also please have a look at Documentation/SubmittingPatches.
Also missing signoff. For the patch to actually be accept you need to
follow those instructions. Thanks for contributing.

> ---
>  Documentation/git-svn.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index fb23a98..e104824 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -459,6 +459,20 @@ Any other arguments are passed directly to 'git log'
>         Gets the Subversion property given as the first argument, for a
>         file.  A specific revision can be specified with -r/--revision.
>
> +'propset'::
> +       Sets the Subversion property given as the first argument, to the
> +       value given as the second argument for the file given as the
> +       third argument.
> ++
> +Example:
> ++
> +------------------------------------------------------------------------
> +git svn propset svn:keywords "FreeBSD=%H" devel/py-tipper/Makefile
> +------------------------------------------------------------------------
> ++
> +This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
> +'devel/py-tipper/Makefile'.
> +
>  'show-externals'::
>         Shows the Subversion externals.  Use -r/--revision to specify a
>         specific revision.

Regards,
Pranit Bauva
