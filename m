From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 09:41:36 -0400
Message-ID: <87myvgm8z3.fsf@graviton.dyn.troilus.org>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
	<Pine.LNX.4.64.0709211208440.28395@racer.site>
	<fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
	<20070921125337.GA28456@diana.vm.bytemark.co.uk>
	<fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Karl_Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Peter Stahlir" <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYilK-0005kx-Sa
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 15:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330AbXIUNlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757119AbXIUNlh
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 09:41:37 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:47813
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097AbXIUNlh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2007 09:41:37 -0400
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 365E889C059; Fri, 21 Sep 2007 09:41:36 -0400 (EDT)
In-Reply-To: <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com> (Peter Stahlir's message of "Fri\, 21 Sep 2007 15\:28\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58853>

Peter Stahlir writes:

> Telling git to handle -for example- deb archives and storing
> everything in a pack file would take advantage of redundancy across
> _all_ files.
> So the /usr/share/doc of all architectures could be compressed.
>
> Right?

You're proposing to trade off lots of CPU time in fetching many files
from a pack and making the package file -- paid every time someone
requests a package -- for at most 250 GB of space (cf Amdahl's law).

How long are your users willing to wait in exchange for 250 GB of
saved space?  How much CPU are you willing to spend for it?  Compare
those to the cost of a 300 GB hard drive (roughly $65).

There's also the cost to make git support the package format, and to
maintain that code going forward.  Those costs are also large.

Michael Poole
