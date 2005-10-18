From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 16:44:09 -0400
Message-ID: <43555E99.1010902@didntduck.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org> <43552FC2.3000000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 22:45:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERyID-0004Vp-C5
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVJRUmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVJRUmi
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:42:38 -0400
Received: from quark.didntduck.org ([69.55.226.66]:2980 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751493AbVJRUmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 16:42:38 -0400
Received: from [172.21.26.77] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j9IKgV413875;
	Tue, 18 Oct 2005 16:42:32 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <43552FC2.3000000@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10229>

H. Peter Anvin wrote:
> Kay Sievers wrote:
> 
>>
>>> Most of the hits we get are either the gitweb front page or the 
>>> gitweb rss feeds, and it's eating I/O bandwidth like crazy.
>>
>>
>> I tested some stuff on these boxes and 30 stat() calls alone take app. 
>> 2 seconds
>> on these boxes cause of I/O load ... :)
>>
> 
> Welcome to my hell :)
> 
> I set up mod_cache (which I didn't know about, silly me) and so far it 
> seems to work and has produced a tremendous decrease in load and 
> improvement in response time.  I do, have, however, a request.  There 
> are some gitweb pages which are more likely to change than others; in 
> particular, some gitweb pages will *never* change (because they directly 
> reflect immutable git data.)
> 
> If gitweb could produce Last-Modified and Expires headers where 
> appropriate, it should improve caching performance.
> 
>     -hpa

Some other areas for improvement would be to seperate out the git icon 
and the style sheet into seperate static files.

--
				Brian Gerst
