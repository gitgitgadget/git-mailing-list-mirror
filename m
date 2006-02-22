From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 08:51:44 +1300
Message-ID: <43FCC0D0.5050307@vilain.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>	 <20060220191011.GA18085@hand.yhbt.net>	 <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>	 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>	 <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 20:52:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC01o-0005qE-Vz
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 20:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWBVTv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 14:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWBVTv5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 14:51:57 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56996 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422662AbWBVTv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 14:51:56 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id E5D72577F; Thu, 23 Feb 2006 08:51:52 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 91EBF4C76;
	Thu, 23 Feb 2006 08:51:45 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16612>

Alex Riesen wrote:
>>I guess what I'm saying is that if you want to limit the modules that
>>Perl script uses, you end up either impacting on the portability of the
>>script or rediscovering problems with early wheel designs.
> IPC::Open{2,3} seem to be installed on every system I have access to.

Checking in Module::CoreList, that module goes right back to the Perl 
5.0 release, so every normal Perl 5 distribution should have it.

Sam.
