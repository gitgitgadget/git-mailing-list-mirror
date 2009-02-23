From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to reset to remote repo
Date: Mon, 23 Feb 2009 22:57:22 +0800
Message-ID: <20090223145722.GB7422@b2j>
References: <20090223105546.GA7425@b2j> <slrngq56ql.q4m.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 15:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbcHJ-0001s3-7S
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 15:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbZBWO5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 09:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbZBWO5f
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 09:57:35 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:27051 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbZBWO5d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 09:57:33 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1547970tib.23
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0Dm/WsbMVBoLSgyyJAITmWtOVBIOaXsVpg4A1IEqSBw=;
        b=l7P/J6yGumZFQVLX6OAlZmyA/awT+df1Q8TdMTQFYkqYSDbsiDkagvLQBLhRcbWZZN
         HgzPeyAyPLj6JA9RI0HyakNVUu3PJzZMlH7fr9I4a5R6jMGvf4wxA7YVEa2+/rmflTJc
         Lwl+fsswut23BcetOGS9Js9enJ05JSaRoa/9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=vBVKc2fs4qINklIvRIX3RD/enxoUEeIr0I9Bp2ZP0zZ/XlaECWpBSpJluB6+SKQ/XP
         SZSPmKN62ZFTdDi5kD4u0nkOAmNne02+wd9iRa6wp1QR2QWzKsQ8M5H7J+riimIE0b6O
         Ztoxm6qTAMWroG6oO5UFxFA7ixnnbksXdCBXE=
Received: by 10.110.90.9 with SMTP id n9mr5943279tib.6.1235401051163;
        Mon, 23 Feb 2009 06:57:31 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id d4sm607606tib.8.2009.02.23.06.57.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 06:57:30 -0800 (PST)
Mail-Followup-To: Sitaram Chamarty <sitaramc@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <slrngq56ql.q4m.sitaramc@sitaramc.homelinux.net>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111137>

On Mon, 23 Feb 2009, Sitaram Chamarty wrote:
> git reset --hard origin/master
>=20
> This is a very simple question, and may be quicker on irc
> :-)

Does it always work?  For example if I already made several patches
interleaved with several fetch/update, or if I rebase to remove the
orgin/master?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9286 =E5=BC=B5=E7=A5=9C  =E9=A1=8C=E9=87=91=E9=99=B5=E6=
=B8=A1
    =E9=87=91=E9=99=B5=E6=B4=A5=E6=B8=A1=E5=B0=8F=E5=B1=B1=E6=A8=93  =E4=
=B8=80=E5=AE=BF=E8=A1=8C=E4=BA=BA=E8=87=AA=E5=8F=AF=E6=84=81  =E6=BD=AE=
=E8=90=BD=E5=A4=9C=E6=B1=9F=E6=96=9C=E6=9C=88=E8=A3=A1  =E5=85=A9=E4=B8=
=89=E6=98=9F=E7=81=AB=E6=98=AF=E7=93=9C=E5=B7=9E
