From: David Brown <davidb@codeaurora.org>
Subject: Re: Enforcing clone/fetch to use references.
Date: Tue, 21 Sep 2010 15:12:29 -0700
Message-ID: <20100921221229.GA29680@huya.qualcomm.com>
References: <20100921204456.GA24357@huya.qualcomm.com>
 <20100921213135.GB1255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arun Raghavan <ford_prefect@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 00:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyB4m-0002EE-RU
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 00:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab0IUWMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 18:12:32 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:61645 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab0IUWMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 18:12:31 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6113"; a="55259109"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 21 Sep 2010 15:12:30 -0700
Received: from huya.qualcomm.com (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 524BD10004C8;
	Tue, 21 Sep 2010 15:12:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100921213135.GB1255@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156766>

On Tue, Sep 21, 2010 at 05:31:35PM -0400, Jeff King wrote:
> On Tue, Sep 21, 2010 at 01:44:56PM -0700, David Brown wrote:
> 
> > Suppose I want to publish some changes to a tree.  I have a server
> > available where I can run a git daemon, but for one reason or another
> > I want to force people to use the another git repo as a reference.
> > The reason could be one of bandwidth, or someone who isn't comfortable
> > making all of the other source available.  Ideally, someone who
> > already has the other git repo cloned, and just adds mine as a remote
> > wouldn't notice the difference.
> 
> I think the gentoo people were talking about doing something like this.
> They wanted you to use some faster and/or restartable protocol to clone
> initially, and so they wanted to reject initial clones. I'm not sure if
> they are doing that, and how (from the thread below, I suspect they run
> a patched git).
> 
> The simplest thing would be a pre-upload-pack hook. There was some
> discussion of that in this thread:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/137007

Arun, did you ever get a chance to rework the upload-pack hooks to
work only from git daemon?  If not, I'd like to take a look into
implementing this.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
