Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D36B1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 20:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfGCUqH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 16:46:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37994 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfGCUqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 16:46:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so3368416edo.5
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z/xhRiOUmMswKQSis9zujMhSaxqnTUmKEPC1XoFcKWY=;
        b=Y73PS99FkOKAlAtfx9VSpOfsuk1f8zukNkFMdVG4zXeieH0qecsE0pvWTKK9Z6jl6k
         +ZUadDFQQhtJ8cssg0tEIEvvWqtwrT+EnoZ8lpuCEsQnrnLP4w/ElSgXWo43CPlsXE1g
         ok4kDr6YcTA2qdV4jH4B0LW6Zi5b5goFxju6U+gDM6p7GweoNYT+eMOZSAwlIM6oyFm9
         BUureoGGHAGJDtuzRr6GchyyRxGzgdVZgYwEl/1bFErjZVYeV+FtHjQzcBfrb6YlVTY0
         rot9NLkZbcDUnzQTOpZfHLCzF20UYjE0erwOAvOwJ/03sD9YUkStsNUCqkVON7Xu5llZ
         87Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z/xhRiOUmMswKQSis9zujMhSaxqnTUmKEPC1XoFcKWY=;
        b=rzU41aAfkjBrrLvWX2+1udXtdNatR2EewbC+zeSoIj5JXVa9JW1TUW6CfRBnqNrqiU
         PZK1kBqw7owci25+trNcfGtxpPQ+ZXKIrTeRUtLbmriD+pf6Ge8wb4qsD+fNi6D8Hp7n
         BgKa6rGuhmTRR16HANZ/MZEKCYW0ckY6BCRJ9APqG91OR7v4duVsT+rgdmBvrTICK9OW
         Hry7Ic+pw2rziI+m8cPmxfZyR9eUXJRj5z+MwN7gCfG1/FpCBzUfKgMONw3C8w3DQU46
         i8gSsNcXf8CzWAmQo0g04EX+NxvKA3Z/1xC2CMAn/8UihalpS+xHphFSB5fCOJvLFQyW
         sE9Q==
X-Gm-Message-State: APjAAAUoTEZKS4JeaRiAXW4/m9EkmjhL+NYBNKk9lx3QGVqlP0NV4KQr
        TujC6rRX4tugfBn7JZENhLI/9THM
X-Google-Smtp-Source: APXvYqwwg94ybBhIdveXSk89Qntk9LpcpZRx1VXtxSmaDGe5050OOlmiFlo5kHApS+laqVlUy4EaXA==
X-Received: by 2002:a17:906:1596:: with SMTP id k22mr37236759ejd.102.1562186763785;
        Wed, 03 Jul 2019 13:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d36sm1017784ede.23.2019.07.03.13.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:46:03 -0700 (PDT)
Date:   Wed, 03 Jul 2019 13:46:03 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Jul 2019 20:46:01 GMT
Message-Id: <pull.217.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.217.git.gitgitgadget@gmail.com>
References: <pull.217.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] gettext(windows): always use UTF-8
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main issue we work around here is that Windows does not have a UTF-8
"code page".

Side note: there is actually a code page for UTF-8: 65001 (see 
https://docs.microsoft.com/en-us/windows/desktop/Intl/code-page-identifiers
). However, when experimenting with it, we ran into a multitude of issues in
the Git for Windows project, ranging from various problems with Windows'
default console to miscounted file writes. While these issues may have been
mitigated in recent Windows 10 versions, older ones (in particular, Windows
7) still seem to have most of them, and Git for Windows specifically still
supports even Windows Vista. So from a practical point of view, there is no
UTF-8 code page.

Changes since v1:

 * The LC_ALL=C method used by ab/no-kwset to prevent Git from assuming
   UTF-8-encoded input is now supported.
 * The commit message was enhanced and revamped.

Karsten Blees (1):
  gettext: always use UTF-8 on native Windows

 gettext.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-217%2Fdscho%2Fgettext-force-utf-8-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-217/dscho/gettext-force-utf-8-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/217

Range-diff vs v1:

 1:  ff37a2646a ! 1:  2d2253faef gettext: always use UTF-8 on native Windows
     @@ -2,17 +2,34 @@
      
          gettext: always use UTF-8 on native Windows
      
     -    Git on native Windows exclusively uses UTF-8 for console output (both with
     -    MinTTY and native Console windows). Gettext uses setlocale() to determine
     -    the output encoding for translated text, however, MSVCRT's setlocale()
     -    doesn't support UTF-8. As a result, translated text is encoded in system
     -    encoding (GetAPC()), and non-ASCII chars are mangled in console output.
     +    On native Windows, Git exclusively uses UTF-8 for console output (both
     +    with MinTTY and native Win32 Console). Gettext uses `setlocale()` to
     +    determine the output encoding for translated text, however, MSVCRT's
     +    `setlocale()` does not support UTF-8. As a result, translated text is
     +    encoded in system encoding (as per `GetAPC()`), and non-ASCII chars are
     +    mangled in console output.
      
     -    Use gettext's bind_textdomain_codeset() to force the encoding to UTF-8 on
     -    native Windows.
     +    Side note: There is actually a code page for UTF-8: 65001. In practice,
     +    it does not work as expected at least on Windows 7, though, so we cannot
     +    use it in Git. Besides, if we overrode the code page, any process
     +    spawned from Git would inherit that code page (as opposed to the code
     +    page configured for the current user), which would quite possibly break
     +    e.g. diff or merge helpers. So we really cannot override the code page.
      
     -    In this developers' setup, HAVE_LIBCHARSET_H is apparently defined, but
     -    we *really* want to override the locale_charset() here.
     +    In `init_gettext_charset()`, Git calls gettext's
     +    `bind_textdomain_codeset()` with the character set obtained via
     +    `locale_charset()`; Let's override that latter function to force the
     +    encoding to UTF-8 on native Windows.
     +
     +    In Git for Windows' SDK, there is a `libcharset.h` and therefore we
     +    define `HAVE_LIBCHARSET_H` in the MINGW-specific section in
     +    `config.mak.uname`, therefore we need to add the override before that
     +    conditionally-compiled code block.
     +
     +    Rather than simply defining `locale_charset()` to return the string
     +    `"UTF-8"`, though, we are careful not to break `LC_ALL=C`: the
     +    `ab/no-kwset` patch series, for example, needs to have a way to prevent
     +    Git from expecting UTF-8-encoded input.
      
          Signed-off-by: Karsten Blees <blees@dcon.de>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -26,7 +43,23 @@
       #	include <libintl.h>
      -#	ifdef HAVE_LIBCHARSET_H
      +#	ifdef GIT_WINDOWS_NATIVE
     -+#		define locale_charset() "UTF-8"
     ++
     ++static const char *locale_charset(void)
     ++{
     ++	const char *env = getenv("LC_ALL"), *dot;
     ++
     ++	if (!env || !*env)
     ++		env = getenv("LC_CTYPE");
     ++	if (!env || !*env)
     ++		env = getenv("LANG");
     ++
     ++	if (!env)
     ++		return "UTF-8";
     ++
     ++	dot = strchr(env, '.');
     ++	return !dot ? env : dot + 1;
     ++}
     ++
      +#	elif defined HAVE_LIBCHARSET_H
       #		include <libcharset.h>
       #	else

-- 
gitgitgadget
