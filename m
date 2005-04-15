From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 20:58:31 -0700
Organization: SGI
Message-ID: <20050414205831.01039ee8.pj@engr.sgi.com>
References: <425DEF64.60108@zytor.com>
	<20050414022413.GB18655@64m.dyndns.org>
	<425E0174.4080404@zytor.com>
	<20050414024228.GC18655@64m.dyndns.org>
	<425E0D62.9000401@zytor.com>
	<Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
	<425EA152.4090506@zytor.com>
	<Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
	<20050414191157.GA27696@outpost.ds9a.nl>
	<425EC3B4.6090908@zytor.com>
	<20050414214756.GA31249@outpost.ds9a.nl>
	<Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
	<425F13C9.5090109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, ahu@ds9a.nl, git@chrisli.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 05:57:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMHxE-0000RL-Lv
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 05:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVDOEA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 00:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVDOEA0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 00:00:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22700 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261717AbVDOEAV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 00:00:21 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3F5caSH005989;
	Thu, 14 Apr 2005 22:38:46 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3F3wZlU14686140;
	Thu, 14 Apr 2005 20:58:36 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425F13C9.5090109@zytor.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Earlier, hpa wrote:
> The base64 version has 2^12 subdirectories instead of 2^8 (I just used 2 
> characters as the hash key just like the hex version.)

Later, hpa wrote:
> Ultimately the question is: do we care about old (broken) filesystems?

I'd imagine we care a little - just not alot.

I'd think that going to 2^12 subdirectories, which with 2^12 entries per
subdirectory gets us to 16 million files before the leaf directories get
bigger than the parent, is a good tradeoff.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
