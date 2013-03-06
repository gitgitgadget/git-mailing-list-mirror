From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 11:39:37 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1303061137290.12579@tvnag.unkk.fr>
References: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com> <20130306082110.GA31638@sigill.intra.peff.net> <CABmRxH2CGTxFaGufSMgUqhrSTZPvFBHoEnP8-p5HhkU4kszJPw@mail.gmail.com> <20130306094552.GA11531@sigill.intra.peff.net>
 <CABmRxH25y9bAdZWV_3MG7x2LNGNDQbLB_EJC1xAJC396nO7bYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Yves Blusseau <yves.blusseau@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 11:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDBlh-0001h8-28
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 11:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950Ab3CFKjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 05:39:51 -0500
Received: from giant.haxx.se ([80.67.6.50]:48826 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670Ab3CFKju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 05:39:50 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r26Adcif022289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Mar 2013 11:39:38 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r26Adb8t022284;
	Wed, 6 Mar 2013 11:39:37 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CABmRxH25y9bAdZWV_3MG7x2LNGNDQbLB_EJC1xAJC396nO7bYQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217514>

On Wed, 6 Mar 2013, Yves Blusseau wrote:

> I have try with an old version of curl: 7.15.5 and with the latest in 
> development curl 7.29.1-DEV. But it seem that git-remote-http is compile 
> with the old one.

libcurl 7.15.5 is over 6 years old.

The support for "socks[*]://" prefixes in proxy names was added to libcurl 
7.21.7 (June 23 2011).

-- 

  / daniel.haxx.se
