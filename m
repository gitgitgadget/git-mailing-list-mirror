From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 07:40:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260737170.14781@racer.site>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
 <7vps2fc196.fsf@assigned-by-dhcp.cox.net> <20070726031838.GO32566@spearce.org>
 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707260614500.14781@racer.site>
 <46A8378A.6050201@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDx1E-0001Ng-Vg
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbXGZGkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbXGZGkO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:40:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:42028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754712AbXGZGkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:40:13 -0400
Received: (qmail invoked by alias); 26 Jul 2007 06:40:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 26 Jul 2007 08:40:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qpCt7ZsBqzCrneaGLSi04EHDe2WYP9SabNgPHbZ
	rDvJGf53NQPouO
X-X-Sender: gene099@racer.site
In-Reply-To: <46A8378A.6050201@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53785>

Hi,

[Funny, you quoted me, but culled _me_ from the Cc: list]

On Wed, 25 Jul 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin wrote:
> >> If that is the case, "Git for Windows" probably should package MSYS as 
> >> part of it, I would think, to match the expectation of the users there.  
> >> I know two Johannes'es and Han-Wen spent quite a lot of effort on 
> >> Windows port and packaging, but perhaps that little (well, I should not 
> >> be judging if that is a little or huge, as I do not do Windows) 
> >> finishing touch would make Windows users much happier?
> > 
> > Windows users are only happy when they can bug developers.
> > 
> > Seriously again, the biggest problem with Han-Wen's installer was that it 
> > insists on cross-compiling _all_ the packages.  This makes it easy for 
> > Han-Wen to upgrade packages and compile the thing on Linux in one go.  
> > However, it never worked with bash, and I could not fix it: I can read 
> > Python, but not _that_ Python.
> > 
> 
> The problem is not really the python.

For me, it is.  Probably you know by now that I am not really a fan of 
Python, mainly because people can write unelegant code which looks 
elegant.

> If you supply me with a shell script that will x-compile bash, I'll 
> hapily code the python spec. IMO the real problem is that bash is a unix 
> shell (tied to unix internals) and therefore, compiling it for something 
> as horrid as windows is far from trivial.

Will do.

Did you succeed in adding perl?  It is not that important, because I plan 
to make git-gui the main user interface with this installer.  But Junio 
keeps adding Perl scripts (ATM add -i and remote) that I have to convert 
later...

Ciao,
Dscho
