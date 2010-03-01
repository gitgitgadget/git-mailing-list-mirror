From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named distutils.core"
Date: Mon, 1 Mar 2010 17:04:10 +0000
Message-ID: <20100301170410.GG17508@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 18:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm92a-0001nN-EM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab0CAREN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:04:13 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:51661 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab0CAREM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:04:12 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.70)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1Nm92Q-00060b-KB; Mon, 01 Mar 2010 17:04:10 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 7DE7419546;
	Mon,  1 Mar 2010 17:04:10 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 71DBE7420E; Mon,  1 Mar 2010 17:04:10 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141332>

Okay, with --without-python it works now.
If it's not needed for most people, wouldn't it be
better that this would be the default?

Thanks!

Oliver


On Mon, Mar 01, 2010 at 11:15:41AM -0500, Todd Zullinger wrote:
> Oliver Kullmann wrote:
> > I've installed 1.6.6.2, but now when
> > installing 1.7.0.1 (same machine) I get
> >
> > make[3]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform/ExternalSources/builds/Git/git-1.7.0.1/perl'
> > make[2]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform/ExternalSources/builds/Git/git-1.7.0.1/perl'
> > make[2]: Entering directory `/home/csoliver/SAT-Algorithmen/OKplatform/ExternalSources/builds/Git/git-1.7.0.1/git_remote_helpers'
> > Traceback (most recent call last):
> >   File "setup.py", line 5, in ?
> >     from distutils.core import setup
> > ImportError: No module named distutils.core
> >
> >
> > I'm using
> >
> > make configure
> > sh ./configure --prefix=InstallDir
> > make all
> 
> If you have no need for the git_remote_helpers (and unless you are
> working on adding a git remote helper in python, I don't think you
> do), you can pass --without-python to configure.  I think that's the
> right way using configure, I use make directly and pass NO_PYTHON = 1
> for the time being.
> 
> -- 
> Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> There are no differences but differences of degree between different
> degrees of difference and no difference.
>     -- William James, under nitrous oxide; 1882
> 

-- 
Dr. Oliver Kullmann
Computer Science Department
Swansea University
Faraday Building, Singleton Park
Swansea SA2 8PP, UK
http://cs.swan.ac.uk/~csoliver/
