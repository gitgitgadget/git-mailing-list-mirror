From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Tue, 19 Sep 2006 10:31:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609191027020.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060918225445.GF1261@artsapartment.org> <7v4pv4pyey.fsf@assigned-by-dhcp.cox.net>
 <20060918235753.GG1261@artsapartment.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 10:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPb0g-0000yq-LU
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 10:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWISIbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 04:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWISIbP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 04:31:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:45030 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932149AbWISIbP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 04:31:15 -0400
Received: (qmail invoked by alias); 19 Sep 2006 08:31:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 19 Sep 2006 10:31:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Art Haas <ahaas@airmail.net>
In-Reply-To: <20060918235753.GG1261@artsapartment.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27268>

Hi,

On Mon, 18 Sep 2006, Art Haas wrote:

> +#if LIBCURL_VERSION_NUM < 0x070f05
> +#define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
> +#endif

If you go to 

http://cool.haxx.se/cvs.cgi/curl/include/curl/curl.h?annotate=1.308

and search for HTTP_RETURNED_ERROR, it shows that revision "badger_1.180" 
introduced it, which you can verify by clicking on the link to the diff. 
This diff also says that the LIBCURL_VERSION_NUM (which is changed just 
after a release in the curl project) is 0x70a03. Thus, you should check 
for 0x70a03 instead of 0x70f05.

Ciao,
Dscho
