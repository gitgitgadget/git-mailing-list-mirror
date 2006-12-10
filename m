X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 23:05:07 -0800
Message-ID: <457BB1A3.2070408@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>	 <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com>	 <200612091251.16460.jnareb@gmail.com> <457AAF31.2050002@garzik.org> <46a038f90612091955i5bdd6e85l749a2f511f27953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 07:05:57 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>, Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <46a038f90612091955i5bdd6e85l749a2f511f27953@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.6/2312/Sat Dec  9 10:46:45 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33869>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtIkx-0004XO-Au for gcvg-git@gmane.org; Sun, 10 Dec
 2006 08:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760316AbWLJHFg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 02:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760318AbWLJHFg
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 02:05:36 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55468 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1760309AbWLJHFf (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 02:05:35 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net
 [67.180.238.27]) (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7)
 with ESMTP id kBA758GC009226 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Sat, 9 Dec 2006 23:05:08 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 12/10/06, Jeff Garzik <jeff@garzik.org> wrote:
>> > P.S. Can anyone post some benchmark comparing gitweb deployed under
>> > mod_perl as compared to deployed as CGI script? Does kernel.org use
>> > mod_perl, or CGI version of gitweb?
>>
>> CGI version of gitweb.
>>
>> But again, mod_perl vs. CGI isn't the issue.
> 
> IO is the issue, and the CGI startup of Perl is quite IO & CPU
> intensive. Even if the caching headers, thundering herds and planet
> collisions are resolved, I don't think you'll ever be happy with IO
> and CPU load on kernel.org running gitweb as CGI.
> 

I/O - nonexistent; that stuff will be in memory.

CPU - we have more CPU than you can shake a stick at, and it's 95+% idle.

*NOT AN ISSUE*.

