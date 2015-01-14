From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Wed, 14 Jan 2015 15:39:46 +0100
Message-ID: <20150114143946.GE13247@inner.h.apk.li>
References: <20150114115130.GA5677@inner.h.apk.li> <20150114124936.GC30383@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 15:39:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBP6x-0004Ye-St
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 15:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbbANOjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 09:39:52 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55721 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbANOjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 09:39:51 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0EEdkG11629;
	Wed, 14 Jan 2015 15:39:46 +0100
Content-Disposition: inline
In-Reply-To: <20150114124936.GC30383@peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262388>

On Wed, 14 Jan 2015 07:49:36 +0000, Jeff King wrote:
...
> You don't need the "-f" here. Just "git repack -ad" should be enough
> (and the "-f" probably makes it _way_ slower).

Indeed, factor four.

However, my expectation is that a repack -ad will remove all the
old pack files, as what is in there is either referenced and put
into the new pack, or dropped => there should be a single pack file
afterwards.

This is not the case. :-( (Done only with 1.8.2 due to
lack of compilers for this box.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
