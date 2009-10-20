From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 19:56:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
References: <200910201947.50423.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0OYm-0007Lb-NF
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 01:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbZJTXz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 19:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZJTXz6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 19:55:58 -0400
Received: from iabervon.org ([66.92.72.58]:39298 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbZJTXz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 19:55:57 -0400
Received: (qmail 15708 invoked by uid 1000); 20 Oct 2009 23:56:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Oct 2009 23:56:01 -0000
In-Reply-To: <200910201947.50423.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130871>

On Tue, 20 Oct 2009, Thomas Rast wrote:

> Hi all,
> 
> While everyone is busy in two other UI threads, I figured I might as
> well toss up another (probably) controversial topic.
> 
> Especially on IRC, we see many people who are some combination of
> misunderstanding, misusing or overusing git-pull.  I figure this is
> the result of several factors, notably
> 
> a) pull/push are not symmetric,

In a certain sense they are; they both update the branches local to one 
repository with the data from the other repository. In this sense, fetch 
is the oddity in that it doesn't update any repository's own branches, but 
just the local information about other repositories' branches.

In another sense, push is unlike anything else in that it updates 
something that's remote; in a third sense, pull is unique in that it can 
generate a merge.

I suspect that what we've called "fetch" isn't what the people want when 
they type "pull", either. And I suspect that the fundamental issue is that 
the operation people are looking for is not the operation that they would 
do best to use, regardless of naming. I think users are looking for 
something that corresponds to "svn up", and they find "git pull"; this 
isn't going to make them happy git users, but finding "git fetch" instead 
is going to make them even more confused.

But I don't really know; are there IRC logs you can quote or reference 
with people making the mistake you're trying to help them avoid?

	-Daniel
*This .sig left intentionally blank*
