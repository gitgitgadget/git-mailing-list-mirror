Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3517CA77
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqHG8NOW"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700BDE
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 01:01:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so6952843a12.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698652884; x=1699257684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CQveAlOJsit102Xp3EaJhh3jE929QpUFJYj/5n9fWGY=;
        b=cqHG8NOW6aCY+1lE/anzEMTAGwFOa5hesqff+uaYb43slXzqiYaC95eVmpp6ZV6ye5
         FHXZxl0MUrQ+EWYquCAcj0C/UTzuk/j1CP6FdCpkOUhGiE38T1zIWJsH53Ri48ku30wH
         eelvDyBPzBgUDhMiBVdv+97hO0xncYYd497iekyQclXwACLe6ofUf19cWhJ+nQJEb5fn
         qFMov6wztlSl7JwwNylyZX6W5LKsh5m5BLBGvpK/Ydi+M6Bc3DXiXYh4oicm/TaiXm7d
         0jJ4+w2thlJdO8i9FSgTGTwJ03fNFfY8POxNlMFkkS8usV3ZSoBz4m+sp/7bhRPfHF7z
         hHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652884; x=1699257684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQveAlOJsit102Xp3EaJhh3jE929QpUFJYj/5n9fWGY=;
        b=RK5sVMVAJZGpx5ua+dSmzD4JkPDFUWfMejecFQz7GPbzyegixLUBmv2Ob52sc/yizY
         NwD0D7ktGFFX4ukVOzhzZ4W3GyiL87uEoG9eGNWkH8pyNxpJXswr2v+TOYbUIsVe3WWe
         TLfhG0Gv+sR1l5LJnPWz6BqKgg608L8KdHkIGGdyMpx8K5PE23tVeny9Kr94qNVG+HzV
         NqC6xacFYQ2pXXh/SaayBBPGJ2D7L5T1N1+58D3B6CBiNM2NO8Tg1DAhl3MnevMLGagR
         cZF2nK0/ZrB/gOpiS5yVDQpw6GbZBhjs3fPt2qol64A5R5H0kZhq3MU71Q893HIwcA09
         Hyfg==
X-Gm-Message-State: AOJu0Yycl6pcbOCmQ+4mjGUgOufyYivl82nZVW0p5IMwzAxlXILbszHo
	X8JieWTkHa66gqlwnHA0CpHIG5egHCXPttzdLtc=
X-Google-Smtp-Source: AGHT+IE4YwFt1wjxXpLLKPzqb7jYir4b3x4ZWoLQQrS0Xg+b2RrCzUATNXH6bLyVFvvEeirkZ+Fx6KBFkkUrDol8afs=
X-Received: by 2002:a05:6402:1a2e:b0:540:118:db2 with SMTP id
 be14-20020a0564021a2e00b0054001180db2mr7310476edb.16.1698652883702; Mon, 30
 Oct 2023 01:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1534.git.1684567247339.gitgitgadget@gmail.com> <CAGJzqskekExeug45Zh-uQ1dpHpKP8HS3obWQyz8B_DzSZiuAwA@mail.gmail.com>
In-Reply-To: <CAGJzqskekExeug45Zh-uQ1dpHpKP8HS3obWQyz8B_DzSZiuAwA@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 30 Oct 2023 09:00:00 +0100
Message-ID: <CAGJzqsnW7X44qeQzN_-2ckOaAjbAs3+mRh1XP+M0haYJ_om+EQ@mail.gmail.com>
Subject: Re: [PATCH] credential/wincred: store oauth_refresh_token
To: M Hickford <mirth.hickford@gmail.com>
Cc: git-for-windows@googlegroups.com, Taylor Blau <me@ttaylorr.com>, 
	Git Mailing List <git@vger.kernel.org>, Matthew John Cheetham <mjcheetham@outlook.com>, 
	=?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>, 
	patthoyts@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi. Is anyone with Windows development experience able to take a look
at this patch to credential-wincred?

https://lore.kernel.org/git/pull.1534.git.1684567247339.gitgitgadget@gmail.com/
https://github.com/gitgitgadget/git/pull/1534

