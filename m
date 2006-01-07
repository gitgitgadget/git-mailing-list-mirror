From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Does git belong in root's $PATH?
Date: Sat, 07 Jan 2006 12:49:04 -0800
Message-ID: <43C02940.9040606@zytor.com>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg> <Pine.LNX.4.64.0601071023250.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: walt <wa1ter@myrealbox.com>, Sam Ravnborg <sam@ravnborg.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 21:49:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvL09-000646-SD
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 21:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWAGUtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 15:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWAGUtS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 15:49:18 -0500
Received: from terminus.zytor.com ([192.83.249.54]:27777 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161088AbWAGUtS
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 15:49:18 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k07Kn4or009015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jan 2006 12:49:04 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601071023250.3169@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14274>

Linus Torvalds wrote:
> 
> Maybe it would be best to remove the "vmlinux" dependency from "make 
> install" (so that "make install" will do exactly that: just install).  I 
> think all the documentation already tells you to do a "make" and then a 
> "make install".
> 

I would very much agree with this change; it's a nuisance that "make 
install" can't be cleanly run as root without leaving root turds in the 
build directory.

(Speaking as the person who did the original "make install" patch about 
12 years ago.)

	-hpa
