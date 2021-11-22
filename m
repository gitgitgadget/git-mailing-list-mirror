Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1525C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhKVWbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:31:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:43393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhKVWbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637620104;
        bh=InjyHJ88R/dqAtGicCgJfffiBjchD6KwCeQXGxHGcWY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Izo9QpnqUaKRkS92mXdDE65du4Gp8ry3GKpe19ohADzsV7GODdzmXXAMlfxSZ1SEv
         2O4HlQg3+CDQx75zKOrwmdVXBTe0c5WKkvzS/UbWd1A4GqnDXf4ZV2al+3OOUVGIJ/
         Vc3+hhmxYTWbdyjY554v7NyVrWsf02DWB5UNBHxY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1mpYmP2PqL-000ObV; Mon, 22
 Nov 2021 23:28:24 +0100
Date:   Mon, 22 Nov 2021 23:28:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: preparing for 2.34.1
In-Reply-To: <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet>
References: <xmqqr1b8gkhg.fsf@gitster.g> <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MVquk4aLMhaLJlfsZjWbQ+HzECE0A8qKYFzZshDGhJ5WxeAquGr
 NKbCJ/5fiaQIh3xLeejtI4D0onITMRidGq3n45RPsDKAmxjJ1PBc0ddgGWPP27NzhzRPCsY
 vrxhxhDZtNklgikDK2MN6XxbdmvXnv1CgHtz4ow5tsrF39GV/UoYZFMr/e0nZYooY1rUPmH
 B2BdoG4Ipl7n67qzhGiYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FGwiVzIEhXE=:YntqFLD2m10vEprsajfUIL
 B3hiLwlFWEEr/cUmHVUXn4TnZhfU72MRWdhy1QcP4OZtEhZ7m5SYPOIHNYzjC6Sn274hwoFLK
 OBXq0HDAzqmcuNYZUBhoBt04de3hrQkkNkEhFJe5p8rgR8PxhD1yDQF8Btr/2p4g97JRau0pV
 K0UN7mlXtX2VFbkCF+M9ZZTXuB6ioAec2LZqAUio6xZ5LzxeQx+sh4HLVKSeN37lQBgPBfZVM
 nKJJaCsIBfasjwVHVynWWeeFq0xR6kYmpZw6ffq614Y4lgiqlo+oe4blAu6vcRBRhBhpxorIo
 BxrnHnXn9bw5QRtsudDy1IZHlj4cBtUvf8RYUYgwpzGOSO7EE/PtenVAxcUNNf1WZTiUCHPib
 GdolIjiCfsXzph5oB0VPD2+E8nUMUEIeObAzT7uE85KGfupNam12HOnLzWBPY01nRfjaRtW+a
 au1HIeiB+qSDDl4EnPOSo/YcDLWlSxYnuFGngpJn9VvnncEZd91u9NRndxWWrSS23ic1xtgdc
 iect0dRtdWCvq5YFrCEeDwmWMjcJSKVuUpPha6oatwsgD2AVJaPpOeN+gEJsBM0I7y118qSen
 8LoJl8APAUD2tHi6AC/016sn0ZJ60H59dZrPzaHWm9xIDfL1JglMqZYyGjnWFJs3HARrGAwM2
 Oo+l3DkN2iKrqm17gxv68xreMIlRExMuNxKXSmRq7diqeyDAM2IlON2ljR4LdDKoVEYO+g+4M
 pu1Gd0qiscpLPgILOcg2iJ/geU1FWeCGSLwikA9Qhcu6F7lqICW50PeyIWCVEbzr5i7Y3/Jtd
 hsRVZlzZf+w8tscaU3tYdlbGOvX2905q7hLpQe08GuARjyjcaIzu2ZVhTn7X/8lxQT8TBdSCY
 LbyC5SC+11qpU3BpSRCF7yQykTHqNA6TXjGyXWSggNX6O8QZ+bTE4qp6PSn8AR8bZfH/5p1d7
 lDRGRo+GDp5Z7Ke8Iu+z5qiT/zWhMyViVypXpxULwPC9k+s0HXR2yXd49JU8sqzfG9md/eC4A
 /Z1YSMGxGPzErkEmKe8IiRepHQowNBK80O91j9/lOdXJf+yZej3egjXKQcy8f1Vmu1dDmnQoK
 QYuTNqixTlEYiU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Mon, 22 Nov 2021, Carlo Arenas wrote:

> On Mon, Nov 22, 2021 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >
> > There are a few topics [*] to fix regressions introduced in the
> > previous cycle
>
> There was another regression report[1] that I just fished out of my
> spam folder and that I introduced in 3d411afabc (editor: save and
> reset terminal after calling EDITOR, 2021-10-05), but that I have not
> yet produced a fix for or fully understood.
>
> The gist is that some people seem to be using a hack[2] dscho posted a

You mean

https://lore.kernel.org/git/nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqb=
jf.bet/

right? I.e. figuring out what Git considers its system config location via

	GIT_EDITOR=3Decho git config --system -e 2>/dev/null

> few years ago to get info from git programmatically and I just didn't
> expect someone would try to invoke the EDITOR unless they had a
> terminal, so the fix might be to just add an isatty(0) call, but
> reverting that commit would be also an option.

The quickest workaround for this is probably to special-case the editor
`echo`:

=2D- snip --
diff --git a/editor.c b/editor.c
index 674309eed8bd..1b97f7da9920 100644
=2D-- a/editor.c
+++ b/editor.c
@@ -51,12 +51,11 @@ const char *git_sequence_editor(void)
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
-	int term_fail;
-
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");

 	if (strcmp(editor, ":")) {
+		int save_and_restore_term =3D strcmp(editor, "echo");
 		struct strbuf realpath =3D STRBUF_INIT;
 		const char *args[] =3D { editor, NULL, NULL };
 		struct child_process p =3D CHILD_PROCESS_INIT;
@@ -86,9 +85,10 @@ static int launch_specified_editor(const char *editor, =
const char *path,
 		p.env =3D env;
 		p.use_shell =3D 1;
 		p.trace2_child_class =3D "editor";
-		term_fail =3D save_term(1);
+		if (save_and_restore_term)
+			save_and_restore_term =3D !save_term(1);
 		if (start_command(&p) < 0) {
-			if (!term_fail)
+			if (save_and_restore_term)
 				restore_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
@@ -97,7 +97,7 @@ static int launch_specified_editor(const char *editor, c=
onst char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret =3D finish_command(&p);
-		if (!term_fail)
+		if (!save_and_restore_term)
 			restore_term();
 		strbuf_release(&realpath);
 		sig =3D ret - 128;
=2D- snap --

However, I could imagine that other scenarios call for an editor that
_also_ does not run in the terminal, and where also no real terminal is
available for saving and restoring.

I was tempted to suggest an `isatty(2)`, but that probably comes with its
own problems, too.

Ciao,
Dscho

>
> Carlo
>
> [1] https://lore.kernel.org/git/ee302c98-da27-da43-e684-c7ec8b225360@gmx=
.net/
> [2] https://yhbt.net/lore/all/nycvar.QRO.7.76.6.1903221436590.41@tvgsbej=
vaqbjf.bet/T/
>
>
