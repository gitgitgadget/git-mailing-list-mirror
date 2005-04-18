From: Paul Jackson <pj@sgi.com>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 18:24:22 -0700
Organization: SGI
Message-ID: <20050417182422.06dd7379.pj@sgi.com>
References: <20050417195935.GI1461@pasky.ji.cz>
	<Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:22:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKxf-0004ro-GH
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDRBZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDRBZu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:25:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32935 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261494AbVDRBZq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:25:46 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I34mL2030872;
	Sun, 17 Apr 2005 20:04:58 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I1ORlU15538783;
	Sun, 17 Apr 2005 18:24:29 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> So it shouldn't complain about a filename which you're allowed to try to
> stat, even if there's nothing there.

I'm not sure what 'nothing there' means to you.

To me, it means 'no file there', so no you would not be allowed
to stat it - and should fail ENOENT.

> And it would depend on the privs of
> the wrong user in looking at the path.

Yup.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
