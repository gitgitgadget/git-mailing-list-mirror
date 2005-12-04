From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] A few more options for git-cat-file
Date: Sat, 03 Dec 2005 22:22:51 -0800
Message-ID: <43928B3B.90200@zytor.com>
References: <43924D1C.8070306@zytor.com> <7vu0dptmh3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 07:23:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EinHA-0000ws-An
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 07:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVLDGW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 01:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVLDGW5
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 01:22:57 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6839 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932206AbVLDGW4
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 01:22:56 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB46MpET024406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 22:22:51 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0dptmh3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13179>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>This adds the following options to git-cat-file:
>>
>>-n, to get the canonical name of a resource.  This is for one thing 
>>useful in tagging scripts.
> 
> Isn't "git-rev-parse --verify" good enough?
> 

Ah, yes.  Except for the fact that I couldn't find it when I looked for 
a command that did that.  git-rev-parse seems like an eclectic mixture 
of stuff, and the name isn't very clear as to what it does.

> 
>>-e, to test for the existence of a file.
> 
> This might be useful and cleaner than "cat-file -s >/dev/null"
> but marginally so.  While reading the whole file and discarding
> that to /dev/null is wasteful and would go against tastes of
> many people, -t and -s flags do not need to read the whole thing
> and not so expensive.

Still, -e as implemented here is definitely cheaper.

	-hpa
