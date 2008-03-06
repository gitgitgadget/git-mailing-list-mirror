From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: "bash: git-upload-pack: command not found" ??
Date: Thu, 6 Mar 2008 13:54:56 +0000
Message-ID: <20080306135456.GG925@cs-wsok.swansea.ac.uk>
References: <20080306110600.GA925@cs-wsok.swansea.ac.uk> <20080306124710.GA10266@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 14:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXGZL-00083L-R7
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 14:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759228AbYCFNzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 08:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbYCFNzA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 08:55:00 -0500
Received: from mhs.swan.ac.uk ([137.44.1.33]:44567 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758936AbYCFNy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 08:54:58 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1JXGYi-0000FK-H5; Thu, 06 Mar 2008 13:54:56 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 5D12ADAF2B;
	Thu,  6 Mar 2008 13:54:56 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 4A834741BA; Thu,  6 Mar 2008 13:54:56 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20080306124710.GA10266@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76392>

On Thu, Mar 06, 2008 at 01:47:10PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> Oliver Kullmann wrote:
> > Hello,
> >=20
> > when using
> >=20
> > Transitional> git pull ssh://user@host.xz/~/path/to/Transitional ma=
ster
> >=20
> > on a remote machine I get
> >=20
> > Password:
> > bash: git-upload-pack: command not found
> > fatal: The remote end hung up unexpectedly
> Where is git-upload-pack on the server machine?

In the same directory as git, in /usr/local/bin/

>  Where do you set your
> PATH to include $(basedir git-upload-pack).

Hm, it's set "nowhere". Likely that's the problem: For a=20
standard-user the path includes the git-directory, but not
for the git-user.

>  Does=20
>=20
> 	git pull --upload-pack /path/to/git-upload-pack ...
>=20
> help?
>

Yes! That solves it (I won't fiddle around with the path settings,
since I have also local installs etc., and that additional specificatio=
n
does the job).

Thanks!

Oliver
=20
--=20
Dr. Oliver Kullmann
Computer Science Department
Swansea University
=46araday Building, Singleton Park
Swansea SA2 8PP, UK
http://cs.swan.ac.uk/~csoliver/
