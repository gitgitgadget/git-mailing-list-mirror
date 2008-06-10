From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 21:59:02 +0200
Message-ID: <200806102159.02875.jnareb@gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <m3abhtp42o.fsf@localhost.localdomain> <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Denis Bueno" <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6A2f-0006km-K8
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYFJUBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 16:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYFJUBK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:01:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:41177 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbYFJUBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 16:01:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1898096fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oYOLHQeRcjO6upQldNhGCZzdYdr+LdJvSwGgOuf04M0=;
        b=mbKOI4Vz8Z69LUfMtHapr5ikV5dJ7TYaXiCfuDaPcem2TP5eCeEqrrSJFoQBmj6TVd
         uNAWSytrFfs40W7keP0fvDg4UhMuVBvw+oJf0tCpT0MIsjpIusa6L7zLOMlf6Ld+iCSR
         N/GXhDz+9Pq3mqw87mtrtBrSbrMTxUfVAwkkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Yspx54iRpYqv6OOm8zj+UWSn8ztMoeFfftvNcm8++0jMwXYZFGJoaP+XAN5laoEyQz
         GfVv07JtUEmevq0fX0Oxxhy7sK+zODbboHYk4UxWTxypTTLfAHSClAkRgGZlIkRFybps
         dbZCKNMSZzA0B5eyr0z/Hkej/HXpAMrbNnywo=
Received: by 10.86.71.1 with SMTP id t1mr6201386fga.36.1213128065848;
        Tue, 10 Jun 2008 13:01:05 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id 12sm14752533fgg.0.2008.06.10.13.01.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 13:01:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84540>

On Tue, 10 Jun 2008, Denis Bueno wrote:

> However:
>=20
> identity.fb[173] > git fsck --full
> =A0 =A0 error: 320bd6e82267b71dd2ca7043ea3f61dbbca16109: object corru=
pt or missing
> =A0 =A0 error: 4d0be2816d5eea5ae2b40990235e2225c1715927: object corru=
pt or missing
> =A0 =A0 missing blob 320bd6e82267b71dd2ca7043ea3f61dbbca16109
> =A0 =A0 missing blob 4d0be2816d5eea5ae2b40990235e2225c1715927
>=20
> Shouldn't these be unreferenced now that I've run filter-branch?

Try to clone this repository (using file:/// pseudo-protocol to force
transfer of objects instead of hardlinking them), and chek if the
problem persists in the clone too.  If not, error/missing might be
in "garbage".

But I'm not sure...
--=20
Jakub Narebski
Poland
