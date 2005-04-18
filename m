From: Paul Jackson <pj@sgi.com>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 18:20:24 -0700
Organization: SGI
Message-ID: <20050417182024.673605fa.pj@sgi.com>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
	<Pine.LNX.4.21.0504171131230.30848-100000@iabervon.org>
	<20050417174736.GA1461@pasky.ji.cz>
	<20050417122517.4b12faea.pj@sgi.com>
	<20050417195935.GI1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:17:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKsy-0004Zj-Lg
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVDRBUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDRBUw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:20:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:42908 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261493AbVDRBUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:20:49 -0400
Received: from omx3.sgi.com (omx3-ext.sgi.com [192.48.171.20])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j3I1KmME007829
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 18:20:48 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I1iAP7010238;
	Sun, 17 Apr 2005 18:44:10 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I1KTlU15554198;
	Sun, 17 Apr 2005 18:20:29 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417195935.GI1461@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr wrote:
> Does this distinction have any effect when doing F_OK?

Well, yeah.  If only one of real or effective id's could traverse the
path (execute perm on directories), then you'd get the wrong answer.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
