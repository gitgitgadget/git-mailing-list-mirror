Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C4C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F75820707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 12:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QNVHv2JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgAaMhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:37:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:35969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgAaMhs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 07:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580474266;
        bh=U35yCkoxPMWBbdKEhFw9s+BhXm6hhl+q0+4kaBCu71w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QNVHv2JG8sGFnu1sU5T2IsmVJ2A+lgh/V9sZwttmU7/co8EgTq/VdvQjzOfC5fBmJ
         nr1tHyxjO7x29ZhsWdP+1FtmFuODSeyeiz36MdnGAj6zppjjxAWWiJlh+4OJq0/Nov
         G+QLoNfhfirPjNKVnxi6G0vFussKq034sgEbua5E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1jNFOx0UTd-00ja8b; Fri, 31
 Jan 2020 13:37:46 +0100
Date:   Fri, 31 Jan 2020 13:37:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mike McGranahan <mike@mcgwiz.com>
cc:     git@vger.kernel.org
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
In-Reply-To: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001311304140.46@tvgsbejvaqbjf.bet>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TuXfHYAzbDHpvw7roiDZiWw6UPkZQrVpwUtOxN+7CPfvhtRVw8b
 Qd9UqS9DPynKko5rYwD4SK87OduchwpO5D2O4Ps2TP3sUBKubX+OMfQsN8MprRgJSfnCZMx
 vIloUyuPzA88Rp8WDS6GkBxJXciI2VfdymfFgviijGtwW2IM1d9mTg1sXW5fKLyxGpejT+M
 64LF8GnhIITIYboJgH3WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JzY9aQt9Rcs=:+zW7ZT83JVC9MbVowTjHgR
 bL6mGOSfPaI84EIby82EMWMQfYmKAyz6DoYFQjG/w06i4DXa0WV/YwJET+2ECd4FIM1cAxHhm
 I3e7CRoD9ATZFmhGCQGaGMvg69WqjzzIOTQwd4GdICa3tJKJZ6cP8yXDVhtw8LHNcIFQc223b
 wgTqulgDIs11TDAWoWAVk+178SS4kfioUGoueWMIx6HOi7bX1kKB0XWhrVVFZT2PX9dEEDgY9
 7swGlXvldARU4Gt6sHJC4rku/N46yOy/iCcOXtGLem7lkDogecIVHX++IUw+5xilDIa7EpYYH
 jrCBDE1mEo2O7MTpHA9UmeKxNLsKefnRh1vwqXFMOeCJzx6/r8OGsAvJHgxKKLtIqpBgjeuBL
 4LSW3xF5kNw8OC8Qe0HlVIPVTDpg9II/bGy5h8pUL8UKvAkpihXvdSV4vWHr06C1aupYx46JD
 ZHJmr1J6vrBZNYxiGhax33MLUPChSVBVxxsHDZHa3oOFRsJqPcON/UqUOMqjDKjX4XW8pchxl
 MRBMxoXOw0FJxjGU6YHisOflGJIJ/gOsP2+oywQP8cTsSWO2KThtiCOHQPRWteuj/JRllv25c
 yHfmqviz71OmPTKeJZsFea1neSKLeyS+OyhuNOohj61ZBdsXlRNqQ7ZOwcYDqM3tF7g3poyG8
 vY/034YSO2+oLqmHgH9heDeA3gqbcYwdFFKxv5d4ZuxP3tWNVSY/sfEfM3wPDmi2odbGcm35A
 dH4BgMtX/tNb3QHcU6tt6PIpn/rjQ0QZLu1jqUYIgCFj7zXcL4dBKjFMY9SGVH9N1cz6SAzQa
 FC+yoPpVTxyUOyYcFqLPTD+k/4pBJAUp3LVbTa8CO+nzx8EkuaKmhh37M7XHRphVlaXQDdv9L
 ExcxHMGnvY77WO6PNRuSrpvfinNyCXX4MV1OKljyT9p34PPjPCJADjSlCQ2zhBuVioH9VbkZU
 bsaWcfbN5OcQ6EwYgHyuhHnZSUCaElQuMDUZORR37Thm140+VLbxa4dUqm98uz12zIOWJnObl
 5Dn6XjCyJ3MiGUnrPX1W0SabWvZLu7Luo3KGbbvB05YGZ1HM4gu71dqKn1m9ilTIiv83w5cY2
 XcmuYF0bBDRU8r6YIywqWLs1XWR44PlpPzpZcAvfJwa6wa1toWhkij80ZVC0vK4g2yqZYRb6F
 v39NWPLSLJ/tYcUWBL8VAq0DJTwPgtyhmBDediIr5FQ2kdM2SR1VmerdrB1iGYDn30+60geJE
 2BKTlHNSjiEscfKkV
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

