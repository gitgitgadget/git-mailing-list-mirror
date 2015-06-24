From: =?ISO-8859-1?Q?V=EDctor_Mart=EDn_?= =?ISO-8859-1?Q?Hern=E1ndez?= 
	<vmartin@aliga.ieec.uab.es>
Subject: Re: Untracked files when git status executed on a new folder
Date: Wed, 24 Jun 2015 17:28:45 +0200
Message-ID: <1435159725.19750.7.camel@aliga.ieec.uab.es>
References: <1435072761.15867.38.camel@aliga.ieec.uab.es>
	 <20150623165453.GA9265@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?ISO-8859-1?Q?L=F6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 17:29:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7mcS-0000ic-TK
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 17:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbbFXP3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jun 2015 11:29:41 -0400
Received: from aliga.ieec.uab.es ([158.109.166.130]:49602 "EHLO aliga.ice.cat"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbbFXP3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 11:29:39 -0400
Received: by aliga.ice.cat (Postfix, from userid 65534)
	id 3438FB03; Wed, 24 Jun 2015 17:29:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	esparver.interna.ice.cat
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.2
Received: from vmartin01 (110.201.133.37.dynamic.jazztel.es [37.133.201.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by aliga.ice.cat (Postfix) with ESMTPSA id 8F09B8DB;
	Wed, 24 Jun 2015 17:29:28 +0200 (CEST)
In-Reply-To: <20150623165453.GA9265@leeloo.kyriasis.com>
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272560>

Hi all,
sorry for not having sent these informations in my first e-mail.
I'm working on a Debian Jessie laptop, with git version 2.1.4.=20
I watched the same behavior in a workmate's laptop which uses last
version of Ubuntu, but now I cannot contact him to get git version.

Afger "apt-get update" and "apg-get install --only-upgrade git", the
response is that I have the latest git version, what sounds strange to
me if you say you use version 2.4.4.


Thanks!!

V=C3=ADctor


=20

On Tue, 2015-06-23 at 18:54 +0200, Johannes L=C3=B6thberg wrote:
> On 23/06, V=C3=ADctor Mart=C3=ADn Hern=C3=A1ndez wrote:
> >Hi all.
> >Today I've had an unexpected behaviour that I'm not sure if is a bug=
 or
> >I'm not doing git best practices... (surely the latest...)
> >The sequence of actions is :
> >
> >1. create a new subfolder of my local repository branch
> >2. cd to this new folder, and create a new file
> >3. execute git status from the new folder
> >
> >Doing that, the new folder doesn't appear as untracked.
> >
> >4. cd ..
> >5. git status
> >In this case, the new folder appears.
> >
> >If I create a new folder on the same level that the new one created =
in
> >step 1, cd into it, and execute git status, the folder created in st=
ep 1
> >appears as untracked.
> >
>=20
> Can't reproduce on Git 2.4.4/Linux, which Git version and platform ar=
e=20
> you using?
>=20

--=20
---
V=C3=ADctor Mart=C3=ADn Hern=C3=A1ndez

R&D Software Engineer
Instituto de Ciencias del Espacio (ICE/CSIC), and=20
Institut d'Estudis Espacials de Catalunya (IEEC)

Campus UAB, Carrer de Can Magrans, s/n
08193  Bellaterra (Cerdanyola del Vall=C3=A8s) - Barcelona
Tel. : +34 93 586 8782
Web:   http://gwart.ice.cat/
