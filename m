From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Invalid html output repo.or.cz (alt-git.git)
Date: Sat, 16 Feb 2008 22:12:17 +0100
Message-ID: <20080216211216.GL30676@schiele.dyndns.org>
References: <20080216130037.GA14571@auto.tuwien.ac.at> <m3lk5kbry3.fsf@localhost.localdomain>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EU5xizdSiRFq8q2U"
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 22:13:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQULA-00079d-3Y
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 22:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbYBPVMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbYBPVMW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 16:12:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:44597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbYBPVMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 16:12:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so83609ugc.16
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 13:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=T0h7dYFtMhUi0wiLmmYaLGQewVnrt5On4FkAwoM/O30=;
        b=jp45QLe7cqUhIbtV/t5m9NA3jFGEZWcofrm0J97jgYiPeF0cvggPMWpKvgM1vyZ9eMViWl1hKnmB9AYS/qEIjw/DcbE015OCxbCPuIsUvcUZpEGKII8V771GncyQErjjowVFAPXocXzbGlru16IcBkQVU78NIV87nJbPk/H3ZJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=UwtaSRTyUenUktBhz9ga4GY7WivUPBTAaa/6uFZrjOc8dqdOr2WrROcnGfiIoTGbFGREfAAKTGSzhumXe1tMnzEEq/cq2xKF7BJXKDR6VEaG/4rmb/RL+Of6C5ZO+rxuESfL3BhuFtf3JUZRvoXqbiS2iu32EmMEmfb/CI+TUqw=
Received: by 10.67.15.15 with SMTP id s15mr1089223ugi.27.1203196340003;
        Sat, 16 Feb 2008 13:12:20 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.105.53])
        by mx.google.com with ESMTPS id p38sm10591071fke.13.2008.02.16.13.12.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 13:12:19 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 2964A2A8D5; Sat, 16 Feb 2008 22:12:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3lk5kbry3.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74079>


--EU5xizdSiRFq8q2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2008 at 11:52:42AM -0800, Jakub Narebski wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>=20
> > http://repo.or.cz/w/alt-git.git?a=3Dshortlog
> >=20
> > fails to load in my Seamonkey browser (Debian stable):
> >=20
> > XML Parsing Error: not well-formed
> > Location: http://repo.or.cz/w/alt-git.git?a=3Dshortlog
> > Line Number 561, Column 33:<td><i><span title=3D"Uwe Kleine-K<span clas=
s=3D"cntrl">\e</span>,Av<span class=3D"cntrl">\e</span>(Bnig">Uwe Kleine ..=
=2E</span></i></td>
> > --------------------------------^
>=20
> It looks like gitweb uses esc_html instead of esc_param (or leaving it

Huh?  Isn't that the wrong escaping?  esc_param is for URLs not for XML
attributes in general, isn't it?

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--EU5xizdSiRFq8q2U
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHt1GwxcDFxyGNGNcRAuziAKCMyQ4xQw11hhc5DLNpkNsd+RFSDwCg00j3
yH4zh1cFvHn5N5cTH4EZgxI=
=SeUx
-----END PGP SIGNATURE-----

--EU5xizdSiRFq8q2U--
