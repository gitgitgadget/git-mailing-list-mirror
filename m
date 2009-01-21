From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to git a read only directory
Date: Wed, 21 Jan 2009 23:52:56 +0800
Message-ID: <20090121155256.GB6966@b2j>
References: <20090121083354.GG6970@b2j> <4977164B.4020706@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 16:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfPQ-0002zp-5J
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 16:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbZAUPxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbZAUPxE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 10:53:04 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:58052 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321AbZAUPxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 10:53:03 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2909255tic.23
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mjfZ1h7XLInne+V5dVLAyD/3z2e9CkmfUf0xVNAw7/o=;
        b=rz8bKPyp4yRJgcDyWMjSQALNmc7i3AW3E8HGHODkjknXMKMqexw172G2hYZgS9euph
         3IqFk0bRN+TCbEbaYOBknY708rQERZNH3x3VE8MgwUrNGTbE0ep6qWMzci6k1xDn2k7G
         kBCCXysM99D+JvgsutLF8Hk9lYXKAUWye/+zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=KNynEMQ9mXdUBm3bAYrQKL0r65MBsfLcEN9NOW5TOEMCPJ0XkI6i8nyq0MZgLlpFaF
         vYps4r0XN53Rts2/o/Him+UnYR7EVMLsudGFHscjLg0ZgCKNEgScmvTCyoZQBnDnj3CE
         IMil+hA/q+pvf3GGoK/PCfvUSew69xKQ3L91k=
Received: by 10.110.105.10 with SMTP id d10mr2397767tic.37.1232553180603;
        Wed, 21 Jan 2009 07:53:00 -0800 (PST)
Received: from localhost (pcd589144.netvigator.com [218.102.121.144])
        by mx.google.com with ESMTPS id d1sm1611639tid.4.2009.01.21.07.52.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 07:52:59 -0800 (PST)
Mail-Followup-To: Boaz Harrosh <bharrosh@panasas.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4977164B.4020706@panasas.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106620>

On Wed, 21 Jan 2009, Boaz Harrosh wrote:
> I created a master project folder under ~home, init a new git repo,
> then symlink /etc/ onto an etc/ in the project dir, added all etc/
> files. I like the extra a/etc/fstab in the patch files better then
> a/fstab.

I create a symlink in ~/gitrepo/etc to /etc and git init an empty repo
there. However it failed in symlink when I tried to add files.  Could
you give more detail how to do it?  Meanwhile I use worktree method as
suggested by Michael.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9205 =E5=85=83=E7=A8=B9  =E9=81=A3=E6=82=B2=E6=87=B7=E4=
=B8=89=E9=A6=96=E4=B9=8B=E4=B8=80
    =E8=AC=9D=E5=85=AC=E6=9C=80=E5=B0=8F=E5=81=8F=E6=86=90=E5=A5=B3  =E8=
=87=AA=E5=AB=81=E9=BB=94=E5=A9=81=E7=99=BE=E4=BA=8B=E4=B9=96  =E9=A1=A7=
=E6=88=91=E7=84=A1=E8=A1=A3=E6=90=9C=E8=97=8E=E7=AF=8B  =E6=B3=A5=E4=BB=
=96=E6=B2=BD=E9=85=92=E6=8B=94=E9=87=91=E9=87=B5
    =E9=87=8E=E8=94=AC=E5=85=85=E8=86=B3=E7=94=98=E9=95=B7=E8=97=BF  =E8=
=90=BD=E8=91=89=E6=B7=BB=E8=96=AA=E4=BB=B0=E5=8F=A4=E6=A7=90  =E4=BB=8A=
=E6=97=A5=E4=BF=B8=E9=8C=A2=E9=81=8E=E5=8D=81=E8=90=AC  =E8=88=87=E5=90=
=9B=E7=87=9F=E5=A5=A0=E5=BE=A9=E7=87=9F=E9=BD=8B
