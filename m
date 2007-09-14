From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [ANNOUNCE] tig-0.9
Date: Fri, 14 Sep 2007 13:44:21 -0400
Message-ID: <719DD02E-5BA3-477E-ABBB-C385BF43EF9E@silverinsanity.com>
References: <20070913094512.GA28750@diku.dk> <F6776054-00EC-49E8-B4C8-BB0EAB3939AB@silverinsanity.com> <46EAC5C4.6020403@midwinter.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:55:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFDH-0002LP-HZ
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbXINRoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbXINRoQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:44:16 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34150 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbXINRoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 13:44:15 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id DDDA01FFC232;
	Fri, 14 Sep 2007 17:44:14 +0000 (UTC)
In-Reply-To: <46EAC5C4.6020403@midwinter.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58168>


On Sep 14, 2007, at 1:32 PM, Steven Grimm wrote:

> Brian Gernhardt wrote:
>> Complete build failure using autoconf here.  Just using the  
>> Makefile like I always have works fine, but "autoconf ; ./ 
>> configure" (from the git repo) fails with "configure: error: iconv 
>> () not found. Please install libiconv."  This confuses me because  
>> I have /usr/lib/libiconv.dylib, and compiling with -liconv works.   
>> I fail to have the autoconf-foo to figure out what's wrong.
>
> Try "aclocal ; autoconf ; ./configure".

Yes, remembering to regenerate the configure script would have been  
smart.  Works perfectly, thank you.

~~ Brian
