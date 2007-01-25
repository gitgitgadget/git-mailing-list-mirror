From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Thu, 25 Jan 2007 16:05:36 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070125150536.GA8314@cepheus>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org> <45B8C032.7020004@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 16:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA6Aa-0000CU-28
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 16:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbXAYPFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 Jan 2007 10:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbXAYPFl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 10:05:41 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:47756 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965007AbXAYPFk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jan 2007 10:05:40 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HA6AV-0003h9-8U; Thu, 25 Jan 2007 16:05:39 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0PF5atx017728;
	Thu, 25 Jan 2007 16:05:36 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0PF5Z34017727;
	Thu, 25 Jan 2007 16:05:35 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45B8C032.7020004@fs.ei.tum.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37728>

Hi Simon,

Simon 'corecode' Schubert wrote:
> [1]: <http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs>, not 100% yet, bu=
t=20
> probably the best you can get at the moment.  i'm a perfectionist, so=
 i=20
> might never call it "done".
I don't know ruby nor hg, but I managed to clone your repo.  Now I'm
stuck with:

	zeisberg@cepheus:~/hsrc/fromcvs$ ruby1.8 fromcvs.rb=20
	fromcvs.rb:1:in `require': no such file to load -- rcsfile (LoadError)
	        from fromcvs.rb:1

`locate rcsfile` only returns /usr/share/man/man5/rcsfile.5.gz from the
rcs package.  `apt-cache search rcsfile` returns nothing.  (This is on
Debian testing/unstable.)  `apt-cache search rcs ruby` only returns

	aswiki - WikiWikiWeb clone (Wiki Engine) written in Ruby

Google didn't help me either.

Is there some documentation how to get that to work?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dthe+speed+of+light+in+m%2Fs
