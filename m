From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to git a read only directory
Date: Thu, 22 Jan 2009 18:29:25 +0800
Message-ID: <20090122102925.GD6936@b2j>
References: <20090121083354.GG6970@b2j> <4977164B.4020706@panasas.com> <20090121155256.GB6966@b2j> <4977515B.9030807@panasas.com> <20090122100008.GC6936@b2j> <4978483D.6040105@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPwpu-0004rh-Pj
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 11:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbZAVK3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 05:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbZAVK3d
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 05:29:33 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:18489 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbZAVK3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 05:29:33 -0500
Received: by ti-out-0910.google.com with SMTP id b6so3064692tic.23
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U/KeG/qZ9HG2DOxFhzeFtt+P1tSK55sii9QhBTOoE/4=;
        b=o+dzLuQiwt6YGJ4UGGJmWkwkIrLY+GaKuZWniodS3d3txBHPxz+B+TfKCbke7jpt+E
         Z/1JJPnBOAeSVndDrMt65nxS7plwkek7SBhDTfe4d1/O2XDGrhz4GVCuQmVkCdNQ890W
         a/YcCVx9q0w8c0PI7/UvDer8hoHmCqEGy1Ndg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=uiGAEqCSv7qGNanmQXifeOhbQCHZtYrkTaoF2uE2YMbNHailjFlEGOXB03yGgHoLoa
         iUcPGmonBweQOJPQYt3t2aoCELruOfBK8tBYf0lFJMiU/231qjy+rGJFgyX0bcqA+sAW
         xIg2IK+KchSZT6cM1Z93XMpAXKth9TKWCNxVU=
Received: by 10.110.17.14 with SMTP id 14mr29771tiq.19.1232620171166;
        Thu, 22 Jan 2009 02:29:31 -0800 (PST)
Received: from localhost (n218103218121.netvigator.com [218.103.218.121])
        by mx.google.com with ESMTPS id w5sm2698614tib.34.2009.01.22.02.29.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 02:29:29 -0800 (PST)
Mail-Followup-To: Boaz Harrosh <bharrosh@panasas.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4978483D.6040105@panasas.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106742>

On Thu, 22 Jan 2009, Boaz Harrosh wrote:
> Sorry My mistake, it should be:
> [gitrepo] $ git-add etc/fstab
>=20
> Sorry it's a typo, sure you must add files relative to
> the base directory (one containing the .git/ dir)

Hi Boaz,

I still could not add the file. This time it said symbolic link error.

gitrepo$ ll -A
total 4
lrwxrwxrwx 1 bill bill    4 2009-01-22 17:54 etc -> /etc
drwxr-xr-x 7 bill bill 4096 2009-01-22 18:23 .git
gitrepo$ pwd
/home/bill/gitrepo
gitrepo$ git add etc/fstab
fatal: 'etc/fstab' is beyond a symbolic link

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9314 =E7=8E=8B=E6=98=8C=E9=BD=A1  =E9=95=B7=E4=BF=A1=E6=
=80=A8
    =E5=A5=89=E5=B8=9A=E5=B9=B3=E6=98=8E=E9=87=91=E6=AE=BF=E9=96=8B  =E4=
=B8=94=E5=B0=87=E5=9C=98=E6=89=87=E5=85=B1=E5=BE=98=E5=BE=8A  =E7=8E=89=
=E9=A1=8F=E4=B8=8D=E5=8F=8A=E5=AF=92=E9=B4=89=E8=89=B2  =E7=8C=B6=E5=B8=
=B6=E6=98=AD=E9=99=BD=E6=97=A5=E5=BD=B1=E4=BE=86
