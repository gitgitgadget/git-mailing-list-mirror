From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: simple cvs-like git wrapper
Date: Fri, 1 Feb 2008 10:58:57 +0100
Message-ID: <200802011058.59464.jnareb@gmail.com>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080201072935.GA941@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 11:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKsj3-0007vz-Ne
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 11:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453AbYBAJ7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 04:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758450AbYBAJ7K
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 04:59:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:56352 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbYBAJ7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 04:59:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so561767wah.23
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ZLx2f+IInfrZkrt99rX5XMDJzqXmnsNnbPECEd4y0Fg=;
        b=EO6I8r8kIhIpy77DNjuwi5Q7sBfEfEsixMGmnp2/fPCqECyWAaanh/9Nb021SI0rzRLt3HOic6JNINIeMQH+EMA1Oc3GY02vaEEIx6VD8HXmczE5MFOO9V7eureP6NpARs0DU1qL4+5LfjyAB7kR3oU0L7j3sEA7zTygWqu3Iv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sa+NY8tTHjNkfNRDleTwhB/5F3jrc1CYzqVOl0Xrv2CYntuUm8d7Q9VxwTVpPlgkG0dSmjmrnXKT/OkCvtygjYh8vTT6rp/l2mNM7ynHfKGQwkiBs1zE0d1pbwwurBOUXHAotSwZq5gFQ4g80EHIdj1Ae49O26II49r5nNsMbcY=
Received: by 10.115.78.1 with SMTP id f1mr3771799wal.100.1201859946754;
        Fri, 01 Feb 2008 01:59:06 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.93])
        by mx.google.com with ESMTPS id g12sm7860636nfb.27.2008.02.01.01.59.03
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 01:59:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080201072935.GA941@informatik.uni-freiburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72162>

Uwe Kleine-K=F6nig wrote:
>=20
> > Footonotes:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [*1*] I'd like to point to LKML post about creating perfect patch
> > *series*, but I have forgot to bookmark it, and canot find it again
> > (IIRC somebody posted link some time ago here on git mailing list).
>
> I remember:
>=20
> 	http://groups.google.com/group/linux.kernel/browse_thread/thread/26f=
1247fd4a2acbf/ac9743b603e53bae?lnk=3Dgst&q=3Dperfect+patch#ac9743b603e5=
3bae
>=20
> .  Do you mean that?

Thanks a lot, but it is not what I was searching for. This is interesti=
ng
article about what to put and what to not put in the cover letter [0/n]=
,
while I am trying to find post about how to divide/split change into
series of commits implementing one separate part, so the whole is easy
to understand and bisectable.

--=20
Jakub Narebski
Poland
