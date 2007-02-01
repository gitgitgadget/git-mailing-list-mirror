From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Thu, 01 Feb 2007 09:51:51 -0800
Message-ID: <45C228B7.7080301@zytor.com>
References: <7vireuaj9d.fsf@assigned-by-dhcp.cox.net> <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net> <45B928AD.50508@zytor.com> <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BBCD27.5050408@zytor.com> <Pine.LNX.4.63.0702011501250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C2124C.5070308@zytor.com> <Pine.LNX.4.63.0702011749100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C21BA0.4080700@zytor.com> <20070201173234.GA29170@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 18:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCg6v-0008HL-BG
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbXBARv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbXBARv7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:51:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:57505 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422791AbXBARv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:51:58 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l11HppKG016425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Feb 2007 09:51:52 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <20070201173234.GA29170@moooo.ath.cx>
X-Virus-Scanned: ClamAV 0.88.7/2511/Thu Feb  1 06:55:18 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38384>

Matthias Lederhofer wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
>> Yes, it does matter, because it drives the load up further.  If you 
>> start having this going on in overlapping instances, then you're soon on 
>> the downhill slope of a cascading failure.
> Add some other locking mechanism.
> 
>> And we have already experimented with it.  It unfortunately doesn't help 
>> much, it only makes matters worse.
> The gitweb overview page has less than one hit per minute?  Otherwise
> this should help.

We already cache it with a forced duration of some 15 minutes.  The end 
result is exactly the same.

	-hpa
