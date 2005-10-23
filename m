From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: git-rev-list: add "--dense" flag
Date: Sun, 23 Oct 2005 12:30:27 -0700 (PDT)
Message-ID: <20051023193027.2437.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 23 21:31:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETlYG-0005nx-OD
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 21:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVJWTaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 15:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVJWTae
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 15:30:34 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:52845 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750716AbVJWTae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 15:30:34 -0400
Received: (qmail 2439 invoked by uid 60001); 23 Oct 2005 19:30:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eCnuqMVDhv0HQ3rsBpLTYZO0sR3flV3loQckzDlKOlO9rRuYOEVLQ7Q1c9yYqeoOjoG13q4qEIewgoUqz/G1fponRfp8IKrtVnUo7lqUxtg9wvP2LjdsPpDXQ/EIzEipEMruE4HZBkhYEPtxeUOXnPm3Qh2Ynit6954MD9p14BI=  ;
Received: from [151.42.224.10] by web26303.mail.ukl.yahoo.com via HTTP; Sun, 23 Oct 2005 12:30:27 PDT
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10502>

Linus Torvalds wrote:

>
>And it scales pretty well too. On the historical linux archive, which is 
>three years of history, the same thing takes me just over 12 seconds and 
>52MB, and that's for the _whole_ history. And it's not just following one 
>file: it's following that subdirectory.
>
>So it really is pretty damn cool. 
>

Yes, it is. Very powerful and useful tool indeed. IMHO kudos!

>Of course, I might have a bug somewhere, but it all _seems_ to work very 
>well indeed.
>

The only bug I found is in qgit ;-) that failed to correctly handle --dense option.

It is now fixed in my GIT archive: http://digilander.libero.it/mcostalba/qgit.git


    Marco



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
