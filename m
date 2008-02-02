From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax
	everywhere (unify examples)
Date: Sat, 2 Feb 2008 11:18:13 -0500
Message-ID: <20080202161813.GA19797@fieldses.org>
References: <3asc6spe.fsf@blue.sea.net> <7v7iho6p2m.fsf@gitster.siamese.dyndns.org> <20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 18:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLLv4-0006UE-MN
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 18:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYBBRMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYBBRMN
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 12:12:13 -0500
Received: from pie.citi.umich.edu ([141.211.133.115]:57944 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbYBBRMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 12:12:12 -0500
X-Greylist: delayed 3233 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2008 12:12:12 EST
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JLL4H-0006GQ-QL; Sat, 02 Feb 2008 11:18:13 -0500
Content-Disposition: inline
In-Reply-To: <8x235xa8.fsf@blue.sea.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72289>

On Sat, Feb 02, 2008 at 02:59:43PM +0200, Jari Aalto wrote:
> * Sat 2008-02-02 Mike Hommey <mh@glandium.org> gmane.comp.version-control.git
> * Message-Id: 20080202084406.GA15305@glandium.org
> >> 
> >> > -$ git reset --soft HEAD^      <1>
> >> > +$ git reset --soft HEAD~1     <1>
> >> > -<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
> >> > +<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
> >> > -$ git reset --soft HEAD^ ;# go back to WIP state  <2>
> >> > +$ git reset --soft HEAD~1 ;# go back to WIP state <2>
> 
> >> People need to refer to the HEAD^ (one commit ago) much more
> >> often than HEAD~N for larger values of N. 
> 
> I use HEAD~1 always, because I think the consistency in learning the
> most important factor.
> 
> It does not matter what advanced users use. The documentation should
> primarily focus the newcomers.

That could have been an argument for disallowing the HEAD^ syntax
entirely, but it's too late for that.

Even if we eradicated all mention of ^ from the in-tree documentation,
it would still show up in lots of out-of-tree documentation and
examples.  So we have to introduce it to newbies.  Fortunately, it isn't
that hard.

One way we can help them is by continuing to mix the two in examples, so
let's continue with the current mixture.

--b.
