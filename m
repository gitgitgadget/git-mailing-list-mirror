From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Documentation: mention environment variables GIT_CONFIG_NO(GLOBAL|SYSTEM)
Date: Mon, 4 Oct 2010 01:10:08 +0200
Message-ID: <AANLkTimkDEff5dzO+PDR44vSq9JQ7Junj+Lwm30Fy1Vr@mail.gmail.com>
References: <20101003235329.6f4d2572@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2XhU-0007gG-AX
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab0JCXKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 19:10:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59949 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0JCXKa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 19:10:30 -0400
Received: by iwn5 with SMTP id 5so6163839iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+rzD3BJtd5wcN78YpN3xE6p9jmBWwqg//6nbZZ3TFYo=;
        b=AIm4xWW3OTNQw7f3wBdESUB9Vobes2sywTLeciUQrWNLCxp/1bLDk7kGO48YTUIJFy
         ZqltMNFDOopr+U7MKDgaKBUCJn4+n4XEjDMKN1ZmQ/lQ8SYFhfM+hKldPGcpundVz90y
         Ehz5JOq1c9QVKL1b68onY+R01LoeAjpfTuCaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZNbByumFB3OkaFaPwkgr3VJ//fRD3pPXaHdrHVCaQG7gQ86HoA0KeDKPDyUIWz0iyP
         mH3mt6iT13hkiQZH5scxSM7iI6gUhHNqW4woSdMPVVL9g916SRydtNUVf9ab1zNv63Rh
         Wk0Gturvb3rNr1R+iTFFqOduisZWvmycatTkA=
Received: by 10.231.31.196 with SMTP id z4mr9141008ibc.111.1286147430277; Sun,
 03 Oct 2010 16:10:30 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 16:10:08 -0700 (PDT)
In-Reply-To: <20101003235329.6f4d2572@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157943>

Heya,

On Sun, Oct 3, 2010 at 23:53, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> The environment variables GIT_CONFIG_NOGLOBAL and GIT_CONFIG_NOSYSTEM
> which have the opposite effect of the --global and --system switches =
to
> git-config are completely undocumented. This mentions them in the
> 'files' and 'environment' sections of the manpage for git-config wher=
e
> GIT_CONFIG is already mentioned.

Nice.

> +GIT_CONFIG_NOGLOBAL::
> + =C2=A0 =C2=A0 =C2=A0 If set to true, do not use the global configur=
ation file
> + =C2=A0 =C2=A0 =C2=A0 in ~/.gitconfig.
> +
> +GIT_CONFIG_NOSYSTEM::
> + =C2=A0 =C2=A0 =C2=A0 If set to true, do not use the system-wide con=
figuration file in
> + =C2=A0 =C2=A0 =C2=A0 /etc/gitconfig.
> +

If there are a '--no-global' and '--no-system', would it good to
mention those too? Something like: "If set to true, do not use the
system-wide configuration file in /etc/gitconfig, equivalent to
--no-global."?

--=20
Cheers,

Sverre Rabbelier
