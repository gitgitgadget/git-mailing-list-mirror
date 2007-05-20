From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 21:00:24 +0200
Message-ID: <20070520190024.GE13197@ferdyx.org>
References: <20070520181447.GA10638@ferdyx.org> <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net> <20070520184959.GA25462@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 21:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpqdx-0007pH-25
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbXETTAb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbXETTAb
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:00:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:42012 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbXETTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:00:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so982632uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 12:00:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=UDKMMUYa4d0O5wXE/5SIrvGrBNSbppQMQvAo70NYQH6Uf4FYL4lADA5W4cqRDPDtoAjFOyGVjPKj/eX23YM47GAgytgy8wTwh7nCPN2QaOQMlsSkz3EyjKpvHoWD4JIb6BZ6NdLCUfBSDKNDdZ0Ry9kkUe/mfLSlan0Xs3sIPes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=iWTNB11Tvzlc7Y6pPpN3+Iptnp8GLj6IoOqn8sRllYtXsTMY6qOiZtG8nS4ckNx2givU6oqRYmT/WKGZLvrFS+iMwYmbgSCP5kA8/g3tFxTegP4NvMmFjIL7W21u0ycvbTG4wFKO0uaS8ecnRT5EunhV379hAJYmPScNiJc4A4Q=
Received: by 10.67.98.4 with SMTP id a4mr2826076ugm.1179687629646;
        Sun, 20 May 2007 12:00:29 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id j2sm4271194ugf.2007.05.20.12.00.26;
        Sun, 20 May 2007 12:00:28 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@ferdyx.org; Sun, 20 May 2007 21:00:26 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070520184959.GA25462@steel.home>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47888>

On Sun, May 20, 2007 at 08:49:59PM +0200, Alex Riesen wrote:
> Junio C Hamano, Sun, May 20, 2007 20:36:25 +0200:
> > > +IMPORTANT: Maildir splitting relies upon filenames being sorted =
to output
> > > +patches in the correct order.
> >=20
> > I am sure there are many users who uses Maildir layout on this
> > list.  Happy with this patch?  Please speak out.
>=20
> I do use maildirs, but I have a suggestion: --maildir or something, t=
o
> create a non-existing maildir and split into it, so that the user doe=
s
> not have to pre-create it.

I can't think of a use case for this...

- ferdy

--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
