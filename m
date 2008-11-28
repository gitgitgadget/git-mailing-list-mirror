From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 28 Nov 2008 11:20:33 -0800
Message-ID: <20081128192033.GF23984@spearce.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de> <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 20:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L68uV-0006WK-D4
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 20:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbYK1TUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 14:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYK1TUf
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 14:20:35 -0500
Received: from george.spearce.org ([209.20.77.23]:58470 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYK1TUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 14:20:34 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C19F438200; Fri, 28 Nov 2008 19:20:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101881>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 27 Nov 2008, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > I have a strong suspicion that the narrow stuff will make the worktree 
> > > mess pale in comparison.
> > >
> > > Note that I do not have time to review this myself (which is not 
> > > helped at all by it being no longer a trivial single patch, but a full 
> > > 10 patches!), but I really have a bad feeling about this.  IMO it is 
> > > substantially under-reviewed.
> > 
> > Well, "a bad feeling" is not a convincing enough argument either, is it? 
> > What kind of bad interaction are you fearing?
...
> And the worst part: I think that as with worktree, there has not been 
> enough of kicking forth and back ideas how to design the beast, so I fully 
> expect a subtle breakage that would require a redesign (which will be 
> painful, with existing users of the feature).
> 
> Maybe I am crying "wolf", but I _do_ want to caution against risking too 
> much, too fast, with that feature.
> 
> In other words, unless there is more interest in that feature, enough to 
> generate a well-understood design before a good implementation, I'd rather 
> see this patch series dropped.

Ack.  I agree with every remark made by Dscho, and also want to cry "wolf".

I haven't had time to read the patch series.  Its big and intrusive
and I just don't need the feature.

But I feel like if it were in fact merged I'll fall over some bug
in it sometime soon and be forced to stop and debug it.  Heck at
the least I'll have to go back to JGit's index code and implement
the new file format.  That shouldn't cause git.git's development to
stop, but I am whining (a little) about the file format change.  ;-)

-- 
Shawn.
