From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: git best strategy for two version development
Date: Sat, 8 Feb 2014 12:09:15 +0000 (UTC)
Message-ID: <loom.20140208T130440-803@post.gmane.org>
References: <52F59131.5000808@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 13:09:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC6jB-0002TV-0o
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 13:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaBHMJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 07:09:40 -0500
Received: from plane.gmane.org ([80.91.229.3]:37166 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbaBHMJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 07:09:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WC6j3-0002LZ-OC
	for git@vger.kernel.org; Sat, 08 Feb 2014 13:09:38 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 13:09:37 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 13:09:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241833>

Carlos Pereira <jose.carlos.pereira <at> ist.utl.pt> writes:

>=20
> Hello,
>=20
> I am a git and CVS newbie, I bought and red most of the excellent Pro=
=20
> Git book by Scott Chacon, but I still have a doubt. I have a package=20
> that I distribute in two versions differing only in one library:=20
> version_A uses this library, version_B uses my own code to replace it=
=2E=20
> For strategic reasons I want to keep it this way for the time being.=20
> Both versions have the same documentation, the same data files, and 9=
9%=20
> of the source code is the same (a few makefile changes, two additiona=
l=20
> files in version_B and some minor changes: a diff -r has only 170=20
> lines). The question is what is the best strategy to manage a situati=
on=20
> like this with git?
>=20
> Shall I maintain two different repositories? I don't think so...
>=20

If the changes are as small as you say, is it an option to use just one
branch but have two possible build configurations? That seems like the
easiest way to do it, in my opinion. E.g.:

    $ make LIB=3DversionA
    $ make LIB=3DversionB

Consider the above as pseudo-code, though. I don't know what build
system you use or even if your package is even something that is
"built". But you get the idea.

=C3=98sse
