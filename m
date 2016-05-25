From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t7800 test failure
Date: Wed, 25 May 2016 11:33:33 +0200
Message-ID: <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
	<xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
	<CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
	<xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 11:33:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5VCC-00081J-4L
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 11:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcEYJdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 05:33:35 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34499 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcEYJde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 05:33:34 -0400
Received: by mail-yw0-f174.google.com with SMTP id c127so41813390ywb.1
        for <git@vger.kernel.org>; Wed, 25 May 2016 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UIxBCY2mIdcbYSOzjlyxpvyL97HSRGL5Mbva1NU4pi8=;
        b=UcQ9LVrHH9+7H0zIam0QX3ZvWqFYLG0l9AH+JMcQOHQ6Ox283WwYXwjqq6JIX2yxTz
         pL19VhvXV5AySPwSQRnvhEsFpliQinoi5Q5syALyA1pInyMP1+S97AHYzK7cM4CG9vHb
         2CJopWWaY4bCljuaQUmsbbIK+us57ckP6ZOoK3POxpO89A82DmahfZ2czZYSLgzGwgQW
         ItxRiMStX65sIjIsfSivCLlG74yYpvRyA+J+yufX+L1emUI4dPpvGyUC19IK2YGcMK9g
         kBPlEfqY0p9sFD1RcNmlY3I8c+73lGM7FUoCFHarZDwOBMJEQZbMB2b9JaErcUBUx7wN
         sQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UIxBCY2mIdcbYSOzjlyxpvyL97HSRGL5Mbva1NU4pi8=;
        b=c7KwtM0FGzsFcQkk6+ZAhoRk28yHyuwMpVj3pNlkPok6BQfpCmrgvOYbap8GhY3dx+
         02z9d1eVPCdAObYryhzJtFfXlPW40FLTDEQm/YLd1lxNggUl27uVppiYMmEmX5PGk0zs
         r2jJ8MxFjkGsbKx/k988n994GVBjPo9wuo4JCUF0wMTK+aSpJyQ5Ys2mgi1CK6Yud86F
         Mi7Wm48T9BORGKQyy028wx0g6uindwMtl4w0VwpFzrCzuZ9g05OoHCRHq2/f6hTkGKeC
         9QW7CUF9c37ITJM0/DUN9DE498Jm3hUYoQIde0nFTmF9hbLuM9BS1VAPHz6EUwQVQs1W
         7HjA==
X-Gm-Message-State: ALyK8tIT++isExuP35XeOzWPb7SKIDEav/q9mH/QVbF/f50nTKlUUJIQOmH792Vrp7f5sbhJwmve47tIaM4ppw==
X-Received: by 10.13.202.151 with SMTP id m145mr1831838ywd.63.1464168813327;
 Wed, 25 May 2016 02:33:33 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Wed, 25 May 2016 02:33:33 -0700 (PDT)
In-Reply-To: <xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295570>

On Tue, May 24, 2016 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Armin Kunaschik <megabreit@googlemail.com> writes:
>>
>> Ok, how can this be implemented within the test environment?
>
> I actually think an unconditional check like this is sufficient.

Ah, good. My thoughts were a bit more complicated.
Anyway, this works for me.
Thanks!

>  t/t7800-difftool.sh | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 7ce4cd7..f304228 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -442,15 +442,16 @@ run_dir_diff_test 'difftool --dir-diff with unmerged files' '
>         test_cmp expect actual
>  '
>
> -write_script .git/CHECK_SYMLINKS <<\EOF
> -for f in file file2 sub/sub
> -do
> -       echo "$f"
> -       readlink "$2/$f"
> -done >actual
> -EOF
> -
>  test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
> +
> +       write_script .git/CHECK_SYMLINKS <<-\EOF &&
> +       for f in file file2 sub/sub
> +       do
> +               echo "$f"
> +               ls -ld "$2/$f" | sed -e "s/.* -> //"
> +       done >actual
> +       EOF
> +
>         cat >expect <<-EOF &&
>         file
>         $PWD/file
