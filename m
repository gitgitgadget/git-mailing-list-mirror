From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to git a read only directory
Date: Thu, 22 Jan 2009 18:00:08 +0800
Message-ID: <20090122100008.GC6936@b2j>
References: <20090121083354.GG6970@b2j> <4977164B.4020706@panasas.com> <20090121155256.GB6966@b2j> <4977515B.9030807@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPwNa-0004if-5y
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 11:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbZAVKAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbZAVKAR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 05:00:17 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:10019 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbZAVKAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 05:00:16 -0500
Received: by ti-out-0910.google.com with SMTP id b6so3061320tic.23
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 02:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fXhDmcrNEtOJ9NC75BhUusnh5nS9CWHrVqxjkg1m1PE=;
        b=nuiGW5JqARnm4B0tGBHibvR58gbZjqHK2hTcVg+71qKqAiDD7KuEweu93shrOJpDvk
         wT3EVRgDVgTA79zWD22arjgicQLsQhBNz8T/MkU9CBny4/RwuTN8DVhfaVhxobSaxDCo
         2wnjrsi5Q9R/vgMFELgKMpDG48/DwezgJ1jXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=saO0OqlgxftvMr9HQxUo3nNzwfAc12DyA855/ifsQtf+vsNC8cxFHmRjUnvMtYoUdh
         E5g5JvdWobBQ8YCx5IP9BCFfLzmAPJCLfy0hqC/YqYdgOWV1zLp28Ayg9Iu50LmzEDwJ
         uvc9r+zxhSfMNfcAVtkqziPIJl3pM7IzZnIwc=
Received: by 10.110.40.8 with SMTP id n8mr4365160tin.28.1232618413808;
        Thu, 22 Jan 2009 02:00:13 -0800 (PST)
Received: from localhost (n218103218121.netvigator.com [218.103.218.121])
        by mx.google.com with ESMTPS id i6sm2049807tid.16.2009.01.22.02.00.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 02:00:12 -0800 (PST)
Mail-Followup-To: Boaz Harrosh <bharrosh@panasas.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4977515B.9030807@panasas.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106738>

On Wed, 21 Jan 2009, Boaz Harrosh wrote:
> [~] $ mkdir gitrepo; cd gitrepo
> [gitrepo] $ git-init
> [gitrepo] $ ln -s /etc
> [gitrepo] $ git-add /etc/fstab

(I use git ver. 1.6.1, git-xxx is already deprecated)
I followed your example, and failed in the git add,

gitrepo$  git add /etc/fstab
fatal: '/etc/fstab' is outside repository

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9260 =E6=9D=8E=E7=9B=8A  =E6=B1=9F=E5=8D=97=E6=9B=B2
    =E5=AB=81=E5=BE=97=E7=9E=BF=E5=A1=98=E8=B3=88  =E6=9C=9D=E6=9C=9D=E8=
=AA=A4=E5=A6=BE=E6=9C=9F  =E6=97=A9=E7=9F=A5=E6=BD=AE=E6=9C=89=E4=BF=A1=
  =E5=AB=81=E8=88=87=E5=BC=84=E6=BD=AE=E5=85=92
