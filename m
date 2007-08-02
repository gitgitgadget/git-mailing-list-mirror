From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Thu, 2 Aug 2007 18:31:32 -0400
Message-ID: <20070802223132.GA15212@fieldses.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjCt-0000sg-H4
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbXHBWbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbXHBWbd
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:31:33 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36526 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbXHBWbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:31:33 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IGjCe-00048g-4U; Thu, 02 Aug 2007 18:31:32 -0400
Content-Disposition: inline
In-Reply-To: <107BD473-E055-47D0-9720-9D878BDAB954@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54632>

On Fri, Aug 03, 2007 at 12:24:10AM +0200, Steffen Prohaska wrote:
>
> On Aug 2, 2007, at 8:18 PM, J. Bruce Fields wrote:
>
>> I wonder whether we could get away with just the brief list of features
>> ("lets you view changes in the index and the working file, lets you
>> individually select diff hunks for inclusion in the index"), and leave
>> the how-to stuff to online guit-gui help, if it's necessary?
>
> Maybe, this would be sufficient. I mentioned the pop-up explicitly
> because it wasn't obvious to me right away.

I took a quick look and it wasn't obvious to me either.  It'd be nice if
this could be fixed in the interface or the documentation in git-gui
itself instead of here, but perhaps saying it here is easiest for now.

>> Also, I like the verb "stage" as a way to explain the part of the index
>> file in creating commits, but I've been consistently using the word
>> "index" throughout the user manual, and I think that's consistent with
>> the rest of the documentation--so don't avoid it here.
>
> "staging/unstaging" is how git gui calls adding/removing files to and
> from the index.

I understand what you meant, but a reader of the user manual at this
point might not, since it's been consistently saying things like "to add
the contents of a new file to the index, use git add".  So we should use
the same language here.  Unless we want to update the whole thing to use
"stage" and "unstage".  I'd rather not.

--b.
