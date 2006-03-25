From: Marc Singer <elf@buici.com>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Fri, 24 Mar 2006 22:32:25 -0800
Message-ID: <20060325063225.GA13791@buici.com>
References: <20060325035423.GB31504@buici.com> <Pine.LNX.4.64.0603242014160.15714@g5.osdl.org> <7v64m3ys3a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 07:32:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN2K6-00010u-EL
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 07:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWCYGc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 01:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWCYGc1
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 01:32:27 -0500
Received: from 206-124-142-26.buici.com ([206.124.142.26]:6881 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1750926AbWCYGc0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 01:32:26 -0500
Received: (qmail 14008 invoked by uid 1000); 25 Mar 2006 06:32:25 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64m3ys3a.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17958>

On Fri, Mar 24, 2006 at 10:08:09PM -0800, Junio C Hamano wrote:
> > Junio, is there some magic to restart a rebase after you've fixed up the 
> > conflicts?
> 
> The modern rebase is essentially git-format-patch piped to
> git-am (with -3 flag to allow falling back to three-way merge),
> and all the familiar "the patch did not apply -- what now?"
> techniques can be employed.
> 
> Since the pre-image blobs recorded in the intermediate
> format-patch output by definition exist in your repository, it
> always falls back to three-way merge when the patch does not
> apply cleanly.  Then you can resolve and say "git am --resolved"
> to continue.

By modern do you mean newer than 1.2.4?  I comprehend what you're
layin' down here, but I don't know if I need to do something
different.

Moreover, it isn't clear to me if git-rebase is better than git-merge.
