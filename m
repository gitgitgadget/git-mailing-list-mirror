From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 14:59:25 -0700
Message-ID: <4356C1BD.5060806@zytor.com>
References: <4356A5C5.5080905@zytor.com>	<7vmzl544f3.fsf@assigned-by-dhcp.cox.net> <4356B2C7.601@zytor.com> <7vek6h43oj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 00:02:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESLyI-0007Qm-Hh
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVJSV7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVJSV7i
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:59:38 -0400
Received: from terminus.zytor.com ([192.83.249.54]:57297 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751373AbVJSV7h
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 17:59:37 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JLxUDg009730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 14:59:31 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek6h43oj.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10315>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>You mean an option on the *server* to skip the cookie exchange?  If so, 
>>how would you expect the client to handle it?
> 
> No, what I was thinking was to tell the client "you will be
> talking to an old server, so do not try to read that cookie and
> get stuck".
> 

Oh, right.

	-hpa
