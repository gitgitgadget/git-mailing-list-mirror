From: Paul Jackson <pj@sgi.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Fri, 24 Jun 2005 03:47:43 -0700
Organization: SGI
Message-ID: <20050624034743.6c3bdae4.pj@sgi.com>
References: <tnxy899zzu7.fsf@arm.com>
	<20050623175848.1cf41a52.pj@sgi.com>
	<tnxd5qc6s5o.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 12:42:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dllct-00062K-Ig
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 12:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbVFXKrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 06:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVFXKrx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 06:47:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28805 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263221AbVFXKpn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 06:45:43 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j5OCZiA6012241;
	Fri, 24 Jun 2005 05:35:44 -0700
Received: from v0 (mtv-vpn-hw-masa-1.corp.sgi.com [134.15.25.210])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j5OAjcdO40585285;
	Fri, 24 Jun 2005 03:45:38 -0700 (PDT)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxd5qc6s5o.fsf@arm.com>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> it should at least
> check whether the commit message was modified.

I suspect not.

Beware that quilt has tended toward the philosophy of doing just
what you said, with no more, perhaps less than, the minimum critical
consistency checking.  If you tried to shoot you foot off with it,
it shot your foot off, quickly.

If I try to make a change without a meaninguful log entry, what
business of stgit is that?  And it certainly should not leave the
tree in some unspecified, inconsistent state without prior warning
on account of such.

Don't add inessential sanity checks on user input.  It won't sell
well to the "quilt replacement" market.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
