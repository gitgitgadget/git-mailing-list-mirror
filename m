From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update-index --unresolve
Date: Thu, 02 Oct 2008 06:58:41 -0700 (PDT)
Message-ID: <m3tzbvqesz.fsf@localhost.localdomain>
References: <20081002135224.GC6839@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:06:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOij-0007LP-Tr
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbYJBN6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 09:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYJBN6p
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:58:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:53169 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbYJBN6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 09:58:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so422822nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=OXONTNTriOC5JpmznnkZXr1VLhYlvdMzdpOejJhW/C4=;
        b=qZXtHSRqCRIza8fms2WfitC0+tVGM+8L4l7fdP4ZfcdZsDbtRDr3oW10aLle2y9mjK
         3Gm7fdHespaXT/HypeYQF2/ISW84qSdyH4tUeVAhVYdpK8W+i61/SzlWQgocLTWeTD0Q
         POCjoGuNujIFFO5woztkBS/X4LKax+gxWRwGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=eFr7d3UU4cDYV95JMN50bXvd6h1wP4Iclzo51YP860Ops+05Cq9LewhSTItOKCdHPx
         ELe/ZfYwVP4xTUmwvQUaTBAakUgfNIrpvNaaIEV8DLJ0U7LnmFZKLVpXLaPThKtfSM5q
         S4GMC6Z1eGiGX3az46sj1Rlgp94vvo8MCELl4=
Received: by 10.210.61.8 with SMTP id j8mr11467648eba.94.1222955923094;
        Thu, 02 Oct 2008 06:58:43 -0700 (PDT)
Received: from localhost.localdomain (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id 10sm2078061eyd.6.2008.10.02.06.58.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 06:58:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m92DwdBA018312;
	Thu, 2 Oct 2008 15:58:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m92DwbmY018309;
	Thu, 2 Oct 2008 15:58:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081002135224.GC6839@neumann>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97332>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Dear All,
>=20
> the documentation says following:
>=20
>   --unresolve::
>          Restores the 'unmerged' or 'needs updating' state of a
>          file during a merge if it was cleared by accident.
>=20
> How could I clear those states by accident (or intentionally)?

"git add <file>", or "git update-index <file>", or error in handling
merge tool via git-mergetool.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