On Thu, 10 Aug 2023 at 20:58, M Hickford <mirth.hickford@gmail.com> wrote:
>
> Hi. A small patch to git-credential-wincred needs review on the Git
> mailing list https://lore.kernel.org/git/pull.1534.git.1684567247339.gitgitgadget@gmail.com/
> . Does anyone here have the expertise to review?
>
> On Sat, 20 May 2023 at 08:20, M Hickford via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > a5c7656 (credential: new attribute oauth_refresh_token) introduced
> > a new confidential credential attribute for helpers to store.
> >
> > We encode the new attribute in the CredentialBlob, separated by
> > newline:
> >
> >     hunter2
> >     oauth_refresh_token=xyzzy
> >
> > This is extensible and backwards compatible. The credential protocol
> > already assumes that attribute values do not contain newlines.
> >
> > Alternatives considered: store oauth_refresh_token in a wincred
> > attribute. This would be insecure because wincred assumes attribute
> > values to be non-confidential.
> >
> > Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> > ---
> >     credential/wincred: store oauth_refresh_token
> >
> >     I'm not confident in C and found string manipulation difficult, so
> >     please review carefully.
> >
> >     I tested on Linux, cross compiling with Zig make CC="zig cc -target
> >     x86_64-windows-gnu" and tested make GIT_TEST_CREDENTIAL_HELPER=wincred
> >     t0303-credential-external.sh (with a shell script git-credential-wincred
> >     that wraps wine64 git-credential-wincred.exe "$@")
> >
> >     See also similar patch for credential-libsecret "[PATCH v4]
> >     credential/libsecret: store new attributes"
> >     https://lore.kernel.org/git/pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com/T/#u
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1534%2Fhickford%2Fwincred-refresh-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1534/hickford/wincred-refresh-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1534
> >
> >  .../wincred/git-credential-wincred.c          | 40 ++++++++++++++++---
> >  t/t0303-credential-external.sh                |  1 +
> >  2 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> > index 96f10613aee..dc34283b85e 100644
> > --- a/contrib/credential/wincred/git-credential-wincred.c
> > +++ b/contrib/credential/wincred/git-credential-wincred.c
> > @@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
> >  }
> >
> >  static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
> > -       *password_expiry_utc;
> > +       *password_expiry_utc, *oauth_refresh_token;
> >
> >  static void write_item(const char *what, LPCWSTR wbuf, int wlen)
> >  {
> > @@ -128,6 +128,11 @@ static void get_credential(void)
> >         DWORD num_creds;
> >         int i;
> >         CREDENTIAL_ATTRIBUTEW *attr;
> > +       WCHAR *secret;
> > +       WCHAR *line;
> > +       WCHAR *remaining_lines;
> > +       WCHAR *part;
> > +       WCHAR *remaining_parts;
> >
> >         if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
> >                 return;
> > @@ -137,9 +142,17 @@ static void get_credential(void)
> >                 if (match_cred(creds[i])) {
> >                         write_item("username", creds[i]->UserName,
> >                                 creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
> > -                       write_item("password",
> > -                               (LPCWSTR)creds[i]->CredentialBlob,
> > -                               creds[i]->CredentialBlobSize / sizeof(WCHAR));
> > +                       secret = xmalloc(creds[i]->CredentialBlobSize);
> > +                       wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
> > +                       line = wcstok_s(secret, L"\r\n", &remaining_lines);
> > +                       write_item("password", line, wcslen(line));
> > +                       while(line != NULL) {
> > +                               part = wcstok_s(line, L"=", &remaining_parts);
> > +                               if (!wcscmp(part, L"oauth_refresh_token")) {
> > +                                       write_item("oauth_refresh_token", remaining_parts, wcslen(remaining_parts));
> > +                               }
> > +                               line = wcstok_s(NULL, L"\r\n", &remaining_lines);
> > +                       }
> >                         for (int j = 0; j < creds[i]->AttributeCount; j++) {
> >                                 attr = creds[i]->Attributes + j;
> >                                 if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
> > @@ -148,6 +161,7 @@ static void get_credential(void)
> >                                         break;
> >                                 }
> >                         }
> > +                       free(secret);
> >                         break;
> >                 }
> >
> > @@ -158,16 +172,26 @@ static void store_credential(void)
> >  {
> >         CREDENTIALW cred;
> >         CREDENTIAL_ATTRIBUTEW expiry_attr;
> > +       WCHAR *secret;
> > +       int wlen;
> >
> >         if (!wusername || !password)
> >                 return;
> >
> > +       if (oauth_refresh_token) {
> > +               wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> > +               secret = xmalloc(sizeof(WCHAR) * wlen);
> > +               _snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> > +       } else {
> > +               secret = _wcsdup(password);
> > +       }
> > +
> >         cred.Flags = 0;
> >         cred.Type = CRED_TYPE_GENERIC;
> >         cred.TargetName = target;
> >         cred.Comment = L"saved by git-credential-wincred";
> > -       cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
> > -       cred.CredentialBlob = (LPVOID)password;
> > +       cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
> > +       cred.CredentialBlob = (LPVOID)_wcsdup(secret);
> >         cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
> >         cred.AttributeCount = 0;
> >         cred.Attributes = NULL;
> > @@ -182,6 +206,8 @@ static void store_credential(void)
> >         cred.TargetAlias = NULL;
> >         cred.UserName = wusername;
> >
> > +       free(secret);
> > +
> >         if (!CredWriteW(&cred, 0))
> >                 die("CredWrite failed");
> >  }
> > @@ -253,6 +279,8 @@ static void read_credential(void)
> >                         password = utf8_to_utf16_dup(v);
> >                 else if (!strcmp(buf, "password_expiry_utc"))
> >                         password_expiry_utc = utf8_to_utf16_dup(v);
> > +               else if (!strcmp(buf, "oauth_refresh_token"))
> > +                       oauth_refresh_token = utf8_to_utf16_dup(v);
> >                 /*
> >                  * Ignore other lines; we don't know what they mean, but
> >                  * this future-proofs us when later versions of git do
> > diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
> > index f028fd14182..51886b8e259 100755
> > --- a/t/t0303-credential-external.sh
> > +++ b/t/t0303-credential-external.sh
> > @@ -45,6 +45,7 @@ test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
> >  helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
> >
> >  helper_test "$GIT_TEST_CREDENTIAL_HELPER"
> > +helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
> >
> >  if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
> >         say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"
> >
> > base-commit: 9e49351c3060e1fa6e0d2de64505b7becf157f28
> > --
> > gitgitgadget
