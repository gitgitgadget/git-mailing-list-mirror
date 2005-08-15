From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE] qgit-0.9
Date: Mon, 15 Aug 2005 03:22:47 -0700 (PDT)
Message-ID: <20050815102247.42129.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 12:23:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4c7N-0007sY-Ot
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVHOKWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 06:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVHOKWz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 06:22:55 -0400
Received: from web26305.mail.ukl.yahoo.com ([217.146.176.16]:64946 "HELO
	web26305.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932616AbVHOKWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 06:22:54 -0400
Received: (qmail 42131 invoked by uid 60001); 15 Aug 2005 10:22:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=B/BfmQB617tHmgUPQ5sAEgrPpKJWAu5H7wZPZ5KVZZCQ2T6AiNKfWJRJkaXcq2h3HVr17gWImPA2AG5qAU4Aq/S7cOSd/HzHgdg3pBCs6JZkYhQ3r0I/Xb2umjywEyjnl/hVLVcsc69sqVmYCdFsr0EU81Rb3Yle8l5Y2eyik0g=  ;
Received: from [151.38.109.31] by web26305.mail.ukl.yahoo.com via HTTP; Mon, 15 Aug 2005 03:22:47 PDT
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff wrote:

>I figured out that it wanted qt3-mt, installed it, and fiddled with
>the SConfiguration file.  Still no dice, perhaps because I have a qt4
>build environment?


I have qt 3 3.3.4 installed and I never dared to hope qgit can compile
with qt4, being a so huge compatibility break.

Now I am sure of it ;-)


>I actually like it quite a bit. So, notes for the build instructions:
>under debian, you want  to
>
>  apt-get install qt3-dev-tools libqt3-mt-dev
>
>Make sure there's_no_ qt4 build environment, edit SConstruct and have
>the env.Append line look like:
> 
>  env.Append( CPPFLAGS = ['-DQT_THREAD_SUPPORT', '-D_REENTRANT',
>'-I/usr/include/qt3'] )
>


With this modification qgit compiles also on no Debian platform, so I
have applied it to my tree too. Thanks ;-)


>And then make it, saying:
>
>  QTDIR=/usr make
>

Peraphs it is possible to teach SConstruct to understand 
also this last line?
So Debian users don't need to tweak anything.

>cheers,
>
>martin
>-

Thanks 
Marco



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
