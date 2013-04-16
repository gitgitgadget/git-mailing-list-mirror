From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
Date: Mon, 15 Apr 2013 23:10:58 -0400
Message-ID: <CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
	<85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
	<7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412064953.GB5710@elie.Belkin>
	<7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
	<516888C0.90501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 05:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URwIa-0006u4-7x
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 05:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935576Ab3DPDLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 23:11:01 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33338 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935470Ab3DPDK7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 23:10:59 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so24225wib.10
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 20:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=x69SlFwwTaNfSPoVCNPHJkIyrJVFW5+UansLWmUwHMU=;
        b=08zPQDtWmwczSL64keW0Jfv+nAOT92EvZrCNOzhM5WembDcgyymP+qPIl955Mfp94j
         ugBJ1hTO9IwnCfcZTv9w5ZbwopV8P4AMXWmUwK43/LBLRTQhmGwpi/I/DfWtrpzPaOz7
         59yMgK3eZ8Xv7N7z/V4aN8Tmp1MF32UqtuYjwRJ0oEarexVGR1+T9ihdtyV6SvIDqgxB
         KDTk/rG7voKDg6xNXdBc79lv6HKuay7baBircFUdF7Y4ZNSNOXZC+BJ8kX7GbpvQ8gEc
         9Fd8fIdCYcLqwHb00N92O9uib4sTJT8/I9jCcTqMmsqGCuDl9CYFWRVcRGyXeATHMHy3
         Z/gw==
X-Received: by 10.180.94.133 with SMTP id dc5mr16531032wib.1.1366081858548;
 Mon, 15 Apr 2013 20:10:58 -0700 (PDT)
Received: by 10.194.163.101 with HTTP; Mon, 15 Apr 2013 20:10:58 -0700 (PDT)
In-Reply-To: <516888C0.90501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221352>

On Fri, Apr 12, 2013 at 6:20 PM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:

> -- >8 --
> Subject: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFI=
G_SYSTEM
>
> The flow of the text describing GITWEB_CONFIG_SYSTEM and
> GITWEB_CONFIG_COMMON in gitweb/INSTALL is awkward.  "This is
> bad. Oh the other hand, better is broken. Therefore ..." forces
> readers to make multiple guesses while reading: "ok, bad, so you plan
> to change it and warn us about upcoming change?  oh, not that,
> changing it is bad, so we have to live with it?  oh, not that, there
> is another one that is common and that is what we can use".
>
> Better rewrite said paragraph to avoid such a mental roller-coaster i=
n
> the first place.
>
> Signed-off-by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/INSTALL |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index 6d45406..7ad1050 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -243,14 +243,12 @@ for gitweb (in gitweb/README), and gitweb.conf(=
5) manpage.
>    GITWEB_CONFIG_SYSTEM build configuration variable, and override it
>    through the GITWEB_CONFIG_SYSTEM environment variable.
>
> -  Note that if per-instance configuration file exists, then system-w=
ide
> -  configuration is _not used at all_.  This is quite untypical and s=
uprising
> -  behavior.  On the other hand changing current behavior would break=
 backwards
> -  compatibility and can lead to unexpected changes in gitweb behavio=
r.
> -  Therefore gitweb also looks for common system-wide configuration f=
ile,
> -  normally /etc/gitweb-common.conf (set during build time using buil=
d time
> -  configuration variable GITWEB_CONFIG_COMMON, set it at runtime usi=
ng
> -  environment variable with the same name).  Settings from per-insta=
nce or
> +
> +  Note that the GITWEB_CONFIG_SYSTEM system-wide configuration file =
is
> +  only used for instances that lack per-instance configuration file.
> +  You can use GITWEB_CONFIG_COMMON common system-wide configuration
> +  file (normally /etc/gitweb-common.conf) to keep common default
> +  settings that apply to all instances.  Settings from per-instance =
or
>    system-wide configuration file override those from common system-w=
ide
>    configuration file.

The point of wording it such that it was explicitly noted that the
supposed "system-wide" settings were really just "system-wide
defaults" (which would be ignored wholesale if any one setting was
overridden locally) was due to the fact that most of the time server
administrators don't deal with software that idiosyncratic. Prior to
the addition of GITWEB_CONFIG_COMMON there was no method for setting
up a sane default template that wouldn't be discarded wholesale upon
any one configuration parameter being overridden.

That's the point of explaining SPECIFICALLY why the then current
behavior wasn't being replaced, and this other mechanism (which would
otherwise have no obvious reason for existing) was being introduced.
So, unfortunately,  if we remove the "mental roller coaster" part of
the explanation entirely we can expect to end up in exactly the
situation that I complained about to begin with. (Or we could just do
this the way everybody else does, with partial overrides being the
common case, starting at 2.x and no longer have the mental roller
coaster problem at all.)

As I'm the one that complained loudly enough to get this change to be
made in the first place I'd appreciate being kept in the loop in this
series.

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
