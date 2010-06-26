From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use of 
	it.
Date: Sun, 27 Jun 2010 00:53:07 +0200
Message-ID: <AANLkTimWQwBdcVgZK5GGmIXOcpgLpgp28ywFi6MJVnyJ@mail.gmail.com>
References: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 00:53:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSeFo-0000rE-Ms
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 00:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab0FZWx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 18:53:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54931 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0FZWx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 18:53:28 -0400
Received: by iwn41 with SMTP id 41so3190914iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v5jwiISIwPrph7rj6KwhwJnuVulX/GcXCgf5HFd1ODE=;
        b=mV2FFHhKk7O4k+HoXCiQko57DZ7HXiCL0DBMgjzHHUUoYv75hF4zqa0XoOCOw7Kg1+
         8ARCKbDfeTKNyBmqw2bSNPGvlKN1qQ0y0RvDd/nMzrk5/Hl4FiFjx2dem5qhBED4PQQ3
         FO5zCFdoG4xAr43hOCbA+tWjfe18Wwx19U4xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s7dyw85ZMg3R5FGOvnAlpn30NkCkqaK4h2Lqww4/KqBeFwfIm62LUCN0sRmpJlYti8
         TsrtxCnK/ubcApekr9Yu/U51XEIEv/E6Tlh0bo+Whh/X2yBP9qqOyhwBTXyx+NkP6G9r
         su1YrjuNaPsDZBDjCkPRQ9iq4r/Wl7l3FwlgQ=
Received: by 10.231.185.86 with SMTP id cn22mr2505789ibb.69.1277592807380; 
	Sat, 26 Jun 2010 15:53:27 -0700 (PDT)
Received: by 10.231.50.129 with HTTP; Sat, 26 Jun 2010 15:53:07 -0700 (PDT)
In-Reply-To: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149780>

Heya,

On Sun, Jun 27, 2010 at 00:34, Thiago Farina <tfransosi@gmail.com> wrot=
e:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct object_array commits =3D { 0, 0, NU=
LL };

Looks like object_array could use the same treatment?

--=20
Cheers,

Sverre Rabbelier
