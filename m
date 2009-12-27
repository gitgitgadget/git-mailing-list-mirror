From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Smart-http documentation: add example of how to execute 
	from userdir
Date: Sun, 27 Dec 2009 11:19:00 +0800
Message-ID: <be6fef0d0912261919m7b175c4fh532ad05a713d86c7@mail.gmail.com>
References: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 04:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOjf7-0001rI-IK
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 04:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbZL0DTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2009 22:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbZL0DTG
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 22:19:06 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:51715 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbZL0DTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Dec 2009 22:19:05 -0500
Received: by iwn1 with SMTP id 1so6748042iwn.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 19:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OmO1B7N2hX5nSqfFrCfHa2llreFo6PZLTHMIpgvzZow=;
        b=ljbRw+22JdZBMEWJG/mQ/KRf/KcTzULWy/z5SplOjZzCMovs+F4gjpOV9k6QSHdjfB
         5r+C6Pn0Iae5mGmI7mZGtO5iMaP5UZ0aPFzU4wjVtr1p4TG/nAIVk6u9TFcmtkM8Lkr1
         hMgKPl4YRbDgxQ8qR7Mjrn4Ef9OBdW3C/eIOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vfsZ2WHKtNw49cSZXaHndLjjMehaAyFi1HSrE1aQsFjE2l9p5LqAP7EHlRd+rxCAXr
         4TRz1IN6U3dxAR1UXlDKmWYdn6nnZTGxlPGFjKaN+baYu5aUMeali2gfwn1vZ2KMS35b
         IrpWMZVFYEnmiUx4lWfrjXDg8pyagUcMJ8ud4=
Received: by 10.231.10.23 with SMTP id n23mr4693030ibn.4.1261883940734; Sat, 
	26 Dec 2009 19:19:00 -0800 (PST)
In-Reply-To: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135698>

Hi,

On Sun, Dec 27, 2009 at 1:07 AM, Tarmigan Casebolt
<tarmigan+git@gmail.com> wrote:
> @@ -60,8 +60,8 @@ automatically by the web server.
>
> =A0EXAMPLES
> =A0--------
> -All of the following examples map 'http://$hostname/git/foo/bar.git'
> -to '/var/www/git/foo/bar.git'.
> +Unless otherwise noted, the following examples map
> +'http://$hostname/git/foo/bar.git' to '/var/www/git/foo/bar.git'.

This rephrase seems to be unrelated (to providing an example of
serving smart http).

> @@ -144,6 +144,42 @@ ScriptAliasMatch \
> =A0ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
> =A0----------------------------------------------------------------
>
> +In the following example, a repository at
> +'/home/$username/devel/foo/bar.git' will be accessible at
> +'http://$hostname/\~$username/cgi-bin/git/foo/bar.git'
> +
> +From UserDir on Apache 2.x::
> + =A0 =A0 =A0 One way to configure 'git-http-backend' to execute and =
serve
> + =A0 =A0 =A0 from a user directory (for example, on a shared hosting
> + =A0 =A0 =A0 provider), is to have a symbolic link that points from =
the cgi
> + =A0 =A0 =A0 directory to the 'git-http-backend' executable in libex=
ec. =A0The
> + =A0 =A0 =A0 advantage of the symblic link is that any updates to th=
e

s/symblic/symbolic/.

> + =A0 =A0 =A0 installed version of 'git-http-backend' also update the=
 version

s/update/updates/.

> + =A0 =A0 =A0 that is run in the userdir. =A0Depending on the configu=
ration of
> + =A0 =A0 =A0 the server, the symbolic link may be able to point to a=
 global
> + =A0 =A0 =A0 installation of git. =A0If, for security reasons, the s=
erver is

At this point, the user dealing with the "easy" case (ie. the user
just symlinks the shared git installation and doesn't have to create
symlinks in his own home directory) should have enough configuration
details without having to read any further. So, you could tell the
user about the symlinks to create and the configuration lines in
=2Ehtaccess.

It might also be a good idea to start a new paragraph for the "hard"
case, for better readability.

--=20
Cheers,
Ray Chuan
