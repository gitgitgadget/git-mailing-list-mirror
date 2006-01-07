From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Does git belong in root's $PATH?
Date: Sat, 07 Jan 2006 12:40:05 -0800
Message-ID: <43C02725.2020702@zytor.com>
References: <Pine.LNX.4.64.0601070838470.6317@x2.ybpnyarg> <43C0025A.9080406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 21:40:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvKrO-00044i-RB
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 21:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWAGUkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWAGUkN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 15:40:13 -0500
Received: from terminus.zytor.com ([192.83.249.54]:31407 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161095AbWAGUkL
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 15:40:11 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k07Ke5P5008894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jan 2006 12:40:06 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C0025A.9080406@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14272>

Andreas Ericsson wrote:
> 
> Not including /usr/local/{bin,sbin} in root's path is considered wise, 
> since, historically, that's where users would install their own versions 
> of programs that the system doesn't provide. This use has largely been 
> obsoleted by $HOME/bin as the default for user-specific programs, mainly 
> because of disks getting larger and cheaper.
> 

Hmmm... I think that was /usr/bin (hence the eventual migration of the 
meaning of /usr from what was originally the equivalent of /home.)

Today /usr/local is strictly a location for site-local things; a place 
that won't conflict with the distribution.

	-hpa
