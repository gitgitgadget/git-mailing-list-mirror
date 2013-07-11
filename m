From: Andreas Krey <a.krey@gmx.de>
Subject: Priming git clone with a local repo?
Date: Thu, 11 Jul 2013 11:35:32 +0200
Message-ID: <20130711093532.GA28255@inner.h.apk.li>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au> <20130708073041.GA25072@sigill.intra.peff.net> <CACsJy8Chmm0=wDV4NQ+4Gh7KZYpbd9qkb=pNzkPeG-a-xiwVmw@mail.gmail.com> <7vbo6d2j2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 11 11:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxDHq-0003tk-8b
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 11:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab3GKJfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 05:35:38 -0400
Received: from continuum.iocl.org ([217.140.74.2]:37858 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab3GKJfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 05:35:37 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r6B9ZWA28780;
	Thu, 11 Jul 2013 11:35:32 +0200
Content-Disposition: inline
In-Reply-To: <7vbo6d2j2e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230079>

Hi, dear listers,

I'm wondering if there is (or will be) a way of doing almost

  git clone --reference localrepo host:canonrep

Basically, I don't want the implications of --reference but still the
performance advantages of reusing local objects/pack files. I probably
have to go and first do a

  git clone -s -n localrepo canonrepo

and then go into canonrepo, fix up the remote, fetch, and properly
reset the local branch. Is there an easier way of doing a
--reference-but-hardlink-objects-instead-of-setting-alternate
within git? Or implementing it?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
