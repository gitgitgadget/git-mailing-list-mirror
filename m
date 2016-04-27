From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] trailer: load config to handle core.commentChar
Date: Wed, 27 Apr 2016 22:13:09 +0200
Message-ID: <CAP8UFD1O+V64dr-j9bu7D1mrLxEy3zG017zdJahJTx-MUYv5Pg@mail.gmail.com>
References: <1461785062-23523-1-git-send-email-rafalklys@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Rafal Klys <rafalklys@wp.pl>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:13:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVpk-0005q0-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbcD0UNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:13:12 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35974 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbcD0UNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:13:11 -0400
Received: by mail-wm0-f44.google.com with SMTP id n129so41904142wmn.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZkfbJnEop0GMALuJ3al3SzFjJWkJPEt8cZPn1gGtfvk=;
        b=GUSwU62rEWPWcBohZ3mR57VERgBFBN7tVs+EBnSA/ouRlqHdYB6/keGIi2oOTkv3PG
         FyDxDz6dQ9mhtKHVTfSQwP4AvQ785bdTMZkRtNwD/5vHN/VwuHcrVgQFEfr/Ab7OIj9v
         oY/NLhO5IpFN3y8kA0u5UH41lAqQXPfKNLKnyWHKK7hUS+jOmZWuMo+HYkMHuNO6/2/M
         QjeOscMbGdqWQ/aUgmfL2LgGoEg9t/KXN6DMiqRoX2m1p7ZTN3kriO4XyynR9TRGnv6Q
         84Jz1nIK7KuPGxbcxjl6I/8sB4NA+vpoTTG7JG2Yn/2RFjAQHZOe1YpVEUTz5a5Fn3xP
         JqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZkfbJnEop0GMALuJ3al3SzFjJWkJPEt8cZPn1gGtfvk=;
        b=HjNAN3uUvXs8GVpNiCVXi//E8AQDxku7OV7NIdjIvrrKn4x2CgmWuPlo1DmjVSmWbf
         IZ0WBxV+se5+HPHYAmfye7gRJ80HTpOqWN9f0PVqzVp6AXfycg/TPHYryeEXFqTcedjp
         od09lF65TbyN82/SPgyxTkoQbTB3HCPDcYY5rs6lMZwSv506+h+YDFdYcbVMmYCcml57
         avKZcTMW0UeGiWa2GFNWjDzb70xyeEesV8S4gKgUAkaUKMwvbJ60Br+KDMM3/LUWaBUJ
         9Gpi3J+XW5LanLvVXoS2bCR7dAyoMflcq32Zbky+KE5OfDH9KcI3e2DC9xBxXwyNW5/1
         7TkA==
X-Gm-Message-State: AOPr4FXAmA5iAE0wS+gQK/ZuH+scTt9d3QNuT4140mx2QJjKPfAXTI3+oNydicrTqTve35zSiB00V1tU0kShrQ==
X-Received: by 10.195.17.166 with SMTP id gf6mr11192242wjd.124.1461787989358;
 Wed, 27 Apr 2016 13:13:09 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 13:13:09 -0700 (PDT)
In-Reply-To: <1461785062-23523-1-git-send-email-rafalklys@wp.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292811>

On Wed, Apr 27, 2016 at 9:24 PM, Rafal Klys <rafalklys@wp.pl> wrote:
> Add call to git_config(git_default_config, NULL) to update the
> comment_char_line from default '#' to possible different value set in
> core.commentChar.

It is "comment_line_char" not "comment_char_line", but otherwise you
can add "Reviewed-by: Christian Couder <chriscool@tuxfamily.org>".

Thanks!

> Signed-off-by: Rafal Klys <rafalklys@wp.pl>
> ---
>  trailer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/trailer.c b/trailer.c
> index 8e48a5c..a3700b4 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -888,6 +888,9 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>         git_config(git_trailer_default_config, NULL);
>         git_config(git_trailer_config, NULL);
>
> +       /* for core.commentChar */
> +       git_config(git_default_config, NULL);
> +
>         lines = read_input_file(file);
>
>         if (in_place)
> --
> 2.8.1.68.g625efa9.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
