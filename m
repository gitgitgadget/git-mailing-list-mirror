From: Simon Hausmann <simon@lst.de>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 08:19:11 +0200
Message-ID: <200709190819.12188.simon@lst.de>
References: <20070917193027.GA24282@old.davidb.org> <20070918233749.GA19533@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1787942.rEsDhzYc52";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 08:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXsrb-0007wB-Fw
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 08:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbXISGQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 02:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXISGQh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 02:16:37 -0400
Received: from verein.lst.de ([213.95.11.210]:34822 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbXISGQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 02:16:37 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l8J6GQA5021314
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Wed, 19 Sep 2007 08:16:30 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070918233749.GA19533@old.davidb.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58681>

--nextPart1787942.rEsDhzYc52
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 19 September 2007 01:37:49 David Brown wrote:
> On Mon, Sep 17, 2007 at 12:30:28PM -0700, David Brown wrote:
> > I'd like to track a lot of code living in a Perforce repository, so I've
> > been playing with 'git-p4.py'.  Is the one in the contrib/fast-import
> > directory the latest version, or is there a better place.
> >
> > So far, it is having a couple of problems:
> >
> >   - The commit comment is empty.  It doesn't seem to grab the Perforce
> >     description, and the user seems to be <a@b>.
> >
> >   - Every revision seems to check every file out of Perforce.  This means
> >     that for the directory I want, every revision is going to take about
> > 20 minutes.
>
> An additional problem:
>
>    - git-p4 doesn't preserve the execute permission bit from Perforce.

Hmm, can you paste the output of

	p4 fstat //path/in/depot/to/file/that/is/imported/incorrectly

? I'm interested in the type of the file that p4 reports.

FWIW it works for me ;-)

Thanks,
Simon

--nextPart1787942.rEsDhzYc52
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8L9gWXvMThJCpvIRAqaYAKDBA+4cRmP5/FxwPwaa+2DpzKK5CACg4/Q5
1snKKUwVHdeW2hnbK6PeL0c=
=KsPz
-----END PGP SIGNATURE-----

--nextPart1787942.rEsDhzYc52--
