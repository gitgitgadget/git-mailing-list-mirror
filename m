From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 10:50:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com> 
 <1154018302.13273.0.camel@dv>  <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
  <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org> 
 <b8bf37780607271017p22fa908bt82a564a4a1a15a79@mail.gmail.com>
 <b8bf37780607271025m1a611006x65a900e9e487ce1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1989458902-1154022623=:4168"
Cc: Pavel Roskin <proski@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:50:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6A0V-0000vI-5y
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWG0Rul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWG0Rul
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751865AbWG0Ruj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:50:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RHoTnW014426
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 10:50:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RHoOr3010847;
	Thu, 27 Jul 2006 10:50:26 -0700
To: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
In-Reply-To: <b8bf37780607271025m1a611006x65a900e9e487ce1b@mail.gmail.com>
X-Spam-Status: No, hits=-0.568 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24325>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1989458902-1154022623=:4168
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 27 Jul 2006, André Goddard Rosa wrote:
> 
> The problem happened again, and it stalls AFAICS.
> Can you reproduce there?
> 
> # git clone git://source.mvista.com/git/linux-davinci-2.6.git

Nope. I have a fairly constant 120kbps, and:

[torvalds@g5 ~]$  git clone git://source.mvista.com/git/linux-davinci-2.6.git
Checking files out...)      
 100% (19754/19754) done

here

		Linus
--21872808-1989458902-1154022623=:4168--
