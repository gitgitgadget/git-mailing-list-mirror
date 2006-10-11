From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: using quotemeta
Date: Wed, 11 Oct 2006 11:48:31 +0200
Message-ID: <200610111148.31490.jnareb@gmail.com>
References: <20061007174121.44284.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 11:48:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXagU-0005A7-NI
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 11:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWJKJrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Oct 2006 05:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWJKJrZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 05:47:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1452 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751057AbWJKJrY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 05:47:24 -0400
Received: by ug-out-1314.google.com with SMTP id o38so73894ugd
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 02:47:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UaNOoGnEY7n9bb+DMCy3qpa5W7lvoV+FRxhMjsCDDFwNdoiA102pppfKjnJ727z4TrMbPvGR3ibcTGjLSa7tw+11rws1F4nF85688qWo06JCth8/7kSOngrtKGCNM1FXVJWjUCgOLxKt5/NN3zOR4H+t0wGdr0y7pGqgE1J6/Qo=
Received: by 10.66.252.4 with SMTP id z4mr716302ugh;
        Wed, 11 Oct 2006 02:47:22 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id u1sm574180uge.2006.10.11.02.47.21;
        Wed, 11 Oct 2006 02:47:21 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061007174121.44284.qmail@web31813.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28709>

Luben Tuikov wrote:
> > Luben Tuikov used =A0to_qtext =A0in
> > =A0 "[PATCH] gitweb: Convert Content-Disposition filenames into qte=
xt"
> > =A0 Msg-ID: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com=
>
> > =A0 http://permalink.gmane.org/gmane.comp.version-control.git/28437
>=20
> I think that people familiar with the RFC will be able to quickly
> recognize what this function does, after seeing "qtext" in the
> name of the function. =A0After all, not only filenames can be qtext.

It wasn't meant to criticize. Just pointing out. It is nice
naming scheme (to_qtext, to_utf8) in addition to esc_* naming scheme.
I had no good idea for esc_* naming scheme for to_qtext subroutine...
so to_qtext is better.
--=20
Jakub Narebski
Poland
