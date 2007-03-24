From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 19:55:17 +0100
Message-ID: <20070324185517.GA10876@diana.vm.bytemark.co.uk>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk> <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070324064130.GC25863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 24 19:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVBP2-0003sg-R3
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 19:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932817AbXCXSzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Mar 2007 14:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbXCXSzq
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 14:55:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4883 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbXCXSzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 14:55:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HVBOX-0002qy-00; Sat, 24 Mar 2007 18:55:17 +0000
Content-Disposition: inline
In-Reply-To: <20070324064130.GC25863@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43011>

On 2007-03-24 02:41:30 -0400, Shawn O. Pearce wrote:

> That is not a bad idea at all.  We could easily do
>
>   svn:executable -> (mode & 0111);
>   svn:ignore -> .gitignore;
>
> I'm sure there are others, but they are the only two Karl mentioned,
> and that I know of off the top of my head. ;-)

These are the two that git-svnimport handles. I don't think it knows
about any other subversion properties.

There is a slight problem with directly converting between svn:ignore
and .gitignore, though: the semantics are only almost the same.
Specifically, git's ignore patters are recursive (applies to
subdirectories) while subversion's are not. But it's not a big
problem.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
