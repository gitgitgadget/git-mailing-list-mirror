From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Thu, 14 Feb 2008 06:09:46 +0100
Message-ID: <200802140609.47119.chriscool@tuxfamily.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com> <CE42C4F4-1E6B-4300-9FD9-29F7E17B4F27@ai.rug.nl> <76718490802131613h713be217s51ff85a0714df5ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pieter de Bie" <pdebie@ai.rug.nl>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 06:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPWGu-0002J7-Ud
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 06:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbYBNFD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 00:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbYBNFD6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 00:03:58 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:44521 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750700AbYBNFD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2008 00:03:57 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 34BED1AB2B1;
	Thu, 14 Feb 2008 06:03:56 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D955C1AB2AB;
	Thu, 14 Feb 2008 06:03:49 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <76718490802131613h713be217s51ff85a0714df5ff@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73846>

Le jeudi 14 f=C3=A9vrier 2008, Jay Soffian a =C3=A9crit :
> AFAIK, SECURITYSESSIONID is unique
> to OS X and it reliably indicates that the user is sitting in front o=
f
> the OS X GUI.

Ok, then please add a comment saying that to your original patch before=
:=20

+ =C2=A0 =C2=A0if test -n "$SECURITYSESSIONID"; then
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0browser_candidates=3D"open $=
browser_candidates"
+ =C2=A0 =C2=A0fi

and then resend it with "Acked-by: Christian Couder=20
<chriscool@tuxfamily.org>".

Thanks,
Christian.
