From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Fri, 6 Feb 2009 18:49:46 +0800
Message-ID: <20090206104946.GE7259@b2j>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:55:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOMw-0006yp-Ov
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbZBFKyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 05:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZBFKyG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:54:06 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:2276 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZBFKyD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:54:03 -0500
Received: by ti-out-0910.google.com with SMTP id d10so940230tib.23
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 02:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dBUuuovxX5MAglBB8uhMVxgPQb3Fd0IbvYikoVe2fmg=;
        b=twOz+a9vf5nCWYsVRPSdQ9W1navKRlQAT9pWLMOo56aZ9VWlcqHxN84rj8ROT0wj56
         vsQGwy7+mqAd0QhSFvTUeWgUJGu7GJh20liUmZi9K+3FqPnUeXvsmVO3seDU3tNOtKbQ
         pnLP17+KXkXXAYUa4eZ0YL5BUS0KWdIncHnfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=PB3urBZEEbjKhhv41AX+AnsFu6TxMmUqAXLhkhZIYyttF9aunNhXsWLMwj4n/Ia6J9
         ybIgL3dAcug2deVZ93NqfZijfkV4lgf/E2C3EinG7VbpU8SSjGZcLle80RGTtTjR3XOi
         wTgvFwPmxnrySIoyCMPeNq/ZHum4R/ka3IXDY=
Received: by 10.110.53.14 with SMTP id b14mr2378875tia.52.1233917641245;
        Fri, 06 Feb 2009 02:54:01 -0800 (PST)
Received: from localhost (n219079102072.netvigator.com [219.79.102.72])
        by mx.google.com with ESMTPS id b7sm369970tic.35.2009.02.06.02.53.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 02:54:00 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090205204436.GA6072@diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108677>

Thank you for the update!

There is a choice in "git add -i" call patch/hunks.  Is this the same
as the update/chunks as described in tig manual?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9110 =E6=9D=9C=E7=94=AB  =E5=A4=A9=E6=9C=AB=E6=87=B7=E6=
=9D=8E=E7=99=BD
    =E6=B6=BC=E9=A2=A8=E8=B5=B7=E5=A4=A9=E6=9C=AB  =E5=90=9B=E5=AD=90=E6=
=84=8F=E5=A6=82=E4=BD=95  =E9=B4=BB=E9=9B=81=E5=B9=BE=E6=99=82=E5=88=B0=
  =E6=B1=9F=E6=B9=96=E7=A7=8B=E6=B0=B4=E5=A4=9A
    =E6=96=87=E7=AB=A0=E6=86=8E=E5=91=BD=E9=81=94  =E9=AD=91=E9=AD=85=E5=
=96=9C=E4=BA=BA=E9=81=8E  =E6=87=89=E5=85=B1=E5=86=A4=E9=AD=82=E8=AA=9E=
  =E6=8A=95=E8=A9=A9=E8=B4=88=E6=B1=A8=E7=BE=85
