From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Fri, 18 Jul 2008 10:35:24 -0400
Message-ID: <20080718143524.GD5288@fieldses.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org> <20080717155538.GE11759@fieldses.org> <alpine.DEB.1.00.0807171915420.8986@racer> <7vtzeofjpi.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807171940160.8986@racer> <7vmykgfhtj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 16:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJr4O-0008TP-99
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 16:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbYGROf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYGROf2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 10:35:28 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34146 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbYGROf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 10:35:28 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KJr3M-0001ef-Jk; Fri, 18 Jul 2008 10:35:24 -0400
Content-Disposition: inline
In-Reply-To: <7vmykgfhtj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89045>

On Thu, Jul 17, 2008 at 12:10:00PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 17 Jul 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> >> Is there a way to commit the contents of a tarball without using 
> >> >> plumbing?  I occasionally want to track an upstream that I know only 
> >> >> as a series of tarballs, so I do something like:
> >> >> 
> >> >> 	cd repo/
> >> >> 	git checkout upstream
> >> >> 	rm -rf *
> >> >> 	tar -xzvf ../new-version.tar.gz
> >> >
> >> > How about "git add -u" and "git add ."?
> >> 
> >> It would work only if new version never removes files.
> >
> > You made me doubt for a second there.  But "git add -u" updates the index 
> > when a tracked files was deleted.  So after "rm -rf *", "git add -u" would 
> > empty the index.
> 
> I thought everybody would react to my message like so after sending it ;-)
> What I failed to say was that the main uneasiness about the above command
> sequence Bruce or anybody would have felt would be that "rm -fr *" step,
> which in itself look scary and does not remove .frotz that came from older
> version.

Yeah, good point, that's not very careful.

But actually it's "add -u" that I missed--I forgot it would take into
account removed files as well.  Thanks!

--b.
