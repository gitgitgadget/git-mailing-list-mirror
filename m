From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bare init and gitweb
Date: Tue, 17 Jun 2008 13:27:51 -0700 (PDT)
Message-ID: <m3bq1zolh6.fsf@localhost.localdomain>
References: <g38t49$lgr$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Martin_R=F6hricht?= <public@felicis.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 22:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8hnO-0003vi-GY
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 22:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbYFQU1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYFQU1z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 16:27:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24588 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbYFQU1y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2008 16:27:54 -0400
Received: by ug-out-1314.google.com with SMTP id h2so651894ugf.16
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=rUgzaYcGvFxBp00L7lroF1P4IdYo9KvA6i6riBPC5SQ=;
        b=aGR5pjVk/vJODKCh/qfvCM1NA5wOOAxmjmKVKM5keZhCyCGIEZ2JsRXoKImcfbvqIN
         iu+TJO8HTzd4VRVdnZxRad74DY8/sR+hoElBCbHFoKkFFUm3CbJjluVw814bafE5TD7R
         qknVshhchdij+a9rqL1cwFVi3UQgbTO+hiO2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=o2Z81UNlVkxxLGGF4KjQpjekaLjvfigFp57o24E6NAD7ArIkxrsU4YQ8r1exP74U0A
         fJt73ktWpcag5r+mBMa61HtmoV7nngzRQZt2w4QVUwLKpNKBBMfhxwmcUzkwzEI6LZYa
         eBdtfawkrrYVLukpVy4M1SpWt17GTYbZI3uTw=
Received: by 10.210.65.2 with SMTP id n2mr8148493eba.145.1213734472610;
        Tue, 17 Jun 2008 13:27:52 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.204.69])
        by mx.google.com with ESMTPS id z40sm11546791ikz.7.2008.06.17.13.27.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 13:27:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5HKRp9E003473;
	Tue, 17 Jun 2008 22:27:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5HKRnlf003470;
	Tue, 17 Jun 2008 22:27:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <g38t49$lgr$3@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85320>

Martin R=F6hricht <public@felicis.org> writes:

> in order to use git for some projects via WebDAV I followed the
> instructions given in
> http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-serve=
r-over-http.txt

[...]
> Whenever I clone the server's repository somewhere else, I get the
> README file as expected. But when I use gitweb to show me the content=
s
> of the repository, all I get is this:
>=20
> -------------------------8<------------------------
> projects /
>=20
> 403 Forbidden - No projects found
> -------------------------8<------------------------
>=20
> The projectroot variable within /etc/gitweb.conf points to my
> ~/gitrepo.git, and whenever I use "git init", add and commit some
> files locally on the server I see the contents as expected by using
> gitweb, but never by using a repository created with "git --bare init=
".
>=20
> Can someone help me out? I would really appreciate any help.

The $projectroot variable should point to the _common root_ of all
projects, in your case it could be one directory up your repository,
for example

  our $projectroot =3D /home/nick

not

  our $projectroot =3D /home/nick/gitrepo.git

(and '~' expansion would not work).

gitweb/README and gitweb/INSTALL should explain it in more detail.
The documentation you mentioned IIUC is for people who know how to
setup gitweb already
  http://repo.or.cz/w/git.git?a=3Dblob;f=3Dgitweb/INSTALL;hb=3DHEAD
  http://repo.or.cz/w/git.git?a=3Dblob;f=3Dgitweb/README;hb=3DHEAD

--=20
Jakub Narebski
Poland
ShadeHawk on #git
