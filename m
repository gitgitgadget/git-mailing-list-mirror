From: Paul Jackson <pj@sgi.com>
Subject: Re: git add / update-cache --add fails.
Date: Wed, 27 Apr 2005 18:01:43 -0700
Organization: SGI
Message-ID: <20050427180143.0447ceaa.pj@sgi.com>
References: <200504260726.04908.rhys@rhyshardwick.co.uk>
	<E1DQcOc-00054l-00@gondolin.me.apana.org.au>
	<87ll74go7o.fsf@coraid.com>
	<20050427173059.GE22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: ecashin@coraid.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:58:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxLU-0002bU-97
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVD1BC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVD1BC5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:02:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26826 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262138AbVD1BCx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:02:53 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3S2hWDR026163;
	Wed, 27 Apr 2005 19:43:42 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3S11k5w19106083;
	Wed, 27 Apr 2005 18:01:47 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427173059.GE22956@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr wrote:
>  	fd = open(path, O_RDONLY);
>  	if (fd < 0) {
> +		fprintf(stderr, "update-cache Error: %s\n", strerror(errno));

It's usually a good idea to indicate which system call you were
attempting in such error messages, and if handy, the key argument.
Just the errno might not mean much:

> +		fprintf(stderr, "update-cache open(%s) failed: %s\n", path, strerror(errno));

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
