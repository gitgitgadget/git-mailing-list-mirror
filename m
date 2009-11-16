From: Alejandro Riveira <ariveira@gmail.com>
Subject: Re: git gc - out of memory
Date: Mon, 16 Nov 2009 23:10:09 +0000 (UTC)
Message-ID: <hdsm4h$s2v$1@ger.gmane.org>
References: <df1390cc0911141126w1a0c5691p83885053a73f829@mail.gmail.com>
	<hdp44d$4ml$1@ger.gmane.org>
	<df1390cc0911151033h2825053fxafe5bb2bb788fbb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 00:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAAic-0002IJ-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 00:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbZKPXKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 18:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZKPXKb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 18:10:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:51404 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbZKPXKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 18:10:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NAAiO-0002Bw-G0
	for git@vger.kernel.org; Tue, 17 Nov 2009 00:10:32 +0100
Received: from 139.red-83-44-221.dynamicip.rima-tde.net ([83.44.221.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 00:10:32 +0100
Received: from ariveira by 139.red-83-44-221.dynamicip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 00:10:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 139.red-83-44-221.dynamicip.rima-tde.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133035>

El Sun, 15 Nov 2009 19:33:27 +0100, Simon Strandgaard escribi=C3=B3:


>>
>> run =C2=AB git repack -adf --window=3Dmemory =C2=BB on the repo wher=
e memory is
>> escaled apropiately for your machine ?
>=20
> Thank you Alejandro, it now works!

 ell glad it does becouse i mad a typo ...

>=20
> I think the default is 10, so I tried with window=3D5 and it complete=
d a
> full repack.

 I was trying to make you use --window-memory=3D[memory] not --window=3D=
 ;P

>=20

>=20
> Now that it works..
> Should I report the original issue as a bug somewhere? e.g. malloc
> failed sounds like a bug.

 This is the right place. Just wait for someone more knowledgeable than
me ...

>=20
>=20
>=20
> Kind regards
> Simon Strandgaard - http://gdtoolbox.com/
