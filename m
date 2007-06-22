From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Little fix and suggestion for the git tutorial
Date: Thu, 21 Jun 2007 23:18:11 -0400
Message-ID: <20070622031811.GA8027@fieldses.org>
References: <1b46aba20706210945h49139cc2y69d2de972f014189@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 05:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Zf8-0002G7-56
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 05:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXFVDSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 23:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXFVDSN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 23:18:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56231 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbXFVDSM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 23:18:12 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1I1Zf1-0003X0-EN; Thu, 21 Jun 2007 23:18:11 -0400
Content-Disposition: inline
In-Reply-To: <1b46aba20706210945h49139cc2y69d2de972f014189@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50667>

On Thu, Jun 21, 2007 at 06:45:01PM +0200, Carlos Rica wrote:
> Sorry for not sending a patch, I was following the tutorial and found
> this, in the section "Using git for collaboration":
> 
> 307 With this, you can perform the first operation alone using the
> 308 "git fetch" command without merging them with her own branch,
> 309 using:
> 
> I think that "you" should be replaced with "she".

Yep, thanks.  Actually, I think we should make it "Alice".

> I have a suggestion also that I don't know how to fix. The text in
> that section seems to say something like you need to add a "remote"
> alias to be able to run fetch for retrieving without merging:

Yes, I agree, it's confusing.  We're trying to introduce both fetch and
remotes at the same time.

It might be the simplest thing to do would just be to use remotes from
the start.  I don't know.  I haven't looked at this section in a
while--I'll try to find time this weekend and see if I can come up with
a better approach.

--b.
