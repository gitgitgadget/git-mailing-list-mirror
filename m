From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: What is the best way to convert a multi module CVS repository
	to git?
Date: Thu, 14 Jan 2010 21:52:06 +0100
Message-ID: <20100114205157.GA96135@book.hvoigt.net>
References: <20100104155322.GC12195@atpcttvc.global-intra.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 21:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVWfx-0003AE-7J
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 21:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0ANUwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 15:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646Ab0ANUwK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 15:52:10 -0500
Received: from darksea.de ([83.133.111.250]:44404 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752591Ab0ANUwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 15:52:09 -0500
Received: (qmail 10785 invoked from network); 14 Jan 2010 21:52:05 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Jan 2010 21:52:05 +0100
Content-Disposition: inline
In-Reply-To: <20100104155322.GC12195@atpcttvc.global-intra.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137024>

On Mon, Jan 04, 2010 at 04:53:22PM +0100, Wolfgang.Liebich@siemens-enterprise.com wrote:
> Hi,
> I have inherited a rather big, old, multi-module CVS repository which I
> want to convert to GIT.
> Most of the CVS modules do belong to one project now, i.e. the
> separation into multiple modules is something of a historical accident
> now. This means it does not make sense to put each CVS module into an
> own GIT project and use submodules.
> Furthermore the conversion will be one-way, i.e. afterwards the CVS repo
> will be shutdown forever and moved to offline storage. Incremental
> conversion is therefore not an issue.
> If I need one day to convert everything (the repo is about 3GB), so be
> it - the most important feature to me is correctness (I do NOT want to
> have to run manual verifications for N days/weeks/months, just to verify
> that everything was converted), and ideally even the possibility of
> re-creating the history of files which were moved across directories
> (this HAS happened sometimes - I did not fiddle around with the RCS
> files, but used straight rm+add, and accepted the loss of history forced
> on me by CVS).
> 
> What is the best (i.e. most trustworthy) method of conversion? For now
> it seems to me that cvs2git (the ...2git companion to cvs2svn) is the
> best choice (because it can handle multi-module projects in a sane way)
> - but I'm open to suggestions!

As far as I know cvs2git provides the technically most correct
conversion out there. Nevertheless I would suggest to try parsecvs. It
is kind of hard to set up but has a more intuitive heuristic for tags
although not strictly correct.

cheers Heiko
