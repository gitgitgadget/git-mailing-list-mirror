From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Fri, 24 Feb 2006 09:31:25 +1300
Message-ID: <43FE1B9D.10403@vilain.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com> <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> <7virr5hnw4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602231143290.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 21:31:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCN7k-00039R-OT
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 21:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWBWUbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 15:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWBWUbh
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 15:31:37 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:48293 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932113AbWBWUbh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 15:31:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id C0A994EF9; Fri, 24 Feb 2006 09:31:32 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id BF51E1C1B;
	Fri, 24 Feb 2006 09:31:26 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602231143290.3771@g5.osdl.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16664>

Linus Torvalds wrote:
>>>There are many portable interpreters out there, and I don't mean perl. And 
>>>writing a small "specialized for git" one isn't even that hard. In fact, 
>>>most of the shell (and bash) hackery we do now would be unnecessary if we 
>>>just made a small "git interpreter" that ran "git scripts".
>>Before anybody mentions tcl ;-).
> Well, I was thinking more of the "embeddable" ones - things that are so 
> small that they can be compiled with the project. Things like Lua.
   [...]
> I was really thinking more of a simple shell-like script interpreter. 

I like the term "Domain Specific Language" to refer to this sort of 
thing.  It even hints at using the right kind of tools to achieve it, too :)

Sam.
