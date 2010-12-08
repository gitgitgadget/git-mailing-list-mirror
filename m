From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Wed, 8 Dec 2010 20:51:08 +0100
Message-ID: <201012082051.09730.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <20101208180605.GD5687@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 20:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQQ2y-000774-RC
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 20:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0LHTvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 14:51:23 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:34245 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406Ab0LHTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 14:51:22 -0500
Received: by fxm18 with SMTP id 18so1502297fxm.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5ZyvMwm+ChFEXXI4GiOF8pfYMBLortN7vMzer5a0ato=;
        b=XGlZYmIoPZ89FSC7DaYAMD7pUAyw0VlTuq4NEm9L2HJFG0iTE0DVr/wACNdVYnaNAK
         ZQj4x6F5xdAsJVSWAg5QS2UhFuJnEj1yc1AT/FCByR2lKDkY7Q2tep0m3f/wKT4V4w3q
         9EYiREHHvOK2U2T9dA5R90vaFwA330YC/t/LU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LGlm/h3vxeSpT1cyySff7fL8K26Jr+UEZXNrKyD6TNnx+dXKsIf370AU4PU/HPhvSO
         HQgK+/YTxudXvtp53qCeEGvVkLrx5De0lz/xcCwj8SoBcg+kbNrEQiWXyTP5ehru8Xos
         X9hGqO4MEOBr+pZmmP/FPcH8n47ZNTkH4A8Rg=
Received: by 10.223.87.13 with SMTP id u13mr9070569fal.1.1291837880948;
        Wed, 08 Dec 2010 11:51:20 -0800 (PST)
Received: from [192.168.1.13] (abvw115.neoplus.adsl.tpnet.pl [83.8.220.115])
        by mx.google.com with ESMTPS id n15sm295121fam.36.2010.12.08.11.51.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 11:51:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101208180605.GD5687@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163216>

Dnia =C5=9Broda 8. grudnia 2010 19:06, Jonathan Nieder napisa=C5=82:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>=20
> > Let's start off from where the previous discussion [1] stopped. Peo=
ple
> > seem to agree ref^{/regex} is a good choice. But we have not come t=
o
> > conclusion how to specify the count yet. Possible suggestions are
> >
> >  - ref^{/foo}2
> >  - ref^{2/foo}
> >  - ref^{:2/foo}
> >  - ref^{2nd/foo}
>=20
> How about
>=20
> 	ref^{/foo}^^{/foo}
>=20
> ?

I'll assume that there is invisible ";)" emoticon here.


=46irst, it would be ref^{/foo}^@^{/foo}, otherwise you would follow on=
ly
first parent.

Second, consider ref^{:nth(10)/foo} in your workaround...

;-)

--=20
Jakub Narebski
Poland
