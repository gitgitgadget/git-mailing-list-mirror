From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 15:13:10 -0400
Message-ID: <20070905191310.GE13314@fieldses.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905174427.GC13314@fieldses.org> <Pine.LNX.4.64.0709051339420.30020@torch.nrlssc.navy.mil> <85642phqtn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:13:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0K1-0002Wa-Ua
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbXIETNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbXIETNr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:13:47 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54406 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087AbXIETNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:13:46 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IT0JL-0007da-FY; Wed, 05 Sep 2007 15:13:11 -0400
Content-Disposition: inline
In-Reply-To: <85642phqtn.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57742>

On Wed, Sep 05, 2007 at 09:09:40PM +0200, David Kastrup wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > On Wed, 5 Sep 2007, J. Bruce Fields wrote:
> >
> >> Well, this may just prove I'm an idiot, but one of the reasons I rarely
> >> run it is that I have trouble remembering exactly what it does; in
> >> particular,
> >>
> >> 	- does it prune anything that might be needed by a repo I
> >> 	  cloned with -s?
> >
> >     YES! yikes.
> >
> > This is about the best argument put forth so far for not
> > automatically running git-gc.
> 
> Well, it could also mean that if git finds a dead symbolic link when
> looking up an object, it should check the corresponding link target
> directory for a pack file with the respective object...  and if it
> finds such a pack file, create a link to it and use it.

One of the two of us is very confused about what "git-clone -s" does.
See the git-clone man page.  I don't think symlinks are involved.

--b.
