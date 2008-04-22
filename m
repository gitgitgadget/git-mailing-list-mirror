From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 18:23:36 +0200
Message-ID: <480E1108.5090701@gnu.org>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422133926.GB3098@mithlond.arda.local> <alpine.DEB.1.00.0804221449240.4460@eeepc-johanness> <20080422140440.GC3098@mithlond.arda.local> <480DF1E7.5040900@gnu.org> <alpine.DEB.1.00.0804221607190.4460@eeepc-johanness> <480E03A9.3040401@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 22 18:24:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLID-0000pd-GW
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbYDVQXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbYDVQXm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:23:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:12382 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbYDVQXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 12:23:41 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2243551fgb.17
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:newsgroups:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=Nc1fW3C8ZnLqxh/n0QCVUTCBFZYNRVTORP4lpHr+tco=;
        b=HF6F/H3zV8S75PAKehL1tU32+M+i4mtCPxiN9oP91tHzzc9hLUCDRYcuP4OVYaqLvM0TNyGEh9Aq+hs2vQDYJmNDvIkgUmuyVL7sz8UuEEm0/eFL1Ta2x2zViW2AOF/ZJSKlaoMQ4j9i3IgWY9zKcQvBgCYL79rcllhq2aBriCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=oxW5mVhg//aKUCOm1QBULni2uBD7ojjJ9wxVcG07PPET/8e0V0xsBXPxECsYV5pTaVaubpEeFx0rBvovKykJgtciLcSyT7yySwTgg6oK4DxG33b9K1wEy/AfuXxVX0uXPiVQ7H8yAE5cB9XguJ+z5J9gApPyLIxUzGLzHa8dsRY=
Received: by 10.86.94.11 with SMTP id r11mr925138fgb.1.1208881419557;
        Tue, 22 Apr 2008 09:23:39 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 12sm5180562fgg.6.2008.04.22.09.23.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Apr 2008 09:23:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <480E03A9.3040401@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80132>

>>> What about changing --mirror to add a push line instead of a fetch line?
>>
>> I would not expect --mirror to add a push line when "git-remote add" 
>> without --mirror does not a push line either.
> 
> Let me reverse the question.  When does it make sense to use "git-remote 
> add --mirror" with the current implementation?
> 
> It's not a rhetoric question.  I know when it would make sense to have 
> push refspecs on a remote for which you plan to use "git push --mirror" 
> (and in "next", that is the case if you create the remote with 
> "git-remote add --mirror").  But I'm a total newbie for things that do 
> not fit my workflows, so I don't know when it would make sense to pull 
> from that kind of remote.

And actually, I just realized that what I expected from --mirror is this:

[remote "mirror"]
         url = blah
         fetch = +refs/heads/*:refs/remotes/mirror/*
         push = +refs/heads/*:refs/heads/*
         mirror

... so that I can check the state of the mirror with "git log -1 
mirror/master", and still the push refspec is there so that my local 
remotes are not entirely mirrored.

Paolo
