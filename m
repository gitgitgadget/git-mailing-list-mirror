From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 19:02:08 +0100
Message-ID: <20090104180208.GA12298@chistera.yi.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu> <1a69a9d80901040021i1dae2c6j7337cf57eed6476a@mail.gmail.com> <quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Arnaud Lacombe <lacombar@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Jan 04 19:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJXK4-0007E3-OM
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 19:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbZADSCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 13:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbZADSCO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 13:02:14 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3434
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbZADSCN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 13:02:13 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 32B33801C025;
	Sun,  4 Jan 2009 19:02:11 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LJXIe-0003GJ-Uu; Sun, 04 Jan 2009 19:02:08 +0100
Content-Disposition: inline
In-Reply-To: <quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104531>

* Karl Chen [Sun, 04 Jan 2009 04:40:51 -0800]:

>     Arnaud> $ git branch | awk '/^\*/ {print $2}'

> Yet another addition to the list of ways to pipeline it, this one
> probably the shortest :)

Heh, if we're playing golf:

              $ git branch | sed -n 's/^\* //p'

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Que no te vendan amor sin espinas
                -- Joaqu=C3=ADn Sabina, Noches de boda
