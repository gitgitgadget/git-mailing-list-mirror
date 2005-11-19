From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: git --exec-path conversion
Date: Sat, 19 Nov 2005 05:50:04 -0800 (PST)
Message-ID: <20051119135005.54838.qmail@web26314.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 14:52:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdT6e-00039R-Fl
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 14:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVKSNuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 08:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVKSNuI
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 08:50:08 -0500
Received: from web26314.mail.ukl.yahoo.com ([217.146.177.51]:29548 "HELO
	web26314.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751112AbVKSNuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 08:50:06 -0500
Received: (qmail 54840 invoked by uid 60001); 19 Nov 2005 13:50:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JkAxWhciyDjILFhNNwZp5MQiMAcJAol/xu1Eo+7B8jSZWfFCBe4J1muhI05Ogp66h/Y0kSpLbcF2IWjQgo1NbwlUUF7LmzeU/zTYg+ZddPrsx01D2vFJ65DKNICYwtbN8lfX/IP5IpjhqvNlMwmXpDY/PWS8ksze7WB+2CQzsBM=  ;
Received: from [151.44.24.124] by web26314.mail.ukl.yahoo.com via HTTP; Sat, 19 Nov 2005 05:50:04 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12338>

Junio C Hamano wrote:

>Marco Costalba <mcostalba@yahoo.it> writes:
>
>>if I understood correctly, git programs will be installed
>>somewhere in $PATH for at least next two months.
>
>
>I suspect things will stay in /usr/bin longer than that, but
>futureproofing is good in any case.
>
>Assuming you are writing things in C or C++:
>
> - run "git --exec-path" at the very beginning of main(),
> - read the output, prepend it to $PATH using setenv(3).
>
>and I think you are done. 

Yes. Thanks.




		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
