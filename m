From: Bill Lear <rael@zopyra.com>
Subject: Re: removing content from git history
Date: Tue, 9 Oct 2007 17:25:23 -0500
Message-ID: <18187.65491.551693.644510@lisa.zopyra.com>
References: <20070221164527.GA8513@ginosko.local>
	<20070221165636.GH25559@spearce.org>
	<20070221171738.GA9112@fieldses.org>
	<Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
	<20070221210045.GB26525@spearce.org>
	<Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org>
	<20070221212129.GD26525@spearce.org>
	<18187.60305.613904.547916@lisa.zopyra.com>
	<20071009210235.GB9633@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 00:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfNWJ-0003Ds-N0
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 00:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbXJIWZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbXJIWZe
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 18:25:34 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61744 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbXJIWZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 18:25:33 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l99MPNC26936;
	Tue, 9 Oct 2007 16:25:23 -0600
In-Reply-To: <20071009210235.GB9633@fieldses.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60453>

On Tuesday, October 9, 2007 at 17:02:35 (-0400) J. Bruce Fields writes:
>On Tue, Oct 09, 2007 at 03:58:57PM -0500, Bill Lear wrote:
>> As I understand this thread, it does not appear that a resolution
>> was reached.  Our company has content in our central git repository
>> that we need to remove per a contractual obligation.  I believe the
>> content in question is limited to one sub-directory, that has existed
>> since (or near to) the beginning of the repo, if that matters.  We
>> obviously would just like to issue a "git nuke" operation and be done
>> with it, if that is available.  Barring that, we could probably follow
>> reasonably simple steps to purge the content and rebuild the repo.
>> 
>> So, what options do we have at present?
>
>Have you looked at git-filter-branch in a recent version of git?  The
>man page has some good examples.

Ah, no, though I will do so.  It is apparently not in the version
I have (1.5.2.4), but it is in 1.5.3.1.  We'll give this a shot
and complain if we can't handle it.

Thank you.


Bill
