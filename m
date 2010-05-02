From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 2 May 2010 19:23:50 -0400
Message-ID: <19422.2438.637578.793734@winooski.ccs.neu.edu>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
	<20100502181854.GC16051@progeny.tock>
	<19421.54064.178345.489772@winooski.ccs.neu.edu>
	<20100502202943.GB16746@progeny.tock>
	<m31vdugj2t.fsf@localhost.localdomain>
	<19421.59529.849850.968565@winooski.ccs.neu.edu>
	<7vwrvlucls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 01:24:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8iW4-00016K-At
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 01:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727Ab0EBXXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 19:23:54 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:37786 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757401Ab0EBXXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 19:23:53 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O8iVq-0002s9-Lf; Sun, 02 May 2010 19:23:50 -0400
In-Reply-To: <7vwrvlucls.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146206>

On May  2, Junio C Hamano wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > Good -- the first paragraph is what I thought it would do, the
> > second makes it even better.  Perhaps it would be nice to show
> > such manual reoslutions from one parent, but I think that that
> > certainly qualifies as stuff that is much less interesting than
> > work that was done to combine content inside a file, or one of
> > those evil merges.
> 
> You need to be careful here.
> 
> If you see a conflicted hunk and the result ends up being the same
> from one of the parents in that area, then the _result_ is trivial
> as far as the merge (and hence --cc) is concerned, even though you
> may have spent considerable braincycle to stare at the conflict to
> decide that taking a change from one side is the right thing to do.

Yes, that's clear to me now -- thanks.


> You keep saying "manual resolutions", but --cc doesn't have much to
> do with the resolution being manual, nor if the initial mechanical
> merge attempt left conflict markers.

(Right, my original terminology was broken...)


> You would need to redo the merge to find that out, and it can be
> fairly cheaply done with a temporary index and an empty temporary
> working tree elsewhere in the filesystem.

The thing is that I spent so much time for something that is "only the
notification emails"...  And doing something like this sounds like it
requires knowing more git bits.  Is there something similar to this
somewhere that I can stare at to see how it's done?  Pointers would be
much appreciated.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
