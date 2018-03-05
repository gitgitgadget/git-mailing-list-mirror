Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782A71F404
	for <e@80x24.org>; Mon,  5 Mar 2018 01:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeCEBmi (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 20:42:38 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33231 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeCEBmh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 20:42:37 -0500
Received: by mail-qk0-f172.google.com with SMTP id f25so18848529qkm.0
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PCQKfs/kmEUbV2J077m5eEjsnUgPVz2kdS2qUVGLXdo=;
        b=ovx8E1BKfyxz8EZi56O1Zb/WHRnf8HcdijjyFqMwVVLQeDHC5mwHvgb3XeYS4tvhxi
         eahhP1yJcFddtoq1bRQXV9NFXCWsVEWU1woGCxnftJ7bCk0F/JxQm5T/SywAAvfEO67J
         Dki2k2pHmbVq4zKZ4UwXeAbazPoLVeDcRLp7/2SPsR+6RI3qAONVmYNXTh5WIJ2p6jm5
         khUrCkqnKJ5AXNp9+0p03fPk+EbJnnNhBqs3X7FLbOMkzLvhTLKbBqAAk5i50dE+IlAF
         Udfn9hlu0oXozzZW83SMn83xRmxa2yo9mc2e+/XuI3raVMwnFhyl0KMLPlGtXtDS8PdF
         MgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PCQKfs/kmEUbV2J077m5eEjsnUgPVz2kdS2qUVGLXdo=;
        b=mDmbhkjVDRl05BbD9MNaQLIGaF5kPn7bLPi6WsIiTjiZpq4GJu6sVVKV5ZertEdM/C
         dUdH4kWOqZtbHurdbPrpndnSJiJiVN1wtjrwtMbZpnJPmixgLhu5tVQt3dbX2V2/dzWv
         mBbQ0/bdKPcrxLCtWZUHhubBWdDLHnNKQ/4YAeMFjdzlSNu49Hu8N7QcSE1QqtGRDqF1
         Q4Ae4FLtjPLw0r8RGgnazuyxJMzoOI+25uliW831h/kVqINn2o/nbOpHvlQzNpimyKJ8
         Y8WLrsg8HklnkFfFJXhj5Fxq1TaNbiitfoehPutLdgcE+VCIYvQ1QtG/YUz4NnbZkJ8p
         asVg==
X-Gm-Message-State: AElRT7F1das+OOi8cxE8Tl2UGjbvA0qK8D0E6SHQOcTa852C/RVio5nK
        cuGGfxnq4jvQ0Y3M6CtkuyYnTLAleNlFWdkCvLokyw==
X-Google-Smtp-Source: AG47ELs0lRashNskD7akUzCqJ1azYfKt6u4LnFnISUNMHpMfRLurHX6x6PhRE5N5U5GCaY4650snztZqBrol+fAt8Jg=
X-Received: by 10.55.133.131 with SMTP id h125mr20338001qkd.79.1520214156413;
 Sun, 04 Mar 2018 17:42:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sun, 4 Mar 2018 17:42:35 -0800 (PST)
In-Reply-To: <20180304112237.19254-2-asheiduk@gmail.com>
References: <20180304112237.19254-1-asheiduk@gmail.com> <20180304112237.19254-2-asheiduk@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Mar 2018 20:42:35 -0500
X-Google-Sender-Auth: uAmupPEDuiLHn7qtN4PsDmckazg
Message-ID: <CAPig+cQTpbj6q_s_pX2HjmpYF4W+5wKH7YLQQdZTiMPfK4G2Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow empty email-address in authors-prog
 and authors-file
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 6:22 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> The email address in --authors-file and --authors-prog can be empty but
> git-svn translated it into a syntethic email address in the form
> $USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
> is explicitly set to the empty string, the commit does not contain
> an email address.

Falling back to "$name@$uuid" was clearly an intentional choice, so
this seems like a rather significant change of behavior. How likely is
it that users or scripts relying upon the existing behavior will break
with this change? If the likelihood is high, should this behavior be
opt-in?

Doesn't such a behavior change deserve being documented (and possibly tests)?

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> @@ -1482,7 +1482,6 @@ sub call_authors_prog {
>         }
>         if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
>                 my ($name, $email) = ($1, $2);
> -               $email = undef if length $2 == 0;
>                 return [$name, $email];

Mental note: existing behavior intentionally makes $email undefined if
not present in $author; revised behavior leaves it defined.

>         } else {
>                 die "Author: $orig_author: $::_authors_prog returned "
> @@ -2020,8 +2019,8 @@ sub make_log_entry {
>                 remove_username($full_url);
>                 $log_entry{metadata} = "$full_url\@$r $uuid";
>                 $log_entry{svm_revision} = $r;
> -               $email ||= "$author\@$uuid";
> -               $commit_email ||= "$author\@$uuid";
> +               $email //= "$author\@$uuid";
> +               $commit_email //= "$author\@$uuid";

With the revised behavior (above), $email is unconditionally defined,
so these //= expressions will _never_ assign "$author\@$uuid" to
$email. Am I reading that correctly? If so, then isn't this now just
dead code? Wouldn't it be clearer to remove these lines altogether?

I see from reading the code that there is a "if (!defined $email)"
earlier in the function which becomes misleading with this change. I'd
have expected the patch to modify that, as well.

Also, the Perl codebase in this project is still at 5.8, whereas the
// operator (and //=) didn't become available until Perl 5.10.
(However, there has lately been some talk[1] about bumping the minimum
Perl version to 5.10.)

[1]: https://public-inbox.org/git/20171223174400.26668-1-avarab@gmail.com/

>         } elsif ($self->use_svnsync_props) {
>                 my $full_url = canonicalize_url(
>                         add_path_to_url( $self->svnsync->{url}, $self->path )
> @@ -2029,15 +2028,15 @@ sub make_log_entry {
>                 remove_username($full_url);
>                 my $uuid = $self->svnsync->{uuid};
>                 $log_entry{metadata} = "$full_url\@$rev $uuid";
> -               $email ||= "$author\@$uuid";
> -               $commit_email ||= "$author\@$uuid";
> +               $email //= "$author\@$uuid";
> +               $commit_email //= "$author\@$uuid";
>         } else {
>                 my $url = $self->metadata_url;
>                 remove_username($url);
>                 my $uuid = $self->rewrite_uuid || $self->ra->get_uuid;
>                 $log_entry{metadata} = "$url\@$rev " . $uuid;
> -               $email ||= "$author\@" . $uuid;
> -               $commit_email ||= "$author\@" . $uuid;
> +               $email //= "$author\@" . $uuid;
> +               $commit_email //= "$author\@" . $uuid;
>         }
>         $log_entry{name} = $name;
>         $log_entry{email} = $email;
