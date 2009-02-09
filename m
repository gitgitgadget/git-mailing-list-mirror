From: bill lam <cbill.lam@gmail.com>
Subject: Re: tool and worktree
Date: Mon, 9 Feb 2009 10:15:08 +0800
Message-ID: <20090209021508.GA7599@b2j>
References: <20090208034406.GB7230@b2j> <2c6b72b30902080147u61412b04w24baa0e5fdc29584@mail.gmail.com> <2c6b72b30902081717q35fd4ba0k6ff5b1be8cd5ef2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 03:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLhb-00077q-Cz
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 03:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbZBICPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 21:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbZBICPR
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:15:17 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:29523 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbZBICPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:15:16 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1606265tib.23
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 18:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YPKSCZ2iZIBYkkVjtuI7F95HrheIWKzFa4aKxU6KkPA=;
        b=s01D6qz/L/umeCVulTa3oUn/woq6dW4qCr5nIlB7nUFseQ36wYtiOQwmaKPLq+jJai
         R1X4Y2E+OmWupAXmQemlY8JonFsbtmf51jtVTIQFlQn1ZTVs/BFkRjibBJMHIixGEnuW
         UYpfgy1dl40NKH/0KBHy4Sod1C4+A8iOG5VKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=U/VDbguRI89ZtyZBHsTHn9aIA1fMTiMwiZk9684+xzxnKcM8gBIqb9KSWefL4Y1lnx
         iPF9Fv4532ZqlSe9g8NTi2c73wPU5yPnhE3+YWv2Ag3vZ/gryRxrf8nhzyl3qZUzSitR
         YvDEuhLbMFS3LXdSuSzJQwUwhSyEg9lnYTYOA=
Received: by 10.110.68.10 with SMTP id q10mr7205623tia.32.1234145713785;
        Sun, 08 Feb 2009 18:15:13 -0800 (PST)
Received: from localhost (pcd632187.netvigator.com [218.102.164.187])
        by mx.google.com with ESMTPS id 22sm5798311tim.24.2009.02.08.18.15.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 18:15:12 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <jonas.fonseca@gmail.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2c6b72b30902081717q35fd4ba0k6ff5b1be8cd5ef2c@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109038>

On Mon, 09 Feb 2009, Jonas Fonseca wrote:
> On Sun, Feb 8, 2009 at 10:47, Jonas Fonseca <jonas.fonseca@gmail.com>=
 wrote:
> > It might be as
> > simple as setting the GIT_DIR environment to getcwd() + output of
> > git-rev-parse --git-dir and then chdir() to core.worktree.
>=20
> I have pushed a lightly tested patch that does something like this ..=
=2E

Thanks. Now the status view works.

Since /etc contains both public and private files.  When browsing the
untracked files in the status view, for files that without read
permission, eg the shadow passwd file, the lower pane displays the
content of the last readable file.  Could it clear the content or just
filter and display only files with read permission for the untracked
files?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9215 =E6=9D=8E=E5=95=86=E9=9A=B1  =E7=84=A1=E9=A1=8C
    =E7=9B=B8=E8=A6=8B=E6=99=82=E9=9B=A3=E5=88=A5=E4=BA=A6=E9=9B=A3  =E6=
=9D=B1=E9=A2=A8=E7=84=A1=E5=8A=9B=E7=99=BE=E8=8A=B1=E6=AE=98  =E6=98=A5=
=E8=A0=B6=E5=88=B0=E6=AD=BB=E7=B5=B2=E6=96=B9=E7=9B=A1  =E8=A0=9F=E7=82=
=AC=E6=88=90=E7=81=B0=E6=B7=9A=E5=A7=8B=E4=B9=BE
    =E6=9B=89=E9=8F=A1=E4=BD=86=E6=84=81=E9=9B=B2=E9=AC=A2=E6=94=B9  =E5=
=A4=9C=E5=90=9F=E6=87=89=E8=A6=BA=E6=9C=88=E5=85=89=E5=AF=92  =E8=93=AC=
=E8=90=8A=E6=AD=A4=E5=8E=BB=E7=84=A1=E5=A4=9A=E8=B7=AF  =E9=9D=92=E9=B3=
=A5=E6=AE=B7=E5=8B=A4=E7=82=BA=E6=8E=A2=E7=9C=8B
