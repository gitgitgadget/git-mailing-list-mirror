From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: GIT character codecs
Date: Sun, 13 Nov 2005 12:52:40 -0800 (PST)
Message-ID: <20051113205241.70221.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 21:54:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbOqD-0001la-A1
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 21:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVKMUwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 15:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVKMUwm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 15:52:42 -0500
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:26720 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751024AbVKMUwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 15:52:42 -0500
Received: (qmail 70223 invoked by uid 60001); 13 Nov 2005 20:52:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=N6ZO9n0de6pEZP9ExxbkzRHnKBLsCAtIrMUM7KxBaD5CRleQhR9NqRKtpITNy4ec/Lb0dOy3nXH/kRT8iHp3p580stE+o6xMvEadpcJLmMTsQG10FUOj9jL4GdJI3kIEPvdoOOntA2xZeZSw7bhsPExMEo2FAnG2yNMrTklYWGQ=  ;
Received: from [151.56.23.39] by web26301.mail.ukl.yahoo.com via HTTP; Sun, 13 Nov 2005 12:52:40 PST
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11752>

Linus Torvalds wrote:

>
>On Sun, 13 Nov 2005, Marco Costalba wrote:
>
>>If encoding is a per-blob _and_ per-log message property a real solution, although cumbersone,
>>could be that git stores encoding togheter with the blob and the commits.
>
>
>We'd be much better off with just saying "we encourage people to use 
>utf-8, but if you don't, just set your locale to make things show up 
>properly".
>
>utf-8 is clearly the future, and if we make git internally aware of 
>locales, that's just going to complicate things. And usually for no good 
>reason, since users don't really care that much.
>

Yes, I agree with you and Junio, a workaround like let the user to choose the code page 
in the viewer is more then enough.

And also in this case, a choice between the local codec and utf-8 should take almost 
all cases.

Because of this, I added a text codec selector in qgit, reachable from settings menu.

There is a new release, qgit-0.97.2, with this new feature and some good
annotate fixes.

For the people interested the page with all the links is:
 http://digilander.libero.it/mcostalba/

  Marco

P.S: Now I can finally see Junio japanese name ;-)



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
