From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Consistency question
Date: Wed, 15 Jan 2014 13:44:34 +0100
Message-ID: <20140115124434.GA27030@inner.h.apk.li>
References: <8761pl8raj.fsf@fencepost.gnu.org> <20140115111330.GH14335@sigill.intra.peff.net> <871u098ocy.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jan 15 13:44:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Pq1-0006Cx-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 13:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbaAOMot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 07:44:49 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55622 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaAOMos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 07:44:48 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s0FCiY327549;
	Wed, 15 Jan 2014 13:44:34 +0100
Content-Disposition: inline
In-Reply-To: <871u098ocy.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240466>

On Wed, 15 Jan 2014 12:40:29 +0000, David Kastrup wrote:
...
> With a single root, "depth" helps a lot.  When looking for a common
> parent of a number of commits, you first shorten all ancestries to the
> same size and then you can look for the point of convergence in
> lockstep.

Hmm, how about traversing from all the start commits downwards
simultaneously, noting which start you say each commit from, and stopping
when you have a commit carrying all start labels?

I don't quite see how the same size plus lockstep works out (but the
'same size' part is possibly the same as my 'concurrent traversal').

> But didn't git forego the "single root" requirement in its commit DAG at
> some point of time?

About at the beginning, I guess. Nothing in the data model ever required it?

> ... The rest is just idle curiosity.

Me too, mostly. I may have to do some traversal for tree/dag painting.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
