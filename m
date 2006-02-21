From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 09:36:50 +1300
Message-ID: <43FB79E2.1040307@vilain.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>	 <20060220191011.GA18085@hand.yhbt.net>	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 21:37:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBeGN-0007mW-0r
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 21:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWBUUhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 15:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWBUUhD
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 15:37:03 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:18084 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932703AbWBUUhA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 15:37:00 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id BBA74555D; Wed, 22 Feb 2006 09:36:58 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id A80D3454B;
	Wed, 22 Feb 2006 09:36:51 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16547>

Alex Riesen wrote:
> On 2/20/06, Junio C Hamano <junkio@cox.net> wrote:
> 
>> * Eric, thanks for the hint.  I have this four-patch series.
>>   Could people with perl 5.6 please check them?
> 
> 
> Does not work here (ActiveState Build 811, Perl 5.8.6):
> 
> $ perl -e 'open(F, "-|")'
> '-' is not recognized as an internal or external command,
> operable program or batch file.

Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.

Sam.
