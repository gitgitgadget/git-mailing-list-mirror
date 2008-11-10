From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 16:48:48 +0100
Message-ID: <871vxjoa3j.fsf@erwin.mina86.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	<bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
	<87hc6gjs7v.fsf@erwin.mina86.com>
	<alpine.DEB.1.00.0811101319570.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 16:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzZ25-0004PN-CL
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 16:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYKJPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbYKJPtI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 10:49:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:40384 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbYKJPtG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 10:49:06 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2353394fgg.17
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :x-url:x-pgp-fp:x-pgp:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:sender;
        bh=PfMzOYw+iF3Dz7tURtEjeYYECokTYPB8Cn2JdhVj4xU=;
        b=mVAi/A3bb68uZ3MKgJj3SU2hzjLrHxapMw2a/wXXlzzK0vq6w92DlVbkEugw9R2Zd8
         20mRKRxjgz6NX0S7tMWE9KIOCoCPMPUw3tklBDs7kQG5WJX9kMtFqOQ7pmcpq94p+BoE
         JFIGIQDFvmiAUKO/nT3MBTM8QnQDs8xX0CHaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:x-url:x-pgp-fp:x-pgp:date:in-reply-to
         :message-id:user-agent:mime-version:content-type:sender;
        b=Ec5wFRKjIxTvmtnlXm28k2Sr1M7Q98TFVDQCfMg2htQS05lB1ZQyRyzxtEWBaWcDq2
         1XRI9pVk1m+Qr5P7tAE9D3ERlerFmjeg0WpbqkEfB5biM4nH56sQ2s1qt5BvXYG2QmYs
         bXQZd1Zi+Vb/b+USlxrtU87lwft8UBUQBXQBI=
Received: by 10.181.61.2 with SMTP id o2mr2143514bkk.49.1226332143702;
        Mon, 10 Nov 2008 07:49:03 -0800 (PST)
Received: from erwin.piotrekn (cno208.neoplus.adsl.tpnet.pl [83.31.168.208])
        by mx.google.com with ESMTPS id l19sm10955446fgb.7.2008.11.10.07.49.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 07:49:02 -0800 (PST)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
In-Reply-To: <alpine.DEB.1.00.0811101319570.30769@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Mon, 10 Nov 2008 13:25:14 +0100
	(CET)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100526>

--=-=-=
Content-Transfer-Encoding: quoted-printable

> On Mon, 10 Nov 2008, Michal Nazarewicz wrote:
>> I would like the "$Id$" sequences to be updated automatically after a=20
>> commit (ie. without the need to check out).  (Besides I would prefer=20
>> $Date$ more but I can live with $Id$ I guess ;) ).

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> No, you don't.
>
> At least most likely you do not want that behavior.  Typically, you have=
=20
> the $Id$ stuff in released versions to indicate what revision that versio=
n=20
> came from even if the files are no longer in a Git repository.
>
> And you can have that without ever committing anything in-between, by=20
> using the export-subst attributes with git-archive.  Have a look at=20
> Documentation/gitattributes.txt (I agree it is underdocumented in=20
> git-archive.txt).

The thing is that for some repositories I don't distinguish anything
like a "release version" of files.  For instance, I have a repository
with my configuration files, and I want to be able to do

  scp emacs system-where-git-is-not-installed:.emacs

or attaching the file in an email without worrying about anything.
Instead, what you're describing would force me to do some voodoo magic
priory to sending the file.

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkYV+YACgkQUyzLALfG3x7dxgCfSS7RxZz3is9phDUdIqbbLiFP
e9UAmwemiFAoQMpX/bHrlyrDG/osWtAp
=7PS/
-----END PGP SIGNATURE-----
--=-=-=--
