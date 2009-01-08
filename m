From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [PATCH] tutorial.txt renamed
Date: Thu, 8 Jan 2009 10:21:46 +0100
Message-ID: <200901081021.46471.brian.foster@innova-card.com>
References: <20090107042337.GA24735@gnu.kitenet.net> <DA6E1A83-FFBA-46BC-9BCF-ED8A2D8F12E7@silverinsanity.com> <7vljtnbpha.fsf@gitster.siamese.dyndns.org>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Joey Hess <joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 10:23:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKr6w-000082-8A
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZAHJWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jan 2009 04:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZAHJWG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:22:06 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:37595 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbZAHJWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 04:22:02 -0500
Received: by ewy10 with SMTP id 10so9501739ewy.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=ayTEeZ9VwWiqjQ/wKEbw19BU0MI4wsCJyJod7H0pfIw=;
        b=n5ceDWKQYqSWQw5RFwoESpNixhijnwmviC4i18/DKOR9o9IRsrf02yqQyF5mW7jJly
         SR4ft4biy310aI4QL4J/oqU/N9VaErSsERfNV/ZFAYu6kkaJ7aaWdK4BbcL+MA+9QRu5
         IlB2z/J7JdzFWW53yb9C1xvqrP2QlJe2uI/rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QbG9ph8TkShegPtU3LXBAJ9SVlS0i8Im5ZXqjUY73ypVsQk9gE+z6ZytBEjiMnfd5h
         UtzetlcIxjfId+jI9Vp9i4hB+Go5L6uquc3sI8W9mgU16NKtGAFVy5iwn+vAStR3q/0Y
         Nf9pVpiGxlyBuvfbSqVphT6dgfuHEie2yzDfU=
Received: by 10.210.38.17 with SMTP id l17mr10784139ebl.134.1231406519869;
        Thu, 08 Jan 2009 01:21:59 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id p10sm38073060gvf.20.2009.01.08.01.21.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jan 2009 01:21:58 -0800 (PST)
User-Agent: KMail/1.9.10
In-Reply-To: <7vljtnbpha.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104906>

On Wednesday 07 January 2009 07:27:13 Junio C Hamano wrote:
> Brian Gernhardt <benji@silverinsanity.com> writes:
> > This is the README file for the project, so it should advise lookin=
g =20
> > at the Documentation directory as neither the man pages or git comm=
and =20
> > are likely installed at this point.
>=20
> I think that is a sane suggestion.  It is better to keep the number o=
f
> prerequisites to the minimum for the user in order to follow README (=
and
> INSTALL, of course).

 It is indeed a sane suggestion.  However, there is no (obvious?)
 harm in *also* mentioning that =E2=80=98git help tutorial=E2=80=99 sho=
uld also
 display the tutorial.  Something like =E2=80=9CIf git has been correct=
ly
 installed, then this tutorial can also be read with the command
 =E2=80=98git help tutorial=E2=80=99.=E2=80=9D

cheers!
	-blf-
--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
