From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: A note on modern git plus ancient meld ("wrong number of arguments")
Date: Fri, 10 Feb 2012 12:29:10 +0100
Message-ID: <CAHGBnuPBDO=tnoDFGOcGz4nZh9O_A803STmj7KALLuhwgf=hCg@mail.gmail.com>
References: <20120209191742.GA20703@unpythonic.net>
	<CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
	<20120210082106.GA7871@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 12:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvofE-0004YH-4Y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 12:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab2BJL3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 06:29:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44195 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab2BJL3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 06:29:10 -0500
Received: by iacb35 with SMTP id b35so153408iac.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 03:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XYiH8iV86fBLdOBL+4qcHGyfGs8PSaZF+xFs2ySq368=;
        b=dn5xwLbgwuIX/cATpyRxK+VlF01bwsBHGzKzeRrKJJejpZQ6s2EJZO2I/hv4i1dCSS
         +QLMwNV8wkkVtHPcHPgHNLEA8CRjXFtcTGOPfCQHIFPLORe2yNgBCoqoMV7PYYVoejog
         8l5QiJOh3Q/rQ3/+qrnaUGT08HkyaqoApezyk=
Received: by 10.50.6.138 with SMTP id b10mr10172298iga.21.1328873350162; Fri,
 10 Feb 2012 03:29:10 -0800 (PST)
Received: by 10.182.81.100 with HTTP; Fri, 10 Feb 2012 03:29:10 -0800 (PST)
In-Reply-To: <20120210082106.GA7871@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190401>

On Fri, Feb 10, 2012 at 09:23, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> + =C2=A0 =C2=A0 =C2=A0 meld_version=3D${meld_version#GNOME }
> + =C2=A0 =C2=A0 =C2=A0 meld_version=3D${meld_version#* }

Hmm, I might be mistaken, but aren't these string operations
Bash-only? And AFAIK Git is striving for standard sh compatibility ...

--=20
Sebastian Schuberth
