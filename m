From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: git --exec-path conversion
Date: Sat, 19 Nov 2005 03:32:46 -0800 (PST)
Message-ID: <20051119113247.91022.qmail@web26311.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 12:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdQy1-0002Sw-9U
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 12:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVKSLcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 06:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKSLcy
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 06:32:54 -0500
Received: from web26311.mail.ukl.yahoo.com ([217.146.177.48]:60548 "HELO
	web26311.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751080AbVKSLcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 06:32:53 -0500
Received: (qmail 91024 invoked by uid 60001); 19 Nov 2005 11:32:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3N5OCNRvOHmwOXr/dACyVfo9FYgOH2hgyFJkCjp1tgnw7ChHTFPe7ZOOCBUTYLRr6BhweyYOmn70nmah0UvyWQuenYuXYXHVhCA04I7Q0XrBu21cvF8ujrAiL7ZRXzMfm8JPd7LclqZsBPcew2N9VcJBvI3QTQ6mcPE2RjEJmRg=  ;
Received: from [151.44.24.124] by web26311.mail.ukl.yahoo.com via HTTP; Sat, 19 Nov 2005 03:32:46 PST
To: Johannes.Schindelin@gmx.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12330>

Johannes Schindelin wrote:

>Hi,
>
>On Sat, 19 Nov 2005, Marco Costalba wrote:
>
>>    if (cmd.left(3) == "git") 
>>         cmd = cmd.prepend(exec-path);
>
>
>Little nit: Test for "git-", because "git" and "gitk" will stay in the 
>PATH.
>
You are rights. Thanks.

Also 'exec-path' is not a valid C++ identifier, it should be

    if (cmd.left(4) == "git-") 
         cmd = cmd.prepend(exec_path);


Incredible how many errors in only two lines of code :-)

Marco



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
