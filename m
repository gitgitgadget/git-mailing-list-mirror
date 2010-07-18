From: Valeo de Vries <valeo@valeo.co.cc>
Subject: Re: remove duplicate code and not needed break statement
Date: Sun, 18 Jul 2010 18:57:12 +0100
Message-ID: <AANLkTilhNLWEF-40hE9tWdJQX6FXpYWXCu7yhAC11Zvq@mail.gmail.com>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 19:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaY7K-0001Xy-8L
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 19:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab0GRR51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 13:57:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50640 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab0GRR5Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 13:57:16 -0400
Received: by wyb42 with SMTP id 42so3659679wyb.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 10:57:14 -0700 (PDT)
Received: by 10.227.151.196 with SMTP id d4mr564828wbw.107.1279475834429;
        Sun, 18 Jul 2010 10:57:14 -0700 (PDT)
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
        by mx.google.com with ESMTPS id g37sm33843999wbg.15.2010.07.18.10.57.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 10:57:13 -0700 (PDT)
Received: by wyb42 with SMTP id 42so3659652wyb.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 10:57:12 -0700 (PDT)
Received: by 10.227.138.5 with SMTP id y5mr3084924wbt.204.1279475832524; Sun, 
	18 Jul 2010 10:57:12 -0700 (PDT)
Received: by 10.227.142.147 with HTTP; Sun, 18 Jul 2010 10:57:12 -0700 (PDT)
In-Reply-To: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151225>

On 18 July 2010 18:49, Ralf Thielow <ralf.thielow@googlemail.com> wrote=
:
> Remove duplicate code and not needed break statement.
>
> On switch statements you can use multiple cases for one
> statement and on a goto statement you not need a break.
>
> From 5b3e7c8f8b81a295b5c58534be250f5a818ccc64 Mon Sep 17 00:00:00 200=
1
> From: Ralf Thielow <ralf.thielow@googlemail.com>
> Date: Sun, 18 Jul 2010 18:48:58 +0200
> Subject: [PATCH] remove duplicate code and not needed break statement
>
> ---
> =A0server-info.c | =A0 =A03 ---
> =A01 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/server-info.c b/server-info.c
> index 4098ca2..9ec744e 100644
> --- a/server-info.c
> +++ b/server-info.c
> @@ -113,11 +113,8 @@ static int read_pack_info_file(const char *infof=
ile)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto o=
ut_stale;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;

You seem to have missed another, or am I just lacking context? ;)

Valeo
