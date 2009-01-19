From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: how to track multiple upstreams in one repository
Date: Sun, 18 Jan 2009 21:14:26 -0500
Message-ID: <20090119021426.GA21999@shion.is.fushizen.net>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jan 19 03:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjvH-0002Nb-Rj
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbZASCaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 21:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbZASCaE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:30:04 -0500
Received: from satoko.is.fushizen.net ([207.192.69.114]:53664 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302AbZASCaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:30:03 -0500
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jan 2009 21:30:03 EST
Received: from cpe-74-75-3-179.maine.res.rr.com ([74.75.3.179] helo=rika)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1LOjeq-0000a9-07; Mon, 19 Jan 2009 02:14:32 +0000
Received: from bd by rika with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1LOjek-0005kW-GA; Sun, 18 Jan 2009 21:14:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106305>

On Sun, Jan 18, 2009 at 06:58:06PM -0800, david@lang.hm wrote:
> for linux I want to track both the linus tree and the -stable tree.  
> Ideally I want to be able to do a checkout of tags from either tree from  
> the same directory (along with diffs between items in both trees, etc)
>
> I have found documentation on how to clone from each of them, but I  
> haven't found any simple documentation on how to work with both of them.

After cloning from one:
git remote add remotename git://...
git fetch remotename

You will now have the other repository fetched into your local
repository; tags from both will be replicated to your local tags.
