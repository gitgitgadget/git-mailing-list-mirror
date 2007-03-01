From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Summer of Code 2007
Date: Thu, 01 Mar 2007 03:08:01 +0100
Organization: At home
Message-ID: <es5cdl$nhn$1@sea.gmane.org>
References: <20070225075917.GC1676@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 03:06:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMagV-0000uy-2s
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 03:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbXCACGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 21:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbXCACGE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 21:06:04 -0500
Received: from main.gmane.org ([80.91.229.2]:57723 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932425AbXCACGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 21:06:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMag4-0005Vj-6f
	for git@vger.kernel.org; Thu, 01 Mar 2007 03:05:52 +0100
Received: from host-81-190-30-11.torun.mm.pl ([81.190.30.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 03:05:52 +0100
Received: from jnareb by host-81-190-30-11.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 03:05:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-30-11.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41031>

Shawn O. Pearce wrote:

> ShadeHawk and robinr brought up Google's Summer of Code on #git the
> other day.  I had also been thinking about seeing if we cannot get
> Git involved with SoC, so here goes... ;-)
> 
> The application deadline for organizations is March 12th.
> The earliest that we can submit an application is March 5th, so we
> still have time to kick ideas around and see if the community is
> interested in participating in SoC.

Well, certainly there is a number of areas to work on. This includes:
 * much talked on (and even with two different independent
   implementations) _subproject (submodule) support_, which would
   certainly help using git for large modular projects like KDE,
   Mozilla or distributions.
 * lightweight checkout aka. .gitlink idea, to have file which
   would point to object directory, refs directory, index file
   and current branch file. It could help submodule support.
 * partial/sparse checkouts, where you can checkout for example
   only Documentation directory, work on it, but commit full tree.
   Sometimes it better suits than using submodules
 * gitweb caching and other gitweb improvements: bringing together
   all gitweb implementations. Perhaps gitweb maintainer could
   come of it. Or at least gitweb admin for kernel.org
 * builtinification and libification
 * lazy clone aka remote alternates, if it can be done at all...
 
> Google's FAQ has a lot of details, but the important part which
> lists what should be included in an application can be found here:
> 
>   http://code.google.com/support/bin/answer.py?answer=60303&topic=10727
> 
> I don't know how the great SoC filter works for organizations,
> but last year's list (found at http://code.google.com/soc/) has a
> number of projects listed on it that are actively using Git for their
> version control.  It would be nice if the SoC program was able to
> benefit multiple projects in one shot, by helping to improve Git. :)

The other SCM which participated in SOC2006, Subversion and Monotone,
both are backed by organizations. Mercurial didn't participate, but has
a page with ideas for SOC2006.

If Eclipse is to participate, perhaps one of Eclipse projects could be
git plugin for Eclipse, or Java implementation of Git (perhaps with some
Java improvements :-), or perhaps some generic distributed SCM plugin
framework.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
