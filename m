From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 17:26:33 +0200
Message-ID: <480E03A9.3040401@gnu.org>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422133926.GB3098@mithlond.arda.local> <alpine.DEB.1.00.0804221449240.4460@eeepc-johanness> <20080422140440.GC3098@mithlond.arda.local> <480DF1E7.5040900@gnu.org> <alpine.DEB.1.00.0804221607190.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 17:27:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoKP3-0002D0-EC
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 17:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764171AbYDVP0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934118AbYDVP0h
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 11:26:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:27152 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764171AbYDVP0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 11:26:36 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2225041fgb.17
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=DkuZDDb8Tkcs8pA5DsqSxgq3hywikZeZtZs1ScAwLPs=;
        b=c9+jgUEAYWKIfrNoxGw6dgLp+svLunp8UldGyQPHIj4fgRWFk+RoOO2n/Yd+o5uA9c/pBjlzcOgsAXm98InhKAcYhAL+52+/zmX68o5dur0vbn6PLbtVfDbqrnHP0W8sOmdz2e9X2nqpd+GvSlVBDFfKBA9I7NDaw39xsQe4rgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=q+8k/XZAo9peFAmdS0V7LPhWFFqu7+J82jQZRLe9srL7nahQLo6cYsMZVBHT5aEVQWuYtwIrdqmLKzSgs/EWFyMz1rUMMKpRqtkKDNwhstnLXjyC16Jg2EDOSBB6Idzqy8t91zrr6LuCOljI3IIgvKf98f0CZ4qvHN5x3Bh0ybM=
Received: by 10.86.74.15 with SMTP id w15mr765743fga.34.1208877994293;
        Tue, 22 Apr 2008 08:26:34 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 3sm5101552fge.7.2008.04.22.08.26.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Apr 2008 08:26:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804221607190.4460@eeepc-johanness>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80131>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 22 Apr 2008, Paolo Bonzini wrote:
> 
>>>> Okay, how about this: take Peff's patch, but add a warning if 
>>>> --mirror is used on a non-bare repository?
>>> Sounds good to me. Indeed, giving a warning is _very_ good idea as 
>>> --mirror is potentially, even likely, destructive with local changes 
>>> and working directory.
>> What about changing --mirror to add a push line instead of a fetch line?
> 
> I would not expect --mirror to add a push line when "git-remote add" 
> without --mirror does not a push line either.

Let me reverse the question.  When does it make sense to use "git-remote 
add --mirror" with the current implementation?

It's not a rhetoric question.  I know when it would make sense to have 
push refspecs on a remote for which you plan to use "git push --mirror" 
(and in "next", that is the case if you create the remote with 
"git-remote add --mirror").  But I'm a total newbie for things that do 
not fit my workflows, so I don't know when it would make sense to pull 
from that kind of remote.

Paolo
