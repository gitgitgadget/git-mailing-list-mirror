From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 19:03:57 +0200
Message-ID: <200610211903.57655.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <ehd5u7$c5g$1@sea.gmane.org> <453A513B.1070006@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 19:03:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKGG-00075e-QZ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993139AbWJURDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 13:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993160AbWJURDt
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:03:49 -0400
Received: from qb-out-0506.google.com ([72.14.204.232]:51822 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993139AbWJURDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 13:03:48 -0400
Received: by qb-out-0506.google.com with SMTP id p36so279211qba
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 10:03:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fbOixSCP/ZsUGhK9FSEr1gb+cNA4VuX7ENPlDSiDE3T8zDTGlCE5X3MZkpuqe+rpZaD+KvI5MLpA2XUIAZqvMN4TvQZb6ZAQsR2Wz3TOJ2yReLmevxmfTdk1Yji1+pOk1hvX67vvB7rSRV7B5i+ZgyXvWmQtj+S5KalHNYtS4Dk=
Received: by 10.66.216.20 with SMTP id o20mr4033786ugg;
        Sat, 21 Oct 2006 10:03:47 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 34sm101213uga.2006.10.21.10.03.46;
        Sat, 21 Oct 2006 10:03:47 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453A513B.1070006@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29638>

Aaron Bentley wrote:
> AIUI, that's not what Tim  wants. =A0He wants to intermix files from
> different repos in the same directory.
>=20
> i.e.
>=20
> project/file-1
> project/file-2
> project/.git-1
> project/.git-2
>=20
> So file-1 would be in the .git-1 repository, but file-2 would be
> in the .git-2 repository.

Possible (as I said), although it would screw up automatic repository=20
detection. So you would have to say "git --git-dir=3D.git-1 commit -a"
or "GIT_DIR=3D.git-2 git log -p; git diff; ...", i.e. specify repo
for each command.

Of course you would have to hide repositories from each other,
and probably it would be better to hide files provided by other
repository.
--=20
Jakub Narebski
Poland
