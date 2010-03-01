From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: error when installing 1.7.0.1: "ImportError: No module named distutils.core"
Date: Mon, 1 Mar 2010 14:40:00 +0000
Message-ID: <20100301144000.GA17135@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 16:08:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm7Ep-0008H8-D4
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 16:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab0CAPIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 10:08:44 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:41694 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab0CAPIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 10:08:43 -0500
X-Greylist: delayed 1720 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2010 10:08:43 EST
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.70)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1Nm6mu-0002F9-TI; Mon, 01 Mar 2010 14:40:01 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id D6A5B196B7;
	Mon,  1 Mar 2010 14:40:00 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id C7D147420E; Mon,  1 Mar 2010 14:40:00 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141322>

Hello,

I've installed 1.6.6.2, but now when
installing 1.7.0.1 (same machine) I get

make[3]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform/ExternalSources/builds/Git/git-1.7.0.1/perl'
make[2]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform/ExternalSources/builds/Git/git-1.7.0.1/perl'
make[2]: Entering directory `/home/csoliver/SAT-Algorithmen/OKplatform/ExternalSources/builds/Git/git-1.7.0.1/git_remote_helpers'
Traceback (most recent call last):
  File "setup.py", line 5, in ?
    from distutils.core import setup
ImportError: No module named distutils.core


I'm using

make configure
sh ./configure --prefix=InstallDir
make all

I've checked the README and INSTALL file, but I don't see that there are new
requirements? (That is not regarding doc.)

Oliver
