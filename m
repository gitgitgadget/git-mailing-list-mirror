From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/15] gettextize: git-revert mark the "me" variable
 for translation
Date: Mon, 6 Sep 2010 13:45:36 -0500
Message-ID: <20100906184536.GD25426@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-13-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:47:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsgjN-0006dW-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0IFSrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 14:47:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42104 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0IFSri convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 14:47:38 -0400
Received: by iwn5 with SMTP id 5so4477841iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0nJlzdfiWAxfYcrr5TQULVS7opVk8oxSaW/p7ApRY50=;
        b=R6w7FiJPuENvchqUoOAddsLWCqWBpeaxDL5WYqeYk8D7I4lgnPBwYX2CAg/3sN9gUH
         LtJ8dGCSDAMtHAPg+dfFnHvN1e5bmWer/D31x6tZFE2CqYYcUbLXfWvxHAwZ8at3+Wgc
         BCHWp69JwrAI4kBrMLTrOX+ueSHHsnWZhUaIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LxG6IRTrxbf0FLFLyGpaAvc8g4GZcggi8muoNj+i7g9ypXpyelyRPZJZJsIfkX/Wm6
         y679r4VkdLebrvIRT0WttRYtXg/9AA71dijFzJ4e20M49vOAKARvaPeUTanYN4onPvbI
         lqaJsJKGsgGfUiIUxjgZ1bjgcm0kiPZ8WHvGA=
Received: by 10.231.174.84 with SMTP id s20mr6661744ibz.94.1283798857999;
        Mon, 06 Sep 2010 11:47:37 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm6164582ibh.16.2010.09.06.11.47.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 11:47:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283775704-29440-13-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155599>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The "me" variable is used in many later messages to indicate whether
> we're using revert or cherry-pick.

What good does it do to translate it?  The command name is the same
even in Hindi git.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -552,7 +552,9 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  	struct rev_info revs;
> =20
>  	git_config(git_default_config, NULL);
> -	me =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
> +	/* TRANSLATORS: This is used in several error messages indicating
> +	   the name of the current program */
> +	me =3D action =3D=3D REVERT ? N_("revert") : N_("cherry-pick");
>  	setenv(GIT_REFLOG_ACTION, me, 0);

Unrelated question: Are reflog actions supposed to be translated?  (I
have not thought about that carefully.)
