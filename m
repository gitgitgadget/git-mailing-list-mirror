From: Charles Bailey <charles@hashpling.org>
Subject: Re: cookbook question
Date: Thu, 28 Feb 2008 23:20:31 +0000
Message-ID: <20080228232031.GB31479@hashpling.org>
References: <47C704BB.2010707@krose.org> <20080228225838.GA31479@hashpling.org> <47C73ED3.6000704@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Kyle Rose <krose@krose.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 00:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUs3w-0001wF-W4
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 00:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759451AbYB1XUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 18:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759523AbYB1XUk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 18:20:40 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:34853 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317AbYB1XUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 18:20:40 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JUs3L-0008QU-Md; Thu, 28 Feb 2008 23:20:39 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1SNKVhp000994;
	Thu, 28 Feb 2008 23:20:31 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1SNKV53000993;
	Thu, 28 Feb 2008 23:20:31 GMT
Content-Disposition: inline
In-Reply-To: <47C73ED3.6000704@krose.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: e5a215b9033a4d8b66418e014f3ac67f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75476>

On Thu, Feb 28, 2008 at 06:08:03PM -0500, Kyle Rose wrote:
> The rebase just avoids unnecessary merge records.  What I really want is my 
> changes placed on top of whatever the common head is at any one time, which 
> by design means I would use rebase.  Aside from the cleanliness of the 
> history, I'm not sure there is a real reason to do this.  But I like things 
> clean. ;-)

rebase should just reorder the patches in the simple cases, so it
should do what you want. Either you've found a bug in rebase or you're
doing something unconventional.
