From: Bill Lear <rael@zopyra.com>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 15:55:18 -0500
Message-ID: <17941.25142.88657.766384@lisa.zopyra.com>
References: <17940.59514.150325.738141@lisa.zopyra.com>
	<20070405134954.GA18402@coredump.intra.peff.net>
	<17941.655.192938.792088@lisa.zopyra.com>
	<20070405204604.GA24779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwj7-0001qp-1o
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 00:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbXDFWQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 18:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933175AbXDFWQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 18:16:09 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60913 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932787AbXDFWQH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 18:16:07 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l35KtKh16437;
	Thu, 5 Apr 2007 14:55:20 -0600
In-Reply-To: <20070405204604.GA24779@coredump.intra.peff.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43933>

On Thursday, April 5, 2007 at 16:46:04 (-0400) Jeff King writes:
>On Thu, Apr 05, 2007 at 09:07:11AM -0500, Bill Lear wrote:
>
>> Here is the local:
>> 
>> [core]
>>         repositoryformatversion = 0
>>         filemode = true
>>         bare = false
>>         logallrefupdates = true
>> [remote "origin"]
>>         url = ssh://poire/home/jml/repos/new/fusion
>>         fetch = +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>>         remote = origin
>>         merge = refs/heads/master
>
>I don't see anything there that should cause branches under refs/remotes
>to be pushed. Was he using 'git-push --all' by any chance?

No, just plain ol' git push.  One possibility is that in mediating
between him and the list, there has been a loss of information.
Perhaps he omitted details in his account of how things progressed ---
who knows, perhaps he was on the wrong branch (though I doubt this, he
only works on the master branch, and the other branch in question was
someone else's entirely).

Regardless, does my assumption --- a 'git pull' should rectify
the 'you are not up to date' problem --- hold in general?

Thanks for helping.


Bill
