From: Greg KH <greg@kroah.com>
Subject: Re: git for mail synchronization
Date: Sun, 6 Mar 2011 11:56:48 -0800
Message-ID: <20110306195648.GA10264@kroah.com>
References: <20110306191013.GA12688@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 20:55:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwK3S-0004D4-0X
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 20:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab1CFTzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 14:55:45 -0500
Received: from kroah.org ([198.145.64.141]:32991 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab1CFTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 14:55:44 -0500
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id E426A48482
	for <git@vger.kernel.org>; Sun,  6 Mar 2011 11:55:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306191013.GA12688@nibiru.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168528>

On Sun, Mar 06, 2011 at 08:10:13PM +0100, Enrico Weigelt wrote:
> 
> Hi folks,
> 
> 
> I'm currently thinking about using git for mail synchronization.
> The scenario:
> 
> * multiple hosts share a set of maildirs where new mails can be
>   added or removed arbitrarily (using non-conflicting filenames,
>   eg. their sha-hashes)
> * on each host, the current tree is committed in some time
>   interval
> * the hosts pull from each other and merge in the other's trees.
> 
> 
> Could this work well ?

It can work, there was a blog post somewhere that showed one solution
for this type of thing, google is your friend here.

But, I would recommend just using something like offlineimap instead, it
handles stuff like this much easer than git, and then using git to store
an "archive" version of emails you want to keep longer.  That's what I
do and it's much easier in the end.

best of luck,

greg k-h
