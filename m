From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 23:42:31 -0700
Organization: SGI
Message-ID: <20050414234231.663fd7b3.pj@engr.sgi.com>
References: <20050412132307.GH22614@pasky.ji.cz>
	<20050413092656.GO16489@pasky.ji.cz>
	<1113394537.23299.51.camel@nosferatu.lan>
	<20050413221936.GI25711@pasky.ji.cz>
	<1113461754.23299.68.camel@nosferatu.lan>
	<1113467335.23299.77.camel@nosferatu.lan>
	<1113467905.23299.81.camel@nosferatu.lan>
	<20050414091106.GX25711@pasky.ji.cz>
	<1113471609.23299.95.camel@nosferatu.lan>
	<1113472557.23299.99.camel@nosferatu.lan>
	<81b0412b0504141535793cc235@mail.gmail.com>
	<1113543914.23299.151.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: raa.lkml@gmail.com, pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 08:42:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMKW5-0000ht-Os
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 08:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVDOGor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 02:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVDOGor
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 02:44:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12011 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261750AbVDOGol (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 02:44:41 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3F8MUh4018491;
	Fri, 15 Apr 2005 01:22:40 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3F6gZlU14719713;
	Thu, 14 Apr 2005 23:42:36 -0700 (PDT)
To: azarah@nosferatu.za.org
In-Reply-To: <1113543914.23299.151.camel@nosferatu.lan>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> No, '&' have a higher priority (weight?) than '&&'.

& has a higher precedence than &&

  C Operator Precedence and Associativity
  http://www.difranco.net/cop2220/op-prec.htm

and many others -- google for 'c operator precedence'

Where the bitops &, | and ^ bite you is that they are
lower precedence than many other ops, including '=='.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
