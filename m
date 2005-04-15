From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: another perspective on renames.
Date: Thu, 14 Apr 2005 22:16:26 -0700
Organization: SGI
Message-ID: <20050414221626.10c6c0e7.pj@engr.sgi.com>
References: <Pine.LNX.4.61.0504141759440.7261@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 07:13:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMJ8q-0008O2-DU
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 07:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDOFQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 01:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDOFQp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 01:16:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19687 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261706AbVDOFQn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 01:16:43 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3F5dkTd011182;
	Thu, 14 Apr 2005 22:39:46 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3F5GUlU14700494;
	Thu, 14 Apr 2005 22:16:31 -0700 (PDT)
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504141759440.7261@cag.csail.mit.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Scott wrote:
> Anyway, maybe it's worth thinking a little about an SCM in which this is a 
> feature, instead of (or in addition to) automatically assuming this is a 
> bug we need to add infrastructure to work around.

Agreed.

To me, the main purpose in tracking renames is to obtain a deeper
history of the line-by-line changes in a file.

  ==> But that doesn't seem relevant here.

Last I looked, git has no such history.  A given file contents
is the indivisable atom of the git world, with no fine structure.

This is quite unlike classic SCM's, built on file formats that
track source lines, not files, as the atomic unit.

To me, rename is a special case of the more general case of a
big chunk of code (a portion of a file) that was in one place
either being moved or copied to another place.

I wonder if there might be someway to use the tools that biologists use
to analyze DNA sequences, to track the evolution of source code,
identifying things like common chunks of code that differ in just a few
mutations, and presenting the history of the evolution, at selectable
levels of detail.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
