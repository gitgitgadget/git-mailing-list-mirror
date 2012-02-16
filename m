From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] git-latexdiff: new command in contrib, to use
 latexdiff and Git
Date: Thu, 16 Feb 2012 11:24:51 -0800
Message-ID: <CAJDDKr5SrDoVyd8s7pE3WMQ_c_DiSiiwHTz0O0t2TM24fCb-Aw@mail.gmail.com>
References: <vpq39abrxav.fsf@bauges.imag.fr>
	<1329381560-15853-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 16 20:25:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry6wv-0003rb-NP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 20:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab2BPTYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 14:24:54 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53783 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab2BPTYv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 14:24:51 -0500
Received: by mail-yw0-f46.google.com with SMTP id o21so1493077yho.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xtOvB7geMHDUQR87KKpsfaxOdr1niF+cyMAOMciuRgU=;
        b=UDZm6tghxBLtCa0NaAuQSmyqH0fPxm3P7R6FSFZF1j8hT97+S9PO7xFmYp/K5LvTNw
         Knl9ECvagIdB0GXZ9fgviYbkMGrvXEoV11hrAjNVQRr0f1buoeWl1G3SjBoy3MCMnNW4
         s+daEei6ngkUQm+sEGkWlLNb88PhrI0T1rLnY=
Received: by 10.236.161.71 with SMTP id v47mr5371407yhk.34.1329420291630; Thu,
 16 Feb 2012 11:24:51 -0800 (PST)
Received: by 10.146.249.16 with HTTP; Thu, 16 Feb 2012 11:24:51 -0800 (PST)
In-Reply-To: <1329381560-15853-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190902>

On Thu, Feb 16, 2012 at 12:39 AM, Matthieu Moy <Matthieu.Moy@imag.fr> w=
rote:
> +
> +verbose () {
> + =C2=A0 =C2=A0if [ "$verbose" =3D 1 ]; then
> + =C2=A0 =C2=A0 =C2=A0 printf "%s ..." "$@"
> + =C2=A0 =C2=A0fi
> +}

In addition to preferring "test" over "[", we also prefer to write
these on several lines.  It's probably time to update the CodingStyle
document with these notes.

e.g.

if test "$verbose" =3D 1
then
    .... do stuff
fi

(with hard-tabs, not spaces (unlike my example))
--=20
David
