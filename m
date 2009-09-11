From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 05:15:19 +0200
Message-ID: <20090911031519.GA6385@atjola.homenet>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <m3fxavvl5k.fsf@localhost.localdomain>
 <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com>
 <200909101850.26109.jnareb@gmail.com>
 <7vbpliaaxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 05:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlwbt-0006aW-El
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 05:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbZIKDPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 23:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbZIKDPX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 23:15:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:37628 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752565AbZIKDPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 23:15:22 -0400
Received: (qmail invoked by alias); 11 Sep 2009 03:15:24 -0000
Received: from i59F57339.versanet.de (EHLO atjola.homenet) [89.245.115.57]
  by mail.gmx.net (mp007) with SMTP; 11 Sep 2009 05:15:24 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX187OtpMG0g7PkKJLu7ZuB7n74CFskrBf02pc4DbSA
	wSODBsENuxU/Ec
Content-Disposition: inline
In-Reply-To: <7vbpliaaxo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128167>

On 2009.09.10 11:53:23 -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > First, it would be consistent with how ordinary archivers such as t=
ar
> > or zip are used, where you have to specify list of files to archive
> > (in our case this list is HEAD).  Second, I'd rather not accidental=
ly
> > dump binary to terminal: "git archive [HEAD]" dumps archive to stan=
dard
> > output.
>=20
> So does "cat".  I do not agree with your second point.

"cat $some_binary" does, not just "cat". I guess Jakub's point was that
a command without arguments shouldn't just put some binary crap onto
your screen. Of course, "git archive HEAD" still does that, but I kind
of he where he's coming from, being one of those that tends to run
"$some_command" without arguments, just to see if it shows me some sort
of short help.

Bj=F6rn
