From: Bryan Turner <bturner@atlassian.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 19:18:26 +1000
Message-ID: <CAGyf7-GBtOjM+PiA2oO4+oXZGKMQ+Lt9DpjSh0=7ma+HFz0p=w@mail.gmail.com>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
	<CAGyf7-HPB-SHNn3bsCkiAw42Qa+JhWJtiYirD8JJ2G5OXzixRQ@mail.gmail.com>
	<CAGyf7-FCj=x9e54Z0o2GmpQeNNeqHKDhHxWP5XqMt5Sfs8i2wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: =?ISO-8859-2?B?T25k+GVqIELtbGth?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 29 11:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3jiy-0002KY-T7
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 11:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab3G2J0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 05:26:36 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38000 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753030Ab3G2J0f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 05:26:35 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]) (using TLSv1) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUfY1S9MBrYlgjyEgeKTIAlHq6+mJQ/Bv@postini.com; Mon, 29 Jul 2013 02:26:35 PDT
Received: by mail-ob0-f178.google.com with SMTP id ef5so1002836obb.37
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 02:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=CCgVU3H7KurOni5Mudi6L4Xu1teXYwb3Vc5v17RcKT8=;
        b=EkYqqi+KYqrGFo72FkHkFueKobP5BTKgE0jM9i0eBaDe4/07PoYTRrQCOyRT0Urdh1
         pKELVTiEL+OpL+zjOkRoepCxJE5hfkx9zEqE1fPIKgRFdhjCISAmZxZFRYRwBFZxksJW
         7WHqVOSNgONHlz3VsUqIHsRlrXtGa86CxfDwjYYV1IlG0nuHjICDVdb4w9+yXDkapK8l
         i3U7Fx2qeHDJMBdeQLrBBWJf276oNPrDotdkYm7q2Xb4OBa5jNdCHYWk/n/9Db9ixydl
         fJ1/2QUg7JsjgjQ3MF89lZWtGnnkbNqWzgkf0gxhs/i8Q7xUbC0ytX7fiyAiMvlwpxss
         UB7w==
X-Received: by 10.182.47.137 with SMTP id d9mr12083910obn.26.1375089506933;
        Mon, 29 Jul 2013 02:18:26 -0700 (PDT)
X-Received: by 10.182.47.137 with SMTP id d9mr12083907obn.26.1375089506856;
 Mon, 29 Jul 2013 02:18:26 -0700 (PDT)
Received: by 10.182.32.4 with HTTP; Mon, 29 Jul 2013 02:18:26 -0700 (PDT)
In-Reply-To: <CAGyf7-FCj=x9e54Z0o2GmpQeNNeqHKDhHxWP5XqMt5Sfs8i2wg@mail.gmail.com>
X-Gm-Message-State: ALoCoQn14GgIvENKEtKxwze7UTwVpQwvuNBELOtO0YJtZ3JtBZ2u6zUV/pd6zzGORXHn3QgHMMep/7Dv84ntDmrme/k/wW/5KP00/86TD94sUIuAcbI5JRrNrGNz6RmgBz7uOdC9BQTiXZiPNl/jsx7tdt7wNekM/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231278>

> diff --git a/pathspec.c b/pathspec.c
> index 6ea0867..27ffe77 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -40,7 +40,7 @@ void add_pathspec_matches_against_index(const char **pathspec,
>  /*
>   * Finds which of the given pathspecs match items in the index.
>   *
> - * This is a one-shot wrapper around add_pathspec_matches_against_index()
> + * This is an one-shot wrapper around add_pathspec_matches_against_index()
>   * which allocates, populates, and returns a seen[] array indicating the
>   * nature of the "closest" (i.e. most specific) matches which each of the
>   * given pathspecs achieves against all items in the index.
>
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 2625f98..01b49b3 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -304,7 +304,7 @@ static void setup_early_output(struct rev_info *rev)
>          * tenth of a second, don't even bother doing the
>          * early-output thing..
>          *
> -        * This is a one-time-only trigger.
> +        * This is an one-time-only trigger.
>          */
>         early_output_timer.it_value.tv_sec = 0;
>         early_output_timer.it_value.tv_usec = 100000;

These two are not typos. "This is a one-time" is grammatically correct.

>
> diff --git a/commit-slab.h b/commit-slab.h
> index 7d48163..4f1c796 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -22,7 +22,7 @@
>   *
>   *   Initializes the indegree slab that associates an array of integers
>   *   to each commit. 'stride' specifies how big each array is.  The slab
> - *   that id initialied by the variant without "_with_stride" associates
> + *   that id initialized by the variant without "_with_stride" associates
>   *   each commit with an array of one integer.
>   */

To my reading, it seems like that "id" should be "is", in addition to
the typo with "initialized"

That's a pretty impressive list of corrections.

Reviewed-by: Bryan Turner <bturner@atlassian.com>
