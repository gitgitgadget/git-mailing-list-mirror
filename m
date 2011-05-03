From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-send-email and non 7bit clean message (was: [PATCH 0/6] gitweb: Improve ctags, introduce categories)
Date: Tue, 3 May 2011 16:02:28 +0200
Message-ID: <201105031602.30874.jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com> <7v8vuswxqs.fsf@alter.siamese.dyndns.org> <BANLkTi=cckKr3baDZAktAjz8F=JXjQJWiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Sebastien Cevey <seb@cine7.net>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Ryan Anderson <ryan@michonline.com>
To: =?utf-8?q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue May 03 16:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHGBZ-0003Zy-My
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 16:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab1ECOCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 10:02:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51583 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab1ECOCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 10:02:38 -0400
Received: by bwz15 with SMTP id 15so139176bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TJ5R4lsT4EFTZRxA+3RHmDUbj7uBH2M+8Y8/r/ua0mQ=;
        b=IuHZxKNsrbqdK96EjFgRv+SZiDvM0R4P1UzvMsAVVLn8fxze8Uy8UeqQ4B3uf1miqH
         kreD9O2a8E8il22MVqOb9aGvyo4p98U+YhCQCbK+rS7vF4BFKVfSkL0cSHeIi7ngaOt2
         eoBjCWYJgXmsUIxCsQZNzw9np5h+2wvgTXLKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qB9vm8LMjrwltY1+UUw/YOD/QEtDpBcZL0kdHa2n29GCY9Gs0vqoPjioYwspnR7mZf
         dLZQ9CQMA5R9MtC/TudYH1W+5zdTCSuw/nZ4w0TFZc6BzDggx/VX9AhpnSe4XZhwpbDq
         g0aMnKSCVnvMvyj6ADi+5sPk6vSBw7M+9jZlo=
Received: by 10.204.191.145 with SMTP id dm17mr2406716bkb.185.1304431357296;
        Tue, 03 May 2011 07:02:37 -0700 (PDT)
Received: from [192.168.1.13] (abvt77.neoplus.adsl.tpnet.pl [83.8.217.77])
        by mx.google.com with ESMTPS id q18sm79785bka.15.2011.05.03.07.02.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 07:02:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTi=cckKr3baDZAktAjz8F=JXjQJWiA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172658>

On Sat, 30 Apr 2011, =C3=98yvind A. Holm wrote:
> On 29 April 2011 23:31, Junio C Hamano <gitster@pobox.com> wrote:
> > A tangent. It is curious why [PATCH 2/6] alone ended up with an enc=
oded
> > "Subject" header, like this:
> >
> > =C2=A0Subject: =3D?UTF-8?q?=3D5BPATCH=3D202/6=3D5D=3D20gitweb=3D3A=3D=
20Change=3D20the=3D20
> > =C2=A0 way=3D20=3D22content=3D20tags=3D22=3D20=3D28=3D27ctags=3D27=3D=
29=3D20are=3D20handled?=3D
> >
> > The message actually has the above as a long single line, as can be=
 seen at
> > http://article.gmane.org/gmane.comp.version-control.git/172479/raw
> >
> > Just being curious.
>=20
> This seems as the same thing that I reported on 2010-04-25 23:35:49Z,
> <http://thread.gmane.org/gmane.comp.version-control.git/145774>. If t=
here's a
> character above U+007F in the log message below line #2, the Subject:=
 line is
> garbled. In this case it is, it's the "=C3=B6" in Uwe's name that lea=
ds to this
> error.
>=20
> A test to reproduce this is at <https://gist.github.com/378785>, but =
it seems
> as this was fixed between v1.7.4.1-292-ge2a57aa and v1.7.4.1-343-ga91=
df69 ,
> probably happened in dc7f96f (Merge branch 'jk/format-patch-multiline=
-header').
> The patch at <http://article.gmane.org/gmane.comp.version-control.git=
/172479/raw>
> was generated with git-1.7.3, so it would trigger the error in this c=
ase.

I have just upgraded git to 1.7.5, and unfortunately it still has the
same bug (note that UTF-8 character was introduced while editing patch,
so git-format-patch doesn't see it):

  5369:[gitweb/web@git]# git send-email [...] --dry-run mdir.1/*.txt
  The following files are 8bit, but do not declare a Content-Transfer-E=
ncoding.
      mdir.1/0001-gitweb-Prepare-for-splitting-gitweb.txt
  Which 8bit encoding should I declare [UTF-8]? <ENTER>
  Dry-Sent [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into mo=
dules
  Dry-Sent =3D?UTF-8?q?=3D5BPATCHv2=3D201/2=3D20=3D28RFC=3D3F=3D29=3D5D=
=3D20gitweb=3D3A=3D20Prepare=3D20for=3D20splitting=3D20gitweb?=3D
  Dry-Sent [PATCHv2 2/2 (PoC)] gitweb: Create Gitweb::Util module

Note that having

  MIME-Version: 1.0
  Content-Type: text/plain; charset=3Dutf-8

is not enough[1].  However the patch send is understood correctly by em=
ail
programs: see [PATCH 2/6] in this thread.

I have added=20

  Content-Transfer-Encoding: 8bit

to mdir.1/0001-gitweb-Prepare-for-splitting-gitweb.txt, and now it work=
s
all right.

  5370:[gitweb/web@git]# git send-email [...] mdir.1/*.txt
  Dry-Sent [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into mo=
dules
  Dry-Sent [PATCHv2 1/2 (RFC?)] gitweb: Prepare for splitting gitweb
  Dry-Sent [PATCHv2 2/2 (PoC)] gitweb: Create Gitweb::Util module


=46ootnotes:
^^^^^^^^^^
[1]: Note that git-send-email does something strange: first, the proble=
m
is with Content-Transfer-Encoding, and git-send-email asks for 8bit
encoding, suggesting UTF-8, instead of asking for transfer encoding,
sugesting e.g. 8bit.

Second, from email headers I have added git-send-email should _know_ th=
at
message uses UTF-8 encoding (though this is side issue, and probably re=
sult
of above).

--=20
Jakub Narebski
Poland
