From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 11:38:14 +1300
Message-ID: <43FB9656.8050308@vilain.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:38:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBg9T-0001NZ-9r
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWBUWic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBUWic
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:38:32 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:26788 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750743AbWBUWic (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 17:38:32 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 112BA54F2; Wed, 22 Feb 2006 11:38:28 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 5972E55E4;
	Wed, 22 Feb 2006 11:38:19 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060221215742.GA5948@steel.home>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16569>

Alex Riesen wrote:
>>>Does not work here (ActiveState Build 811, Perl 5.8.6):
>>>$ perl -e 'open(F, "-|")'
>>>'-' is not recognized as an internal or external command,
>>>operable program or batch file.
>>Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.
> Sometimes an upgrade is just out of question. Besides, that'd mean an
> upgrade to another operating system, because very important scripts
> over here a just not portable to anything else but
>     "ActiveState Perl on Windows (TM)"
> I just have no choice.

Sure, but perhaps IPC::Open2 or some other CPAN module has solved this 
problem already.

I guess what I'm saying is that if you want to limit the modules that 
Perl script uses, you end up either impacting on the portability of the 
script or rediscovering problems with early wheel designs.

Sam.
