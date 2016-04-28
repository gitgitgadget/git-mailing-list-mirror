From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] trailer: load config to handle core.commentChar
Date: Thu, 28 Apr 2016 17:12:16 -0400
Message-ID: <CAPig+cT=Ca+Jd_SN_SM=iOmLnYtAt82dW7ammW4-AKdRReFfPA@mail.gmail.com>
References: <1461873658-11394-1-git-send-email-rafalklys@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Rafal Klys <rafalklys@wp.pl>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:12:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avtEZ-00027a-De
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbcD1VMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:12:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35829 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbcD1VMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:12:17 -0400
Received: by mail-io0-f193.google.com with SMTP id u185so15189588iod.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CWisgQZZA4OyEUrhJZX89s+O9VuIKJjrMAHgnxcNtTc=;
        b=VSZZYwV6XRoW4ryV82JkLln/IZjNLviS5uMxa5Kv1OEW0ICpqtNfqozPWh808KP/XA
         7mrp3QQnP6+f1z75RkxSBznr3uqlPTEBW3HGsweAYBdt2M06eGOIJm2MkX3CaWj9So2v
         bf3E7ziDLwowc0kZviu+4y8m9K6/+NpMHcRi29K9lWpWkQx/YocU6sT51SA1wf7CaAZ7
         vvasKUwyMRwUlhSaMnsASq5CaDhzdvciRnTP6xYPsS8yzLIshDh0xavnrc6Y5/TCyYWP
         Gs5lL1NrzJ9c2/Nt4GMcN4N92QgUWhCHwIaN9PrJaesU9/zP6hmzMltGxtKuNC7KpkZ8
         poMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CWisgQZZA4OyEUrhJZX89s+O9VuIKJjrMAHgnxcNtTc=;
        b=GuTBQztUQSz0An+3iKVzCdzj97Hz0dkULTHjvR3oMk+jvnj4seZDUnASKn/rMSx4Nb
         zAH3gp0Dz7pBaIh9CI13Ld+hTTaoMPTOCdjmMwKcWWi+HnukrVGaBWqUYVXWwi0DuXNt
         IjficNWJIvvwyXPiyTHzDn1kxccT/dsvUxUvaGSX8a4haImSwxYFQODgMWimGiyojC+p
         cTzRF+ON39Xsq3afyuD+8Icl9ybBC5pmKY1fsWMt15iAGa3+0eATHBuA5CEH1qEE4iMr
         EDK36HJnhaPtMq41DM5K0ZbnC+FqcaZwgOpXr/JrGISVZKIghpaAqcoJ1P1+6Cis5oe5
         HeGw==
X-Gm-Message-State: AOPr4FVqRQrqLrG62t1HNoY/HCDc71PAitqEHQ2lbg82GeCgDUy+pOobaspF0dZCHafrE0vweCOxv/sj37VZ4g==
X-Received: by 10.107.47.37 with SMTP id j37mr19539757ioo.168.1461877936155;
 Thu, 28 Apr 2016 14:12:16 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 28 Apr 2016 14:12:16 -0700 (PDT)
In-Reply-To: <1461873658-11394-1-git-send-email-rafalklys@wp.pl>
X-Google-Sender-Auth: zniudKYjFnP9ZM1V6eh3Q_hHu-U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292955>

On Thu, Apr 28, 2016 at 4:00 PM, Rafal Klys <rafalklys@wp.pl> wrote:
> trailer: load config to handle core.commentChar

This subject is describing low-level details of the patch rather than
giving a high-level overview. A possible rewrite might be:

    trailer: respect core.commentChar

> Fall throught git_default_config when reading config to update the
> comment_line_char from default '#' to possible different value set in
> core.commentChar.

Similarly, this text is pretty much repeating what the patch itself
already states more concisely. Instead, you'd probably want to say
here what problem the patch is solving, and give an explanation of the
fix. For example:

    git-trailer fails to respect core.commentChar. Fix this oversight
    by invoking git_default_config() which loads core.commentChar.

In fact, this is such a simple fix that the subject suggested above
may itself be a sufficient commit message; any extra text might just
be noise since the patch itself contains enough information to
understand the problem and the fix.

By the way, the above minor comments are probably not worth a re-roll.
See below for a few more...

> Signed-off-by: Rafal Klys <rafalklys@wp.pl>
> ---
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> +test_expect_success 'with message that has comments using non-default core.commentChar' '
> +       git config core.commentChar x &&
> +       test_when_finished "git config --unset core.commentChar" &&

The above two lines could be collapsed to:

    test_config core.commentChar x &&

> +       cat basic_message >message_with_comments &&
> +       sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
> +               x comment
> +
> +               x other comment
> +               Cc: Z
> +               x yet another comment
> +               Reviewed-by: Johan
> +               Reviewed-by: Z
> +               x last comment
> +
> +       EOF
> +       cat basic_patch >>message_with_comments &&
> +       cat basic_message >expected &&
> +       cat >>expected <<-\EOF &&
> +               x comment
> +
> +               Reviewed-by: Johan
> +               Cc: Peff
> +               x last comment
> +
> +       EOF
> +       cat basic_patch >>expected &&
> +       git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
> +       test_cmp expected actual
> +'

As this new test is effectively a copy of the preceding test, another
option would be to factor out the common code. For instance:

    test_comment () {
        cat basic_message >message_with_comments &&
        sed -e "s/ Z\$/ /" >>message_with_comments <<-EOF &&
            $1 comment
        ...
    }

    test_expect_success 'with message that has comments' '
        test_comment '#'
    '

    test_expect_success 'with message that has custom comment char' '
        test_config core.commentChar x &&
        test_comment x
    '

Note that the backslash is dropped from -\EOF so that $1 can be
interpolated into the here-doc.

Such a re-factoring would be done as a preparatory patch, thus making
this a two-patch series, however, it's probably not worth it for only
two tests sharing common code. (Although, the following test is also
nearly identical...)

> diff --git a/trailer.c b/trailer.c
> @@ -483,7 +483,8 @@ static int git_trailer_default_config(const char *conf_key, const char *value, v
>         const char *trailer_item, *variable_name;
>
>         if (!skip_prefix(conf_key, "trailer.", &trailer_item))
> -               return 0;
> +               /* for core.commentChar */
> +               return git_default_config(conf_key, value, cb);

I'm a bit torn about this comment. On the one hand, it does add a bit
of value since it's not obvious at a glance what config from the
default set is needed by git-trailer, however, if git-trailer someday
takes advantage of some additional config from the default set, then
this comment will likely become outdated.

If I was authoring the patch, I'd probably omit the comment. Someone
wanting to know the reason for this invocation can always consult the
commit message (which does explain its purpose).

>         variable_name = strrchr(trailer_item, '.');
>         if (!variable_name) {
> --
