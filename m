From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb - bare repos integration - owner info in description file
Date: Fri, 09 Oct 2009 15:07:00 -0700 (PDT)
Message-ID: <m3ab00gr25.fsf@localhost.localdomain>
References: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=macintosh
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNgM-00064J-2o
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 00:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934721AbZJIWIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934222AbZJIWIu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 18:08:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:54351 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933378AbZJIWIt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 18:08:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so455647fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2Kcgoq2pEqKR6/WlMhYX6poGxOiQaVhTgcGqTlluTa4=;
        b=mwNOwFKuH7ZS7WTUakpMYnxJDlg7ZaywBCxLMb+nXlBZqLjILXyLSyvUGjzzIsr5f6
         Fza5X70oztdKGRMuDDmUxNTp3UVpCWZqZAN9ekWwlZOmTKnF5EA4e8JnKQMiURLn1YoL
         l4av1Mqi5Ad/zZ94qz6gT4VC5m81ngXQMgTS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=alwVqxt6+zRBd+KYFsxqjcISzEhgDHgolURxOW671I9cxTZDTImtFL6cPdrsN5RGoW
         Pjj2XAw9jVpw3qI+t/UlfXJx1etX6vmetw8K9tdUu0aZE2dwU8d2s0Lqw98Gq1Vj2KYX
         qgtBe9ecnagSBfts7lj2kDKQ0M/hLdcLo6xyU=
Received: by 10.86.18.34 with SMTP id 34mr2915593fgr.2.1255126021547;
        Fri, 09 Oct 2009 15:07:01 -0700 (PDT)
Received: from localhost.localdomain (abwc235.neoplus.adsl.tpnet.pl [83.8.226.235])
        by mx.google.com with ESMTPS id d4sm1034451fga.9.2009.10.09.15.07.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 15:07:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n99M70Gj011407;
	Sat, 10 Oct 2009 00:07:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n99M6xU5011404;
	Sat, 10 Oct 2009 00:06:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129851>

Eugene Sajine <euguess@gmail.com> writes:

> Here is another issue with gitweb integration which i think might be
> considered as a feature proposal:
>=20
> I have a central place where bare repos are. They're owned by the use=
r
> under which we are serving them, let's say =D2git=D3. So, gitweb is g=
oing
> to show me
>=20
> Repo1 owner git etc=C9
>=20
> In order to show a real owner I have to rebuild gitweb.cgi, to tell i=
t
> to use the file for GITWEB_LIST and edit the file=C9 In fact I think
> gitweb shouldn=D5t carry this info, but bare repos should.

It is not gitweb that carries this info, but file with list of
repositories (GITWEB_LIST).  And you can pre-generate this file using
gitweb.

>=20
> So my idea is:
>=20
> Either provide a key to
> $ git clone =D0bare =D0u =D2owner/email=D3
>=20
> or take the user.email parameter from .gitconfig.
>=20
> in both cases the info can go to description file of bare repo, so it
> can look like:
>=20
> $owner=3Downer@server.com
>=20
> $description=3D=D3very long description=D3

RTFM (in this case gitweb/README).  gitweb.owner and gitweb.description
configuration variables in per-repository config.

>=20
> Or in xml form=C9

Aaaaaaaaaaaaaaaaaaaaaaaa...

%
"To be fair, there are uses for XML. On Halloween, for example."

     - Johannes Schindelin, on git@vger.kernel.org
%
>=20
>=20
> Yes, description file might become a bit more complicated in its
> layout. But, the benefits are obvious:
>=20
> - No need to support multiple lists/files
> - Bare repo carries all info about itself (together with =D0d feature=
 I
> described earlier).
>=20
> I this circumstances gitweb=D5s GITWEB_LIST will be only filter (only
> repo path is necessary to show/not show), and it seems that narrowed
> functionality here is a good thing...

GITWEB_LIST is meant for the case when you want to avoid scanning
filesystem for git repositories.  And you can filter out repositories
without using GITWEB_LIST (see documentation).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
