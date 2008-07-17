From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 11:55:38 -0400
Message-ID: <20080717155538.GE11759@fieldses.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 17:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJVqY-0007BN-3y
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 17:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbYGQPzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757145AbYGQPzp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 11:55:45 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48658 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbYGQPzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 11:55:45 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KJVpS-0003Ql-Ho; Thu, 17 Jul 2008 11:55:38 -0400
Content-Disposition: inline
In-Reply-To: <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88867>

On Wed, Jul 16, 2008 at 01:51:31PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Am I the only one who deems teaching plumbing to users ("I like it raw!  
> > So I teach it the same way!") harmful?
> 
> I think that justification is harmful.
> 
> More productive way to think about it is to identify cases where we _need_
> to go down to combination of the plumbing commands in our daily workflow,
> with today's command set.  That would give us a good indication that some
> Porcelain may need to be enhanced.

Is there a way to commit the contents of a tarball without using
plumbing?  I occasionally want to track an upstream that I know only as
a series of tarballs, so I do something like:

	cd repo/
	git checkout upstream
	rm -rf *
	tar -xzvf ../new-version.tar.gz

Then I spend some time mucking around with git-add and git-rm and
eventually end up having to do some sort of git ls-files | git
update-index pipeline.

--b.
