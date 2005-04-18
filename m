From: Paul Jackson <pj@sgi.com>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sun, 17 Apr 2005 21:47:07 -0700
Organization: SGI
Message-ID: <20050417214707.11a0ce70.pj@sgi.com>
References: <20050416170221.38b3e66c.pj@sgi.com>
	<E1DNMVX-00013d-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Mon Apr 18 06:44:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNO6i-0001jv-Ng
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 06:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVDREr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 00:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVDREr2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 00:47:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24040 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261665AbVDREr0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 00:47:26 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I5Asf3009359;
	Sun, 17 Apr 2005 22:10:54 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I4lClU15596293;
	Sun, 17 Apr 2005 21:47:14 -0700 (PDT)
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <E1DNMVX-00013d-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Herbert wrote:
> mktemp(1) creates the file before exiting.  ... O_EXCL

Aha - right you are.  Thanks for pointing that out.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
