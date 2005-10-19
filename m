From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 13:55:35 -0700
Message-ID: <4356B2C7.601@zytor.com>
References: <4356A5C5.5080905@zytor.com> <7vmzl544f3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 22:57:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKyb-0002kr-Rh
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVJSUzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVJSUzz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:55:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62092 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751327AbVJSUzy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:55:54 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JKte3U007438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 13:55:40 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzl544f3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10306>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>It would, however, require a protocol change; I would like to hear what 
>>people think about this at this stac=ge.
> 
> Well, it is full two days since a majorly visible git protocol
> enabled server has been announced, and you probably know what
> kind of hits you are getting (and please let us know if you have
> numbers, I am curious).

About 350 hits so far, total.  Utter peanuts.

> If we do a protocol change, earlier the
> better.  You already said that the kernel.org git is
> experimental.  Does anybody run git daemons and rely on the
> current protocol? 
 >
> I suspect it would not make *any* sense to have a backward
> compatible server that optionally allows this cookie exchange --
> attackers can just say "I am an older client".  OTOH, it
> probably makes sense to have an option on the client side to
> skip the cookie exchange stage.  I do not think autodetecting
> new/old server on the client side in connect.c is possible.
> 

You mean an option on the *server* to skip the cookie exchange?  If so, 
how would you expect the client to handle it?

	-hpa
