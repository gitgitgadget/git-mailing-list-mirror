From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Odd decision of git-pasky-0.7 to do a merge
Date: Fri, 29 Apr 2005 10:31:00 +0100
Message-ID: <20050429103059.A3260@flint.arm.linux.org.uk>
References: <20050429083615.A32271@flint.arm.linux.org.uk> <20050429100717.A5035@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 11:26:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRRkd-00036Y-8E
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 11:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVD2JbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 05:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVD2JbN
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 05:31:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262175AbVD2JbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 05:31:12 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRRpx-0004HD-4H
	for git@vger.kernel.org; Fri, 29 Apr 2005 10:31:08 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DRRpt-0004Lz-U8
	for git@vger.kernel.org; Fri, 29 Apr 2005 10:31:02 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050429100717.A5035@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Apr 29, 2005 at 10:07:17AM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 10:07:17AM +0100, Russell King wrote:
> rmk@hera:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(0)$ SHA1_FILE_DIRECTORY=./objects merge-base c60c390620e0abb60d4ae8c43583714bda27763f bdceb6a0162274934386f19f3ea5a9d44feb0b20
> bdceb6a0162274934386f19f3ea5a9d44feb0b20
> 
> $ merge-base c60c390620e0abb60d4ae8c43583714bda27763f bdceb6a0162274934386f19f3ea5a9d44feb0b20
> e8108c98dd6d65613fa0ec9d2300f89c48d554bf

This is the problem.  It seems that merge-base in git-pasky-0.7
doesn't work correctly.

-- 
Russell King

