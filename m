From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Thu, 06 Mar 2008 00:56:27 +0100
Message-ID: <200803060056.27288.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <alpine.LNX.1.00.0803041801320.19665@iabervon.org>
 <alpine.LNX.1.00.0803041922090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 00:57:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3U8-0003BZ-25
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094AbYCEX4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 18:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbYCEX4m
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:56:42 -0500
Received: from smtp.getmail.no ([84.208.20.33]:50124 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043AbYCEX4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 18:56:41 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JXA00D0L7UFC300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 06 Mar 2008 00:56:39 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXA001R47U3RR40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 06 Mar 2008 00:56:27 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXA006H97U3HTH0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 06 Mar 2008 00:56:27 +0100 (CET)
In-reply-to: <alpine.LNX.1.00.0803041922090.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76295>

On Wednesday 05 March 2008, Daniel Barkalow wrote:
> On Tue, 4 Mar 2008, Daniel Barkalow wrote:
> > I think we should be able to avoid setting git_dir to anything other than 
> > the repo we're creating, which would avoid this problem for the present, 
> > although, as you say, it would be good to be able to switch around as 
> > instructed for libification purposes eventually.
> 
> Okay, stuff pushed out to not use git_dir to access the reference repo, 
> and an additional test that requires that we actually note that we have 
> the refs in the reference repository (because otherwise we could pass all 
> the tests by just making --reference useless, but that's obviously no 
> good).

Thanks. Nice work. The testsuite passes, and it all looks good from here. :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
