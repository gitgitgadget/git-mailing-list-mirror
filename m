From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git daemon directory munging?
Date: Sun, 04 Jun 2006 19:59:37 -0700
Message-ID: <44839E19.8070007@zytor.com>
References: <E1Fn4Xf-0000bL-82@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 04:59:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn5Jo-0007ru-Nx
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 04:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWFEC7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 22:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWFEC7t
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 22:59:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31925 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932393AbWFEC7t
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 22:59:49 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k552xbel021148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 19:59:38 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1Fn4Xf-0000bL-82@jdl.com>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21309>

Jon Loeliger wrote:
>> Well, you can bind different git daemons to different IP addresses 
>> (IP-based vhosting) or different ports (with SRV records in DNS.)
> 
> Is there existing support for telling the git-daemon what
> specific IP to bind to out of an inetd setup and I just
> missed it?
> 

No, but that really should be added.  It's a pretty trivial hack.

> I could set that up realatively easily and gain the 
> functionality I wanted that way too.
> 
> I've also hacked in a host interpolation too.
> 
> But like you said, canonicalizing it and checking it is likely
> a bit of a pain.  I've side-stepped one angle of that by
> symlinking in my /pub directory for multiple different
> hostnames too.  :-)
> 

Doesn't work very well.  DNS is case-insensitive, and worse, there are 
the PunyCode aliases or whatever they're called.

	-hpa