On Thu, 30 Jan 2020, Mike McGranahan wrote:

> I'm using version 2.25.0.windows.1. If I set config "wsErrorHighlight"
> to "old", and run `git diff -p`, the resulting patch text highlights
> whitespace differences in the old text.
>
> If I then run git-add in interactive patch mode, I expect the diff to
> include the whitespace highlights. But actually, it does not.
>
> Is this a bug? Thanks for your help.

Well, let's first try to get a preciser report, to make sure that we're on
the same page. These are the commands I ran:

	mkdir add-p-ws-error
	cd add-p-ws-error
	git init
	git config diff.wsErrorHighlight old
	echo "hello " >README
	git add README
	echo hello >README
	git -c add.interactive.usebuiltin=3Dtrue add -p
	git -c add.interactive.usebuiltin=3Dfalse add -p

In both `git add -p` invocations, I see the diff colored, and neither of
them shows the red square after the removed "hello" that `git diff shows.

So this is not a change of behavior in the conversion from a Perl script
to a built-in.

Investigating further, running with `GIT_TRACE=3D1` reveals that `add -p`
internally calls `git diff-files --color -p --`. If you run that command
manually, you will see that it indeed seems to ignore the
`diff.wsErrorHighlight` setting.

The actual code running `git diff-files` is here:
https://github.com/git-for-windows/git/blob/v2.25.0.windows.1/add-patch.c#=
L373-L436

I think it is correct to call the low-level `diff-files` here rather than
the high-level `diff` that is intended for human consumption.

Looking at the code in
https://github.com/git/git/blob/v2.25.0/builtin/diff-files.c#L28, I
believe that we found the reason why `git diff-files --color` ignores the
`wsErrorHighlight` setting.

Now, the documentation at
https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffwsErr=
orHighlight
and even at
https://git-scm.com/docs/git-diff-files#Documentation/git-diff-files.txt--=
-ws-error-highlightltkindgt
make it appear as if the code is not following the original intention.

If my reading is correct, and we want `git diff-files --color` to respect
the `diff.wsErrorHighlight` setting, then this patch fixes that:

=2D- snip --
diff --git a/diff.c b/diff.c
index 8e2914c0312..63afb8638c8 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -414,14 +414,6 @@ int git_diff_ui_config(const char *var, const char *v=
alue, void *cb)
 		return 0;
 	}

-	if (!strcmp(var, "diff.wserrorhighlight")) {
-		int val =3D parse_ws_error_highlight(value);
-		if (val < 0)
-			return -1;
-		ws_error_highlight_default =3D val;
-		return 0;
-	}
-
 	if (git_color_config(var, value, cb) < 0)
 		return -1;

@@ -469,6 +461,14 @@ int git_diff_basic_config(const char *var, const char=
 *value, void *cb)
 		return 0;
 	}

+	if (!strcmp(var, "diff.wserrorhighlight")) {
+		int val =3D parse_ws_error_highlight(value);
+		if (val < 0)
+			return -1;
+		ws_error_highlight_default =3D val;
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;

=2D- snap --

The bigger question is whether other core developers agree with this? And
what other `diff.*` settings should be respected by `git diff-files` (and
of course, `git diff-index`)?

Ciao,
Johannes
