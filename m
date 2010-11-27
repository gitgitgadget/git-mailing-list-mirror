From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-web--browse: Add support for opera
Date: Sat, 27 Nov 2010 16:19:32 +0100
Message-ID: <AANLkTik-PnsZ7tBEgLixoKOYYrytdOGfDocuMECGn-6O@mail.gmail.com>
References: <1290856558-6122-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 16:20:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMMZE-000838-VA
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 16:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0K0PTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 10:19:54 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64530 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0K0PTx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Nov 2010 10:19:53 -0500
Received: by iwn35 with SMTP id 35so648866iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zRMCQOmV28NpXHu3XjQuPJ76xDb5ognbryWpJ4aewRI=;
        b=KHsQ2+ax8r78Ax0/cMzpZsN8RXlipm9m9KQLzMeLA6XV8YWyUPgt48uD+cWNzposkr
         3lMnQ35fDSTt6/9ot/kqIgqmWH9t0ZBR/za+aIPYHR6gLRxLCT5ZlGKWf74kYZz5ezzR
         c2+vdQeFgrbIROtI15roF9B6eXBb16l1feN+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=t4Zs0JUwrDkmO1d9NZGq/TqkU4DdIyj97eFUEZbcRngiax6l6B+pimV6Rc+ov6JDLR
         eV6g2faEf+kfyVg4NqbCaK51eqXrYHrBbgiYg8oaeRsiGgi+AN0wObFlFTrDL85OTyhm
         VGn2+14OC6AvMpWO7N7R99TIiligoSSDNWg+c=
Received: by 10.231.13.203 with SMTP id d11mr3035825iba.157.1290871193201;
 Sat, 27 Nov 2010 07:19:53 -0800 (PST)
Received: by 10.231.160.210 with HTTP; Sat, 27 Nov 2010 07:19:32 -0800 (PST)
In-Reply-To: <1290856558-6122-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162308>

Actually, ignore this patch for the time being, I'm preparing a longer
set that includes it but might need some discussion. Sorry for the
noise.

On Sat, Nov 27, 2010 at 12:15 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> It's probably not the most widespread browser, it's free as in gratis
> but not as in libre, but it's worth supporting regardless, especially
> since it's a trivial addition.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> =A0git-web--browse.sh | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index 3fc4166..eb70375 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -31,7 +31,7 @@ valid_custom_tool()
>
> =A0valid_tool() {
> =A0 =A0 =A0 =A0case "$1" in
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 firefox | iceweasel | chrome | google-c=
hrome | chromium | konqueror | w3m | links | lynx | dillo | open | star=
t)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 firefox | iceweasel | chrome | google-c=
hrome | chromium | konqueror | opera | w3m | links | lynx | dillo | ope=
n | start)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;; # happy
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0valid_custom_tool "$1"=
 || return 1
> @@ -103,7 +103,7 @@ fi
>
> =A0if test -z "$browser" ; then
> =A0 =A0 if test -n "$DISPLAY"; then
> - =A0 =A0 =A0 browser_candidates=3D"firefox iceweasel google-chrome c=
hrome chromium konqueror w3m links lynx dillo"
> + =A0 =A0 =A0 browser_candidates=3D"firefox iceweasel google-chrome c=
hrome chromium konqueror opera w3m links lynx dillo"
> =A0 =A0 =A0 =A0if test "$KDE_FULL_SESSION" =3D "true"; then
> =A0 =A0 =A0 =A0 =A0 =A0browser_candidates=3D"konqueror $browser_candi=
dates"
> =A0 =A0 =A0 =A0fi
> @@ -173,7 +173,7 @@ case "$browser" in
> =A0 =A0 start)
> =A0 =A0 =A0 =A0 exec "$browser_path" '"web-browse"' "$@"
> =A0 =A0 =A0 =A0 ;;
> - =A0 =A0dillo)
> + =A0 =A0opera|dillo)
> =A0 =A0 =A0 =A0"$browser_path" "$@" &
> =A0 =A0 =A0 =A0;;
> =A0 =A0 *)
> --
> 1.7.3.2.184.gecaee
>
>



--=20
Giuseppe "Oblomov" Bilotta
