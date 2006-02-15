From: Sam Vilain <sam@vilain.net>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 13:22:53 +1300
Message-ID: <43F2745D.4010800@vilain.net>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chuck Lever <cel@citi.umich.edu>,
	=?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 01:23:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9AS1-0007dj-0L
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 01:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWBOAXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 19:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBOAXS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 19:23:18 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:15264 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422885AbWBOAXR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 19:23:17 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 97FCE4C24; Wed, 15 Feb 2006 13:23:04 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 177071955;
	Wed, 15 Feb 2006 13:22:57 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060214222913.GK31278@pasky.or.cz>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16195>

Petr Baudis wrote:
>>my impression of git is that you don't change stuff that's already 
>>committed.  you revert changes by applying a new commit that backs out 
>>the original changes.  i'm speculating, but i suspect that's why there's 
>>a "stg pick --reverse" and not a "stg uncommit."
> It is ok as long as you know what are you doing - if you don't push out
> the commits you've just "undid" (or work on a public accessible
> repository in the first place, but I think that's kind of rare these
> days; quick survey - does anyone reading these lines do that?), there's
> nothing wrong on it, and it gives you nice flexibility.

Yes, and this is one problem I envision with publishing a git repository
with an stgit stack applied - somebody later doing a pull of it will not
find the head revision they had.  I'm not sure what the net effect of
this will be, though.

Sam.
