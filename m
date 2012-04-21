From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Sat, 21 Apr 2012 10:00:18 +0700
Message-ID: <20120421030018.GA32687@do>
References: <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk>
 <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net>
 <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
 <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
 <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com>
 <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
 <4F9017BF.90702@viscovery.net>
 <CABPQNSa7NiK=baYbDBENt-An0mFGn1i+GPnN_=LpqAVScXrG2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 05:03:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLQbq-0006qr-KP
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 05:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab2DUDDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 23:03:33 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:54976 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2DUDDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 23:03:32 -0400
Received: by dake40 with SMTP id e40so13714251dak.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 20:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tYnUPvz8vmJ1l6WxvDDB/a4ZWD2GVzLbi1Ehd8xj8H8=;
        b=g1WMpPInTKazQURTOQQKvp17oLO/1WCv6feYpjtR09w6Z+lJKKIfUs07MGw3d3JVJ8
         OOf0+RDckfGl4bvhLxaWgrxZo5oXTjh5QN6Loqu/FMyggZubigQQWzJwSG2N3JCLXYMd
         T/RvTgo6O3BI5KuTCiSzytD0Q2zTgYx5WRsbgSPSSgxXJU/pIWEjqFIUp40du2gQweKa
         xSDrC/B8DG1HsUGeZEJB9sksnXYT6UkkSjhAtCTZN/7fiAI/Z0TmwrNNtRhIul7s0mV5
         /n/kgyBY+bpDrSr2Ab2OqAtWNBcCPrHELBFpwm2rzuujF1Gmlliq5pGKczlb4VKFV9lg
         F1IA==
Received: by 10.68.221.227 with SMTP id qh3mr17387859pbc.43.1334977412094;
        Fri, 20 Apr 2012 20:03:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.45.28])
        by mx.google.com with ESMTPS id f8sm7096094pbe.42.2012.04.20.20.03.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Apr 2012 20:03:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 21 Apr 2012 10:00:18 +0700
Content-Disposition: inline
In-Reply-To: <CABPQNSa7NiK=baYbDBENt-An0mFGn1i+GPnN_=LpqAVScXrG2w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196032>

On Thu, Apr 19, 2012 at 03:52:44PM +0200, Erik Faye-Lund wrote:
> On Thu, Apr 19, 2012 at 3:48 PM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
> > Am 4/19/2012 15:31, schrieb Erik Faye-Lund:
> >> int main(int argc, const char *argv[])
> >> {
> >> =A0 =A0 =A0 =A0 int i, fd =3D open(__FILE__, O_RDONLY);
> >> =A0 =A0 =A0 =A0 for (i =3D 0; i < 2; ++i) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char buf[11] =3D {0};
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mingw_pread(fd, buf, 10, 0);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("buf =3D '%10s'\n", buf);
> >> =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 =A0 return 0;
> >> }
> >
> > The test is flawed. It shows only that pread can read twice the sam=
e file
> > location.
>=20
> Oh, you are of course right. *slaps forehead*
>=20
> > But it must not update the file pointer, whereas the
> > documentation of ReadFile says (quoting the paragraph that is relev=
ant for
> > us):
> >
> > =A0If hFile is not opened with FILE_FLAG_OVERLAPPED and lpOverlappe=
d is
> > =A0not NULL, the read operation starts at the offset that is specif=
ied in
> > =A0the OVERLAPPED structure. ReadFile does not return until the rea=
d
> > =A0operation is complete, and then the system updates the file poin=
ter.
>=20
> Indeed. Correcting the test to first do pread and then read reveals
> that the file pointer does indeed get updated. Grrr...
>=20
> > Hence, your mingw_pread() looks like a workable solution for our pu=
rposes,
> > but is still not a 100% correct emulation of pread(). (Testing all =
this
> > will have to wait for another 18 hours or so.)
> >
>=20
> I don't know our use-cases, but I'd be a lot happier if I could find =
a
> safe way to have it not update the file-pointer. Just reading it and
> setting it back again would be racy.

Replace pread() in index-pack to pread_weak() because we know we don't
care about file offset in index-pack. Define pread_weak as pread
normally. Windows port can provide its own pread_weak version, which
can freely move file offset.
--=20
Duy
