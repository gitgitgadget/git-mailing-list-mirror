From: Francis Daly <francis@daoine.org>
Subject: Re: gitweb testing with non-apache web server
Date: Fri, 4 Aug 2006 20:48:40 +0100
Message-ID: <20060804194840.GM17966@craic.sysops.org>
References: <20060803202703.GA13147@buici.com> <20060803235536.GJ17966@craic.sysops.org> <20060804061122.GA15755@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 21:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G95f7-0003D1-Dp
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 21:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161380AbWHDTsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWHDTsq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 15:48:46 -0400
Received: from craic.sysops.org ([217.75.2.2]:42373 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S932609AbWHDTsp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 15:48:45 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k74Jme8E005942;
	Fri, 4 Aug 2006 20:48:41 +0100
To: Marc Singer <elf@buici.com>
Content-Disposition: inline
In-Reply-To: <20060804061122.GA15755@buici.com>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.88/1634/Wed Aug  2 23:32:49 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24828>

On Thu, Aug 03, 2006 at 11:11:22PM -0700, Marc Singer wrote:
> On Fri, Aug 04, 2006 at 12:55:36AM +0100, Francis Daly wrote:

> > Or use a web server which isn't broken in this particular way.
> 
> :-) There doesn't seem to be much of the 'small' variety.  Though now
> I'll look into lighttpd as well.

I've had some success with thttpd, which is broken in a different way
which doesn't appear to affect gitweb.

$ cp gitweb.cgi g
$ thttpd -p 8080 -d . -c '/g' 
$ $BROWSER http://localhost:8080/g

for example.  Adjust the config to fit your overall site need, of course.

-h localhost, or -l /dev/null, or -D, may also be useful.  There's a Fine
Manual out there.

Good luck,

	f
-- 
Francis Daly        francis@daoine.org
