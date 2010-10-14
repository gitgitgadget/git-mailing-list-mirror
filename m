From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 03/11] vcs-svn: Read the preimage while applying deltas
Date: Fri, 15 Oct 2010 10:45:55 +1300
Message-ID: <1287092755.10477.9.camel@wilber>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
	 <20100716101352.GA14374@burratino> <20100809215719.GA4203@burratino>
	 <20100810125317.GB3921@kytes> <20101011023435.GA706@burratino>
	 <20101011040140.GC5649@burratino> <20101013091714.GA32608@burratino>
	 <20101013093037.GD32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 23:46:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Vcs-0002dZ-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 23:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab0JNVqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 17:46:08 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33724 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755993Ab0JNVqG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 17:46:06 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 31A1F21D340; Fri, 15 Oct 2010 10:46:04 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id E7E7021CB82;
	Fri, 15 Oct 2010 10:45:55 +1300 (NZDT)
In-Reply-To: <20101013093037.GD32608@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159078>

On Wed, 2010-10-13 at 04:30 -0500, Jonathan Nieder wrote:
> It occurs to me that Sam Vilain may well have something valuable to
> say about this series, having implemented something similar[1].
>=20
> Sam, this series adds an svndiff0 parser for git to use in parsing
> v3 dumps (which are way easier to produce with remote access to an
> svn repository than v2 dumps).  The beginning of the series is at [2]=
,
> though that cover letter is out of date: now, modulo any new bugs
> I've introduced with this reroll, it is known to successfully apply
> all the deltas involved in a complete dump of the ASF repo.

> [1] http://search.cpan.org/~samv/Parse-SVNDiff-0.03/lib/Parse/SVNDiff=
=2Epm

All I did was make the module lazy - version 0.02 was by =E5=94=90=E9=B3=
=B3, any
detailed knowledge I had of the binary format fell out of my head prett=
y
quickly :-)

Sam
