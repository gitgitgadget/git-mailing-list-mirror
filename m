From: david@lang.hm
Subject: Re: Performance impact of a large number of commits
Date: Fri, 24 Oct 2008 12:43:27 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810241240100.27333@asgard.lang.hm>
References: <1224874946.7566.13.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Abels <newsgroups@debain.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:44:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSZo-0004vI-TW
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYJXTmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYJXTmv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:42:51 -0400
Received: from mail.lang.hm ([64.81.33.126]:44961 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbYJXTmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:42:51 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9OJgijj020627;
	Fri, 24 Oct 2008 12:42:44 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1224874946.7566.13.camel@localhost>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99054>

On Fri, 24 Oct 2008, Samuel Abels wrote:

> Hi,
>
> I am considering Git to maintain a repository of approximately 300.000
> files totaling 1 GB, with a number of ~100.000 commits per day, all in
> one single branch. The only operations performed are "git commit", "git
> show", and "git checkout", and all on one local machine. Does this sound
> like a reasonable thing to do with Git?

100,000 commits per day??

that's 1.5 commits/second. what is updating files that quickly?

I suspect that you will have some issues here, but it's going to depend on 
how many files get updated each 3/4 of a second.

David Lang
