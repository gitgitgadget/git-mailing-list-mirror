Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D091F954
	for <e@80x24.org>; Thu, 23 Aug 2018 11:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeHWOyU (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 10:54:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37644 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeHWOyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 10:54:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id x83-v6so1812105ywd.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xymt0N5Lcvz1O4SbxmH3PUq5kFhGaaSmbQ8q1MGa4t8=;
        b=CcSFJpYyR7DLNt89wvnJX3nYLdU0CEvqsdKuu/OQPBgYGKmQFzGEg8dxSeM5wsdTO6
         2UlTnIP+AjyVI7fjIe5oeWgIt6FusSyeGpllXWGENefxNQjga/GjKg+6AGEa7N+sWzK3
         d3Xr1YDOiV1eWbBXMXVPDdFciO0hIJN9NDdzAxLK5ylHwymBEf5/mRgrTjOP67Q3jORM
         jVTukczGCS1A8v9HUDB1vZ4kNkkvzHzOK1WqPs5MCFyB6iSFixdjlEZevFRuA5QPIzCh
         PtpGja3moRuQJ8AXzbK5EGsPu5+dTvTAVR9lbuo5G0z2eR/QIAC1AjpeMRxG2KEXrPcY
         xbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xymt0N5Lcvz1O4SbxmH3PUq5kFhGaaSmbQ8q1MGa4t8=;
        b=c9qIfBX/Hw5Xcy/6DJlSWPtETP8mZ+H/Bvg0LPxcCYluAnbm9CKfgdhsBY3c9d3uko
         BnxQccdiW7xlEhOnNYHKSaw8/b4Au2pjbXql88bduwsoEL92FbRrVArRlqS9hu/mDw5J
         zO01+rhiFTUuNXX7w6zBm2bbD6JxVxzNcRK2pNudcyeVC+0WX2QpWuGs9HppqfPknPZt
         l6qwRVyQzrobl4ftv9oqECQvOBWV8oEicLzULuy2POtNJvlR4vN6DrlFX4tWxw1CtnOf
         U/vF3jmwSV0iWbRLto8IzVsxzfttmxqfNlsAY1m4tbExfFouahufKIkYHzibg+ty9o6s
         6xvg==
X-Gm-Message-State: APzg51BdOum2iknmsVXIEGkFecWQXnDWc/5IA0UO01+XVQHM4UqlGM7R
        aBhSXUWY9k8JWy6LRtWMlsZ0lVmk/L7hQNnCFZUJmyHB
X-Google-Smtp-Source: ANB0VdY9f4qrEa6lQpnH3DhwbAfnTHX7R7CWrjlLP7hy2xurTLHb26jyvtraIX70wu343IhY05ZDTy5J/QaD7EGm9p0=
X-Received: by 2002:a81:7d46:: with SMTP id y67-v6mr2421068ywc.457.1535023503492;
 Thu, 23 Aug 2018 04:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANri+EzXBxEf7XtjnJONAYD4h_woqw06-4mcWCH6xODNMMp26w@mail.gmail.com>
 <CACBZZX6F1ez-yfnc3asPXBkBd9VKCjS7paN5ZsWVnpn=QUyGew@mail.gmail.com>
In-Reply-To: <CACBZZX6F1ez-yfnc3asPXBkBd9VKCjS7paN5ZsWVnpn=QUyGew@mail.gmail.com>
From:   Timothee Cour <timothee.cour2@gmail.com>
Date:   Thu, 23 Aug 2018 04:24:37 -0700
Message-ID: <CANri+ExMY9G9aSm2TumHd8a9p2ZVXqcBOV-H=7P-_Xh_ng=Cpg@mail.gmail.com>
Subject: Re: [feature] how to output absolute paths in git diff? => --show-abs-path
To:     avarab@gmail.com
Cc:     Timothee Cour <timothee.cour2@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Wanting such a feature seems sensible

happy to hear that!

> So this seems to work for --no-index, or if it doesn't what situations do=
esn't it work in?

cases where path arguments are already absolute (as I showed earlier)


> Is this a mistake, or would you only like --show-abs-paths to implicitly =
supply --src-prefix, but not --dst-prefix? If so, why?

notice I didn't use `--show-abs-paths` in that example; I'm showing
what `git diff` currently outputs (the `could show` meant depending on
your use case; eg when `get_file1` returns an absolute path and
`get_file2` returns a relative one)

> Ah, so it's about supplying both the prefix *and* absolute paths, whereas=
 I see without --no-index we seem to handle this sort of thing just fine:

indeed, without `--no-index` things work just fine as I noted in
https://stackoverflow.com/questions/22698505/how-to-show-full-paths-in-git-=
diff.
The problem is with `--no-index`
I tried messing around with `--src-prefix` and `--dst-prefix` to
remedy this but as I showed, it can't work currently.

> without --no-index we seem to handle this sort of thing just fine:

you also need `--relative` in case you're not at repo root in your
snippet (that' what I'm using, without `--no-index`)


> This is because the default prefixes are a/ and b/, respectively

that seems buggy:
with default options I get:
--- a/Users/timothee/help0.txt
+++ b/help1.txt

with `--src-prefix=3DFOO ` and `--dst-prefix=3DFOO ` I get:
--- FOOUsers/timothee/help0.txt
+++ FOOhelp1.txt

this seems buggy because there's not good option for FOO:
when FOO =3D /, relative paths become a broken absolute path (/help1.txt)
when FOO =3D ./, absolute paths become a broken relative path
(./Users/timothee/help0.txt)

I propose instead to show:
with `--src-prefix=3DFOO ` and `--dst-prefix=3DFOO ` I get:
--- join(FOO,path1)
+++ join(FOO,path2)

where join(prefix, path) simply appends prefix to path, taking care of
avoiding a double `//` in case prefix ends in / and path starts with
/,

that way, the defauls (with a/, b/) are unchanged and we can have:
with `--src-prefix=3D` and `--dst-prefix=3D` (empty FOO):
--- /Users/timothee/help0.txt
+++ help1.txt
=3D> the paths are not broken

## summary:

* `--show-abs-paths` would be useful
* `--src-prefix=3DFOO ` and `--dst-prefix=3DFOO ` could use join(FOO,path)
instead of the currently used join(FOO,path1.removeLeadingSlash)
On Thu, Aug 23, 2018 at 2:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Aug 23, 2018 at 11:16 AM Timothee Cour <thelastmammoth@gmail.com>=
 wrote:
> >
> > This has all the context:
> > https://stackoverflow.com/questions/22698505/how-to-show-full-paths-in-=
git-diff
>
> It's helpful to copy it anyway, so we can discuss it here:
>
> QUOTE
>
> How do I show full paths in git diff? One can use '--dst-prefix=3D$PWD'
> and '--src-prefix=3D$PWD' but this is fragile as it won't work in many
> cases, eg with --no-index, or when running the commond from a
> subdirectory without using --relative=3Drealpath_to_cwd
>
> END QUOTE
>
> Wanting such a feature seems sensible. But I'm unclear on the details.
>
> You say that --{src,dst}-prefix is fragile and doesn't work for
> --no-index. But if I do this:
>
>     (
>     cd /tmp &&
>     echo foo >a &&
>     echo bar >b &&
>     git --no-pager diff --src-prefix=3D$PWD/ --dst-prefix=3D$PWD/ a b
>     )
>
> I get this diff:
>
>     diff --git /tmp/a /tmp/b
>     new file mode 100644
>     index 257cc56..5716ca5 100644
>     --- /tmp/a
>     +++ /tmp/b
>     @@ -1 +1 @@
>     -foo
>     +bar
>
> So this seems to work for --no-index, or if it doesn't what situations
> doesn't it work in?
>
> > I'd like `--show-abs-path` to show absolute paths in:
> > git diff --show-abs-path args...
> >
> > eg:
> > git diff --no-index `get_file1` `get_file2`
> > could show:
> > --- a/Users/timothee/temp/ripgrep/help0.txt
> > +++ b/help1.txt
>
> Is this a mistake, or would you only like --show-abs-paths to
> implicitly supply --src-prefix, but not --dst-prefix? If so, why?
>
> > * passing '--dst-prefix=3D$PWD' and '--src-prefix=3D$PWD' doesn't help
> > because path arguments could be absolute, so it'll create
> > $PWD/Users/timothee/temp/ripgrep/help0.txt (wrong)
>
> Ah, so it's about supplying both the prefix *and* absolute paths,
> whereas I see without --no-index we seem to handle this sort of thing
> just fine:
>
>     git diff --src-prefix=3D$PWD/ --dst-prefix=3D$PWD HEAD~.. $PWD/some-f=
ile
>
> > * passing '--dst-prefix=3D.' will behave weirdly, replacing leading `/`
> > by `.` (seems wrong)
> > diff --git .Users/timothee/temp/ripgrep/help0.txt b/help1.txt
>
> This is because the default prefixes are a/ and b/, respectively, and
> the option allows you to entirely replace them. E.g. imagine needing
> "../some-relative-path/"
>
> > NOTE: I'm invoking the `git diff` command via a more complicated case
> > (with multiple arguments including git diff flags and git diff files),
> > so it's awkward for me to parse which arguments correspond to a file
> > vs a flag (ie prevents easily converting input file arguments to
> > absolute paths), but `git` could do it easily via a flag, eg
> > `--show-abs-path`
