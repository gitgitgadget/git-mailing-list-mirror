From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 18:38:19 -0400
Message-ID: <20071031223819.GN4569@fieldses.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru> <Pine.LNX.4.64.0710312111170.4362@racer.site> <20071031212923.GL4569@fieldses.org> <4728FC5C.30709@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InMCr-0007aR-6W
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbXJaWiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbXJaWiY
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:38:24 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43328 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbXJaWiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:38:23 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1InMCZ-0008Pz-AK; Wed, 31 Oct 2007 18:38:19 -0400
Content-Disposition: inline
In-Reply-To: <4728FC5C.30709@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62893>

On Wed, Oct 31, 2007 at 03:06:20PM -0700, Steven Grimm wrote:
> I've been using rebase just about every day for close to a year and it 
> *still* annoys me when it happens. Especially the "Did you forget to git 
> add?" part of the message. The thought that always goes through my head is, 
> "No, Mr. Rebase, I did NOT forget to git add. I remembered to git add, then 
> you were too stupid to do the right thing after that."
>
> Just happened to me this morning, in fact: I had a quick hack in place to 
> work around a bug, the bug got fixed for real, and I rebased. In the 
> process of conflict resolution I saw that my workaround wasn't needed any 
> more and accepted the upstream version of that particular part of the file. 
> Ran git-add on it, then rebase --continue, and boom, was accused of 
> forgetting to run git-add.
>
> It is a minor annoyance and nowadays I just sigh a bit and run --skip 
> instead, but it'd be nice if it didn't happen. I don't like having to care 
> whether or not I happened to change other files in a particular commit 
> after I resolve conflicts in one file in favor of the upstream version.

Yeah, I think a message saying "patch is now empty, skipping..." would
be sufficient to let the user know what's going on.  This doesn't seem
so perilous to me that it's worth requiring a positive acknowledgement.

--b.
