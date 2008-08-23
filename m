From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 11:24:52 +0200
Message-ID: <48AFD764.7010605@gnu.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWpNi-0001oS-C7
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbYHWJY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 05:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbYHWJY5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:24:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:15271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbYHWJY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:24:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so472663fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=HqO084vSzOx2oDuNzbJcxcrUiRphNFvDLQb0J1KqOuA=;
        b=MElYpqG9TrASNJifcGmSIRLrfO6ZlmmZqrnrR52B7zSF/LooWXtw7PgEvgCVR1REQ9
         1kiD+4t5BLWPqu2vYs04Ms0Bu/JEGNDe9r5X2EAgSNHqQV3UXcBiuzxEzk2DyMeTRUru
         cyG9pvhpPgURJ2Trn0c1DczqtsPCnwGEmuM+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=AZQ7UsUDKZLP4A8ebMDWasVlxDShJAd8MvPTp7U6RMwuP96cdGjCnDRj0c/SezCvjT
         TcKgYcQHOtu+0zDPM33W2s4Lwjs55IpWNCuPzgol1Yrc/iiJ/f82PfHukzYizuFnort1
         Pxacb6SgXaR++oscwaKt6teoL93oi8PMKigBw=
Received: by 10.86.63.19 with SMTP id l19mr1536045fga.77.1219483495639;
        Sat, 23 Aug 2008 02:24:55 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e20sm2263766fga.1.2008.08.23.02.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 02:24:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080823071014.GT23334@one.firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93451>

Andi Kleen wrote:
>> Exactly. Don't rebase. And don't base your development on somebody who 
>> does.
> 
> That's pretty much impossible in the current state of Linux development
> as far as I know.
> 
>> Remember how I told you that you should never rebase?
> 
> I suspect your recommendation does not match real world git use.

I think if you have to rebase often, you're actually better off using
stgit (patch queues is what the mercurial folks use instead of
often-rebased local branches).

Disclaimer: I am not an stgit user myself.

Paolo
