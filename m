From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: /etc/gitconfig
Date: Wed, 14 Feb 2007 11:40:52 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070214104052.GA9047@informatik.uni-freiburg.de>
References: <200702140909.28369.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 11:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHHaa-00015p-Gy
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 11:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbXBNKlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Feb 2007 05:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbXBNKlK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 05:41:10 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:61269 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932198AbXBNKk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Feb 2007 05:40:57 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HHHZI-0004iR-B3; Wed, 14 Feb 2007 11:40:56 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l1EAerXl009155;
	Wed, 14 Feb 2007 11:40:53 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l1EAeqOs009154;
	Wed, 14 Feb 2007 11:40:52 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200702140909.28369.andyparkins@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39631>

Andy Parkins wrote:
> With the release of 1.5.0 I added legacyheaders=3Dfalse and=20
> usedelatbaseoffset=3Dtrue to my repositories.
>=20
> While doing that though, it felt wrong to be editing every single con=
fig.  Is=20
> there a justification for having three config files?
>=20
>  /etc/gitconfig
>  $HOME/.gitconfig
>  $GIT_DIR/config
>=20
> With /etc/gitconfig coming in at lowest priority?
I didn't try it, but maybe you could place your desired config to
/usr/share/git-core/templates/config and then at least newly created
repos get it?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc -e "5735816763073014741799356604682P"
