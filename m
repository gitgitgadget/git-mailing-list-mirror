From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: Re: Bug?: import-tars misbehaves on Subversion tarballs
Date: Tue, 24 Apr 2007 10:25:40 +0200
Message-ID: <3BF34FC9-BE89-4A5B-9AC6-57F61C464395@zvpunry.de>
References: <20070424073907.GA22121@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 11:14:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgH6U-00084L-K0
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 11:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXDXJOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbXDXJOT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 05:14:19 -0400
Received: from mx01.ap-wdsl.de ([88.198.184.82]:41220 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082AbXDXJOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 05:14:15 -0400
X-Greylist: delayed 2897 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2007 05:14:15 EDT
In-Reply-To: <20070424073907.GA22121@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45434>

Hi,

Am 24.04.2007 um 09:39 schrieb Karl Hasselstr=F6m:

> import-tars behaves very oddly when I try to import the Subversion
> tarballs. (For example,
> http://subversion.tigris.org/downloads/subversion-1.4.3.tar.bz2
> triggers this problem.) It creates two toplevel directories,
> subversion-1.4.3 and subversion-1.4.3subversion. The former seems to
> contain at least almost all files; the latter has only a handful of
> files, all with very long names.
I looked at this tarball with midnight commander (under MacOS X) and =20
i saw 2 directories, subversion/ and subversion-1.4.3/. Then i looked =20
at it with GNU tar (1.14) and saw only subversion-1.4.3/.


> Could it simply be that import-tars can't handle long filenames
> somehow? (This is pure speculation, since I know absolutely nothing
> about the tar format.)
I don't know, but mc does the same thing. I'll look at it later (i =20
have more time at 18:00 +0200).


bye