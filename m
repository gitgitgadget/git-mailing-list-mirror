From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/6] Move t6000lib.sh to lib-*
Date: Fri, 07 May 2010 13:21:43 -0700 (PDT)
Message-ID: <m3y6fvea59.fsf@localhost.localdomain>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
	<1273261025-31523-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:21:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAU3X-0004fA-VL
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215Ab0EGUVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:21:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56182 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab0EGUVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:21:46 -0400
Received: by fxm10 with SMTP id 10so1067249fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=BklaBHzIskc5dVk8YK7Iy867dY6gsD2Buw9o35xnyy0=;
        b=BcNCzITZZPLS0lztfl8ha4kkv4ZrRRs5Q4dpQwB8/MG88VcoNT4NVEz1QVvmLPG/68
         pcVpcZFsG7gcVizehqVwwt2gLhWkrR1ntLjrV9d4P9TFpmirt7Avk9l2pCsZeBj7QqLU
         M57CK569sNRxRyL/TueygcfniMlp37byWEJ/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=ZSBP2kU7psuKIDf016Ffb7O98pll/xzzp/3XmrduaMln2l3+VfQcmnFPs3spWLFIj6
         pHhzep9bbZ15mV503Y7xqoSbgsu2D2lINe91mEHKgEBydkZpEMUgmAoxFrkmPYHt/2qq
         E8hzQJeDTxgSOLINAMcpl6aaZBmgh05jtaY3o=
Received: by 10.102.15.13 with SMTP id 13mr232800muo.91.1273263704216;
        Fri, 07 May 2010 13:21:44 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id j9sm10187151mue.47.2010.05.07.13.21.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:21:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o47KL6aR012578;
	Fri, 7 May 2010 22:21:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o47KKoRe012571;
	Fri, 7 May 2010 22:20:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1273261025-31523-2-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146585>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> The naming of this test library conflicted with the recommendation in
> t/README's "Naming Tests" section. Now it's possible to na=EFvely tes=
t
> t[0-9]*.sh with prove(1) without running into errors.
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>  t/{t6000lib.sh =3D> lib-t6000.sh} |    0
>  t/t6002-rev-list-bisect.sh      |    2 +-
>  t/t6003-rev-list-topo-order.sh  |    2 +-
>  t/t6101-rev-parse-parents.sh    |    2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename t/{t6000lib.sh =3D> lib-t6000.sh} (100%)

That's a good change anyway, even if the rest of series is not
accepted, or at least not accepted in current version.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
