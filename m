From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Fri, 22 Dec 2006 00:48:46 +0100
Organization: At home
Message-ID: <emf6bp$2l9$1@sea.gmane.org>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <200612101801.58247.jnareb@gmail.com> <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com> <200612110002.05847.jnareb@gmail.com> <20061211184105.GC17132@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612131414h25a75bf8h14b5a1731ea47afb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Dec 22 00:46:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxXcJ-0002Wk-Fi
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 00:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423132AbWLUXqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 18:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423134AbWLUXqY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 18:46:24 -0500
Received: from main.gmane.org ([80.91.229.2]:54630 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423132AbWLUXqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 18:46:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxXc8-0003n1-51
	for git@vger.kernel.org; Fri, 22 Dec 2006 00:46:16 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 00:46:16 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 00:46:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35094>

Catalin Marinas wrote:

> I'll try to add a wiki page with todo/wishlist ideas and prioritise
> those included before 1.0. Post 1.0, I'll try to look at changing the
> repository layout a bit to reduce the amount of metadata and also
> facilitate the support for transactions etc.

What about this page? Not found on
  http://wiki.procode.org/cgi-bin/wiki.cgi?action=index

By the way, it would be nice to be able to put in cover mail template the
following variables:
 * %(patches)s - list of patch names, each in one line, '* ' prefixed
 * %(patchesdescr)s - list of patch %(shortdescr)s, the first line
   of the patch description, shortlog-like word-wrapped, perhaps with,
   perhaps without [PATCH m/n] prefix.
 * %(diffstat) - diff statistics of first and last patch, only if
   there are no gaps in patches provided nor patch reordering
   (single patch, single range, or -a)
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
