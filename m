From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 31 May 2016 08:41:34 +0200
Message-ID: <CAP8UFD18mbT12+9P0vqNWAnNirCD0oRz1O-ajFmm5y1BNTdVFA@mail.gmail.com>
References: <loom.20160523T023140-975@post.gmane.org>
	<CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com>
	<xmqqeg8s8og8.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0yB8XjUi0f2OTUrW9W1UPC_ekY3+8--CC5rk_5RciYAA@mail.gmail.com>
	<4067AC3B-D369-4E86-9EB9-ED19FD362E2D@yotamgingold.com>
	<xmqqvb1u7okk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yotam Gingold <yotam@yotamgingold.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 08:41:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7dMy-0003nz-NK
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbcEaGlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:41:37 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38137 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbcEaGlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:41:36 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so93821519wmn.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZGWQcU1hSTp+SQz+yQKjCfQyNkWZEQR7UoFwBLjFWnI=;
        b=Y0JDdQ3YfcLsgpm6kyI1DQ3E7AEe35R56rFiIxbteXvoWexT919CcsOd8qkx52QBuc
         dwfJmDzwnB6y5p5qlTkGVeLq32GnzWcvkUDG4xbXCEOcRowz7SpYoce3UURmsqIQvj1g
         p27Af9LhyPeeoE+UG/IMGNMPCcqVKiD6vTGxCz48L4bBaomZffM+gBTjDeNmXaaALVRf
         l9iAGjQfnISHO5kxrIXnp+7OttvS0wG0ofN/16m4V/ZzfA5Um6u0jCjGG5hdVgVqtduq
         Jgd7Ae7TPYpOqXOQa9dquMifjhk4nbQTs9ZawoWXGPRLzakio2C/pF9AYab3F29n+TFg
         RQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZGWQcU1hSTp+SQz+yQKjCfQyNkWZEQR7UoFwBLjFWnI=;
        b=ZNd+gvej2gvwTHoKM4jwhQxpxeTkZ4P9vuC6XY45G9S4aI2RzQ2oBw5+rT6wQ0nAyJ
         B5zTd+oe59SxCbVA51EpCuU8GkSBZZanWw3SCddnbDz5PeIJL6A/Kw2U8ephmVjDonAs
         90AEf5lFzkRF1CPD2iwz4CNEzFVCHwRMAfXyiOnDe76OgpW1wn7I9/UX+ryXUFDOTQsn
         PB1+GyPZIYYHLjewLSPcu+zv3zbw5eVdWd9j6UDosuF3RQ7q+vIDahGUi1ko8ThEZQn3
         HihuAXPe79jSHzVS7lFItJ8b3LnBCSC9AYULunH+ysJizehi8ECC1SDRVNwoBl+GQIDA
         WP8Q==
X-Gm-Message-State: ALyK8tI7AZ3oXtvNnf7TzSmT0ow6nPVd0X+aBoP1uMWDFTOul5m3tKs19EVKCMW59NYexyD0EGtj9uWY/uEElg==
X-Received: by 10.28.98.215 with SMTP id w206mr13397801wmb.79.1464676894443;
 Mon, 30 May 2016 23:41:34 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 30 May 2016 23:41:34 -0700 (PDT)
In-Reply-To: <xmqqvb1u7okk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295959>

On Tue, May 31, 2016 at 8:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 25432d9..c4cc035 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -65,8 +65,14 @@ If `-N` is specified, removed paths are marked as intent-to-add (see
>  linkgit:git-add[1]).
>
>  --hard::
> -       Resets the index and working tree. Any changes to tracked files in the
> -       working tree since <commit> are discarded.
> +       Reset the index and the working tree to be identical to the
> +       tree of the given <commit> (defaults to HEAD) by discarding
> +       the changes made to them relative to <commit>.  Paths
> +       modified in the index and in the working tree are reset to
> +       what is recorded in <commit>.  Paths removed in the working
> +       tree and in the index are resurrected from <commit>.  Paths
> +       added to the index and the working tree since <commit> are
> +       removed.

This is a great improvement.

I am not sure that it will be enough to make people use `git stash`
and `git reset --keep` more though. But maybe that can wait until the
next time someone complain.

Thanks,
Christian.
