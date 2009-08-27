From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Thu, 27 Aug 2009 21:16:06 +0800
Message-ID: <1976ea660908270616v543776fdv6ec167cc105337fc@mail.gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <cover.1250860247.git.mstormo@gmail.com>
	 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
	 <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
	 <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com>
	 <3f4fd2640908231122m34604196pc98c5871cf5925b5@mail.gmail.com>
	 <4A91917F.9000709@gmail.com>
	 <a4c8a6d00908231229v56eceeddue1b927a4e4e49ee3@mail.gmail.com>
	 <1976ea660908250732q1e1fc153g663f3a9c13f1c902@mail.gmail.com>
	 <a4c8a6d00908251024o24380f7ue409ac5f164c085e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 15:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgepz-0005Ks-1C
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 15:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZH0NQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZH0NQH
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 09:16:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:27338 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbZH0NQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 09:16:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so236233qwh.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8hUkFPNb0dMAOHpLKx+wwCXJ7968X7kyuhLDHSM9gpQ=;
        b=NwZ4ur7woQ89X5urByX/XHyowrKBEWinvciBhl8IJguOZckFn8N6cQDoo+Nh6JQpau
         v+Tu3Sodw7iIlzUz05LPXDmcL5/jgyPTg4tJ4fwczbhosI5oHwec++5PLdQQRHbGn5R3
         9Ekb3bUZV0ReiVQh6uRtmXerPZGKFa25fSFKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GZNwVlCO06Ls9KlIpNFc03zEXOMpwHXFNOVCV13K6QEJ3eFiS3yPrq8PG2WywliUlZ
         DZ2ig18qK/uvuBMs/okksAU6PzT5ElFOk4Sr5BdSXJQTgNZ+XP1cZ15vCTHFQc3ZibuV
         QOSKn6oUkMRcUZp0w45gizZM3Z6EYalqjPyqo=
Received: by 10.224.82.149 with SMTP id b21mr6116779qal.323.1251378966903; 
	Thu, 27 Aug 2009 06:16:06 -0700 (PDT)
In-Reply-To: <a4c8a6d00908251024o24380f7ue409ac5f164c085e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127158>

>
> [submodule "ext\\zlib"]
> =A0 =A0 =A0 path =3D ext\\zlib
> =A0 =A0 =A0 url =3D git://repo.or.cz/zlib.git
>
I fixed this problem
It should be ext/zlib
