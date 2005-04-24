From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Sat, 23 Apr 2005 17:12:04 -0700
Organization: SGI
Message-ID: <20050423171204.56c9d2d5.pj@sgi.com>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
	<20050420222815.GM19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
	<Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 02:08:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUfF-0006w7-DJ
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVDXAMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVDXAMp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:12:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58006 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262194AbVDXAMo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:12:44 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3O0agUd024483;
	Sat, 23 Apr 2005 17:36:45 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3O0C8lU17679348;
	Sat, 23 Apr 2005 17:12:08 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus wrote:
+				echo; sed 's/^/  /'

One can avoid adding useless trailing spaces on empty lines with:

+				echo; sed 's/./  &/'

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
