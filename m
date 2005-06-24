From: Paul Jackson <pj@sgi.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Fri, 24 Jun 2005 04:56:27 -0700
Organization: SGI
Message-ID: <20050624045627.6e9cbaff.pj@sgi.com>
References: <tnxy899zzu7.fsf@arm.com>
	<20050623175848.1cf41a52.pj@sgi.com>
	<tnxd5qc6s5o.fsf@arm.com>
	<20050624034743.6c3bdae4.pj@sgi.com>
	<tnxhdfo56yd.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 13:53:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlmjn-0005Pb-Nz
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 13:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbVFXL6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 07:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbVFXL6h
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 07:58:37 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58789 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263267AbVFXLyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 07:54:25 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j5OCSA6n014468;
	Fri, 24 Jun 2005 05:28:10 -0700
Received: from v0 (mtv-vpn-hw-masa-1.corp.sgi.com [134.15.25.210])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j5OBsMdO40590211;
	Fri, 24 Jun 2005 04:54:22 -0700 (PDT)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxhdfo56yd.fsf@arm.com>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> there is no way to modify the log history.

Aha.  If that means what I think it does, then I suspect I will remain
with quilt.  The per-patch comment is often about the last thing that
I put in the patch.

The special thing about quilt is that the patch set in every regard
is infinitely changeable - the selection and order of the patches,
the contents of the patches, and the comments and metadata associated
with the patch can all be edited trivially.

Quilt is not a change management system; it's a patch set composition
system.

That stgit is layered on git (a persistent data store), and that
it has something (the log history you mention above) that cannot
be modified, suggests that stgit is not a 'better quilt for git',
but some other sort of tool.

Good luck ;).


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
