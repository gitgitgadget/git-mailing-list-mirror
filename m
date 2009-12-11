From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 13:51:37 +0100
Message-ID: <200912111351.38695.trast@student.ethz.ch>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <4B222289.6000004@drmicha.warpmail.net> <20091211110944.GB19232@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 11 13:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ4yH-0002kW-ST
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 13:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbZLKMvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756091AbZLKMve
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 07:51:34 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:13315 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584AbZLKMve convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 07:51:34 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 11 Dec
 2009 13:51:39 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 11 Dec
 2009 13:51:39 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.81; x86_64; ; )
In-Reply-To: <20091211110944.GB19232@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135085>

Bj=F6rn Steinbrink wrote:
> On 2009.12.11 11:44:25 +0100, Michael J Gruber wrote:
> > Jakub Narebski venit, vidit, dixit 11.12.2009 02:33:
> > >  $ echo -e "100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1\tfo=
o" |=20
> > >    git update-index --index-info
> >=20
> > Yeah, if we knew that sha1...
>=20
> Hm, isn't that "$(git merge-base HEAD MERGE_HEAD):foo"?

Not if the merge-base isn't unique and you're using the recursive
strategy, IIUC.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
