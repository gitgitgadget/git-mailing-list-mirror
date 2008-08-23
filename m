From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sun, 24 Aug 2008 01:00:23 +0200
Message-ID: <48B09687.6070508@gnu.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org> <48AFD764.7010605@gnu.org> <20080823163638.GW23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 01:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX26w-0000QV-13
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 01:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbYHWXAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 19:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbYHWXA3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 19:00:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:4145 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYHWXA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 19:00:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so591737fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 16:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=7xY7SXLhTQjrrybrVvCBwVDqtuJDo4rtWSzgIYUrXA4=;
        b=uo1ybAxMMvyTcshLLDp2pm01yPb3Ak9y2UtqBH8dcL281G5HaTE4jvoTTCBHpyi5Qb
         oFuwtsReqhPdOWkT4Hm19uZY76OOyQyap6I25HlkwfPnBhbVQa+W6iomD0mix51G8Ma0
         4oC85YY4tlfTF14S23G50Va08dcZD2b77k5tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=tBY/FeLkO0j6yLxSwHwcEMNe88GrY+pq7R1hjfJJS/tsPHOM1vR7PNVJx3Tz13BHgI
         g91RvAA//v1VxHW1j5YUjdb8a4q8u+BErF8vf+yRe0XVdWcEr7tOGRMglj94vDPCbuN6
         xcALPx80UHahNKPees8SZ31sCrFF74+gy0O5w=
Received: by 10.86.71.1 with SMTP id t1mr2053858fga.36.1219532427263;
        Sat, 23 Aug 2008 16:00:27 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l12sm3355046fgb.6.2008.08.23.16.00.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 16:00:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080823163638.GW23334@one.firstfloor.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93501>

Andi Kleen wrote:
> On Sat, Aug 23, 2008 at 11:24:52AM +0200, Paolo Bonzini wrote:
>> Andi Kleen wrote:
>>>> Exactly. Don't rebase. And don't base your development on somebody who 
>>>> does.
>>> That's pretty much impossible in the current state of Linux development
>>> as far as I know.
>>>
>>>> Remember how I told you that you should never rebase?
>>> I suspect your recommendation does not match real world git use.
>> I think if you have to rebase often, you're actually better off using
> 
> [ ] You read my original email.
> 
> The issue is not that I'm rebasing [1],

Yes sorry, I meant: if you have to rebase your branches on top of
branches that also rebase, you're actually better off using stgit.

Paolo
