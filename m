From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Sun, 03 Aug 2008 13:53:13 -0700
Message-ID: <1217796793.32240.36.camel@localhost.localdomain>
References: <20080730125743.GY15356@erda.amd.com>
	 <1217432970.2884.8.camel@localhost.localdomain>
	 <20080730161126.GE31295@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkba-0003PE-6U
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYHCUyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbYHCUyE
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:54:04 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:58108 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbYHCUyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:54:03 -0400
Received: from [172.19.0.93] (c-67-188-226-86.hsd1.ca.comcast.net [67.188.226.86])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m73Krv1r012094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 13:53:57 -0700
In-Reply-To: <20080730161126.GE31295@erda.amd.com>
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7924/Sun Aug  3 10:44:07 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sun, 03 Aug 2008 13:53:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91271>

Working on refactoring the patch so that it can go upstream, one of the
things I'm definitely making an assumption about (in my original code)
is that the base url will be uniform for the entire project_list (as it
is on kernel.org).  If that's acceptable I will probably be able to
submit something today, if not I will need to muck about and read out
the url from .git/cloneurl (which would be a rather hefty performance
hit - needing to read that from each repository)

- John

On Wed, 2008-07-30 at 18:11 +0200, Robert Richter wrote:
> On 30.07.08 08:49:30, J.H. wrote:
> > That is a kernel.org specific change - if the community at large wants
> > it I can dig the patch out (I likely didn't do it as it's own patch when
> > I did it, being young, naive and stupid at the time - I'm now slightly
> > older and slightly less naive now ;-)
> > 
> > But yeah - if people feel that's interesting I'm happy to rip it out
> > later today and submit it to the mailing list.
> 
> John, I would like the patch.
> 
> Yes, I have seen the commit as well and it is not the only change in
> this commit. Also, if I got it right, the repository is not taken from
> .git/cloneurl. So, with the current implementation the git url in the
> summary page may be different to cloneurl. But this is not a major
> issue.
> 
> It would be great if you could provide a patch with your changes for
> gitweb.
> 
> Thanks,
> 
> -Robert
> 
