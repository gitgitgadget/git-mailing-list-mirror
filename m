From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: pull/push inconsistencies
Date: Tue, 15 May 2007 21:40:02 -0400
Message-ID: <20070516014002.GA8062@fieldses.org>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com> <7vtzudhayr.fsf@assigned-by-dhcp.cox.net> <46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com> <7v646th8a2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 03:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho8VN-0004aQ-Pz
	for gcvg-git@gmane.org; Wed, 16 May 2007 03:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760886AbXEPBkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 21:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761672AbXEPBkG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 21:40:06 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35090 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760886AbXEPBkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 21:40:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Ho8Uk-0003BG-Pw; Tue, 15 May 2007 21:40:02 -0400
Content-Disposition: inline
In-Reply-To: <7v646th8a2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47404>

On Tue, May 15, 2007 at 06:22:29PM -0700, Junio C Hamano wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> 
> > There are 2 things that I see as wrong...
> > - local .git/refs/remote/origin/foo and refs/heads/foo match - why is
> > git-push talking about updating them?
> 
> Ooo...
> 
> Do you mean if you have refs/remotes/origin/foo locally, and
> push into a repository that has refs/heads/foo (but not
> refs/remotes/origin/foo), the push results in refs/heads/foo
> getting updated?  If that is what is happening (without any
> refspecs to instruct git-push to do so) that sounds quite buggy.
> I need to look into the code for this one.

I understand him to be saying that it *doesn't* do that, and that he
*wants* it to.

People think of refs/remotes/origin as a cache of the origin
repository's branch heads, and they expect it to be updated on write
(push) as well as read (fetch).

--b.
