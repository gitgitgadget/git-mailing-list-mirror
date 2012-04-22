From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Bash-completion-devel] [PATCH v2] completion: add new
 git_complete helper
Date: Sun, 22 Apr 2012 15:58:48 +0300
Message-ID: <CAMP44s10iy64dLXJtScijeQne0ufnwrmSyvdRT0Szyf9b2kCGA@mail.gmail.com>
References: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
	<20120416204641.GH12613@burratino>
	<CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com>
	<20120416205952.GJ12613@burratino>
	<4F925FBC.2030406@iki.fi>
	<CAMP44s1dNqokGuLg3ReLAreNBM++0NxOMUUk-=AgFBUy3n=E9w@mail.gmail.com>
	<4F92F0D2.1090609@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	bash-completion-devel@lists.alioth.debian.org, git@vger.kernel.org
To: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Sun Apr 22 14:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLwNW-0007Jx-5q
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 14:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686Ab2DVM6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Apr 2012 08:58:51 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40864 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2DVM6v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2012 08:58:51 -0400
Received: by eekc41 with SMTP id c41so2937282eek.19
        for <git@vger.kernel.org>; Sun, 22 Apr 2012 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zrglXkf5w1Oaa1wDAWlQUMQLXvyOJNMzJfCGZRryYIc=;
        b=wpGYHvGfLcN10Iih8MaIZXhq1xnevRoPtyqhvBZr3cPGJU3MvNzsUQjXzLosjFojb0
         vQ2dF4j8G7JkFKJCRr01VrocJP/HtA6e9TRY9mbT5oxoGhFkb1VmFhFUgS72RUZwX6k7
         jGKvNOSbfbTVE09Y36e36UXHemEXZv6PjbFZIEqhcJ9lqUMgUxDKUUHiCFm9fxYOivOq
         YnFkJeK+Ni50Mr9bipTBkZjR8/71un0AAQGfXOTQGRlg4YxMmPtRyUo0nkjYvFk7LFNo
         c4C5aXa/ZqgwZJegWVZktXu+W68kpNhw30sIy4kGSijDS4T1EmG8qH8ZyVfsgkKAarzh
         Jg1w==
Received: by 10.213.16.140 with SMTP id o12mr965864eba.150.1335099529550; Sun,
 22 Apr 2012 05:58:49 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 22 Apr 2012 05:58:48 -0700 (PDT)
In-Reply-To: <4F92F0D2.1090609@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196079>

2012/4/21 Ville Skytt=C3=A4 <ville.skytta@iki.fi>:
> On 2012-04-21 18:41, Felipe Contreras wrote:
>
>> Still, I don't see the point in avoiding 'git_complete' and making o=
ur
>> lifes more difficult.
>
> I'm not aware of ways it'd make people's lifes more difficult, but if
> git_complete is a function intended for completion purposes, I'd
> personally not name it git* because it'd interfere for example with
> completing git<TAB> by being included in the suggested completions ev=
en
> though it's never meant to be used that way. =C2=A0Prefixing for exam=
ple with
> underscore doesn't avoid the problem completely, but makes it less
> likely to happen.

That's actually a good point, I forgot that functions are also complete=
d.

Cheers.

--=20
=46elipe Contreras
