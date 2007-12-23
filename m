From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Sun, 23 Dec 2007 10:01:45 +0100
Message-ID: <20071223090145.GB3563@efreet.light.src>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu> <m3tzmgpzlu.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 10:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Mis-0007mN-IV
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 10:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbXLWJBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 04:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXLWJBu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 04:01:50 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:49601 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbXLWJBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 04:01:49 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id BBFDB57433;
	Sun, 23 Dec 2007 10:01:48 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id qylh5gR8BZjW; Sun, 23 Dec 2007 10:01:46 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 51CFD5737E;
	Sun, 23 Dec 2007 10:01:46 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J6MiP-0006rP-Pn; Sun, 23 Dec 2007 10:01:45 +0100
Content-Disposition: inline
In-Reply-To: <m3tzmgpzlu.fsf@roke.D-201>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69171>

On Mon, Dec 17, 2007 at 17:21:08 -0800, Jakub Narebski wrote:
> [...]
> Second, the default autoconf macro AC_PROG_INSTALL *requires* that
> there is BSD-compatible `install' program (as 'install-sh' or
> 'install.sh') in the sources.  Adding such script is (I think) not a
> problem; finding minimal portable[*1*] script is.  So if you know
> one...

What's wrong with the one that comes with automake? It should be portable
the insane way ./configure script is -- which should be at least as much as
git -- and the license is compatible (MIT/X).

> Footnotes:
> ----------
> [*1*] By "portable" I mean here 'git portable', i.e. requiring only
> those shell constructs/features that git require, not necessary
> insanelt portable the way ./configure script is.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
