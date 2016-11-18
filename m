Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26C61FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbcKRUGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 15:06:05 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38749 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbcKRUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 15:06:04 -0500
Received: by mail-wm0-f48.google.com with SMTP id f82so59081172wmf.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SsK5wHQE4vAkqNPbNcYDwK/B6GOM33NRNcu9dcswiEM=;
        b=ISVtB7df82LCL9In25hmm2F7EHly/WDcjtbOcxGVtfxDwtFDmj2lcCZ6vVVDA2ifu8
         ZUCLQQDvGRMlNzgyM357hyGB38tAJqAM4HHBAYJh9wMGB35RMM19ShC/Q0wE/ny9FMwp
         eeEAEzD6f2W7fmmhAbRujpCAZEy9QLpsZg9zjlchVAnLlTEELO6XoPwkodxUZAofFUts
         AqI2SGT16MsLiDsUWfi4he7EpRJIQC/Y0RcQ8pIrTzCuQOkrB4JediR4mgaNa75wuupm
         yDHEXgu00jXqLAO2xnsuefSQP9Q2HLKWsXePxb6U9ubVblzhaR/hmTWjj5aPjq9TNci7
         hkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SsK5wHQE4vAkqNPbNcYDwK/B6GOM33NRNcu9dcswiEM=;
        b=fXcGsbkVe3te7OID8krfE/dxEpTfb3LldSkFe3kFmxOmNDcf/8WqgUaDHa9Br1E8ZK
         qGAYIbJK1ZzYWAGXMDY8HZTeZkDVX7s2l663RgFUvGCoRnC3uOkv5hMOBzSeqVd4FJi9
         KSMinM+Cj16x3PhbjTGmayJQW9XFuMypGCxS4ODF9/ZBbFZD3cPtmAPHWJ5VjOqy5Fjz
         aLKh3HF24BNvWCE4qY6pAXAmmC0yDlq+hRIEnWjfyBWBgRInbLrODKy0VSfxBoX7m4Tr
         6N3Qj+TcCwcQ6FUUdTYm2rpdP5Ho5JrDM+RHIzlhC2cXbAbToGG8AuXILkj2Ii5yNUYz
         3DwA==
X-Gm-Message-State: AKaTC02nc+UT5QlTrBWbNI1Xgw5fp9UC0FPP3LdlU5zVizCLHciQvYNnx2e4L4zKaKsTxtcKQym1fFUcCdKKuA==
X-Received: by 10.25.150.148 with SMTP id y142mr342296lfd.37.1479499562725;
 Fri, 18 Nov 2016 12:06:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.33.129 with HTTP; Fri, 18 Nov 2016 12:06:02 -0800 (PST)
In-Reply-To: <20161115182632.GA17539@gmail.com>
References: <13c9b4a74d82a1f0ed3f626406a43e92@rapsys.eu> <20161115182632.GA17539@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 18 Nov 2016 21:06:02 +0100
Message-ID: <CAN0XMOLwZ9mpnCwO1JWMSYb42SU_T--fZ=aH+M0j8wfp15EGcw@mail.gmail.com>
Subject: Re: gitweb html validation
To:     =?UTF-8?Q?Rapha=C3=ABl_Gertz?= <mageia@rapsys.eu>,
        Junio C Hamano <gitster@pobox.com>, jnareb@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-11-15 19:26 GMT+01:00 Ralf Thielow <ralf.thielow@gmail.com>:

Finally I've found the time to actually try this out and there
are some problems with it.

>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7cf68f07b..33d7c154f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5531,8 +5531,8 @@ sub git_project_search_form {
>                 $limit = " in '$project_filter/'";
>         }
>
> -       print "<div class=\"projsearch\">\n";
>         print $cgi->start_form(-method => 'get', -action => $my_uri) .
> +             "<div class=\"projsearch\">\n" .
>               $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
>         print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
>                 if (defined $project_filter);
> @@ -5544,11 +5544,11 @@ sub git_project_search_form {
>                              -checked => $search_use_regexp) .
>               "</span>\n" .
>               $cgi->submit(-name => 'btnS', -value => 'Search') .
> -             $cgi->end_form() . "\n" .
>               $cgi->a({-href => href(project => undef, searchtext => undef,
>                                      project_filter => $project_filter)},
>                       esc_html("List all projects$limit")) . "<br />\n";
> -       print "</div>\n";
> +       print "</div>\n" .
> +             $cgi->end_form() . "\n";
>  }
>

The anchor is now inside the form-tag, which means there is no
visual line-break anymore that comes automatically after </form>
as the form-tag is a block level element.  Could be solved by adding a
"<br />", which is not very nice, but OK.

>  # entry for given @keys needs filling if at least one of keys in list
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 321260103..507740b6a 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -539,7 +539,7 @@ div.projsearch {
>         margin: 20px 0px;
>  }
>
> -div.projsearch form {
> +form div.projsearch {
>         margin-bottom: 2px;
>  }
>

This is wrong as it overwrites the setting above, 20px at the bottom
went to 2px.

The problem is how to apply the 2px now. Before this, we had the
<form>, a block element, which we can give the 2px margin at the
bottom.  Now this element is gone and we have a set of inline
elements where we use "<br />" to emulate the line break.  There
are two css rules which can solve this, but I'm not really happy with
both of them.
1) As we know we need the two pixel below an input element, we
can say
div.projsearch input {
  margin-bottom: 2px;
}
2) Make the a-Tag inside div.projsearch being displayed as a block
element to make a margin-top setting working.  This has the benefit
that we don't care about the element above.
div.projsearch a {
        display: inline-block;
        margin-top: 2px;
}
If I have to choose I'd prefer the second one.

So I can't think of a way to solve this nicely with this change.
