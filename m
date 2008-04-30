From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Wed, 30 Apr 2008 07:28:33 +0200
Message-ID: <48180381.9070801@gnu.org>
References: <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home> <48178FD6.90104@gnu.org> <20080429213323.GA2413@steel.home> <48179625.3050704@gnu.org> <alpine.DEB.1.00.0804292324040.13650@eeepc-johanness> <20080429230237.GA22598@sigill.intra.peff.net> <7vzlrc45ex.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, spearce@spearce.org, srb@cuci.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 07:29:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr4sb-0000mm-3E
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 07:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbYD3F2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 01:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYD3F2e
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 01:28:34 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:41770 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbYD3F2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 01:28:33 -0400
Received: by hu-out-0506.google.com with SMTP id 19so351935hue.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 22:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=wQdxnPzdN/t8cUuQ4e7UxX+fVJJAw5rHONvDAVBllPA=;
        b=mo5p89H5EuhcYs9XimguQg5KKGGGbSM5261jXCdbCj+fYmEIWc9dJkkec5F2lDybqgA5l2/dTEj4HA//INqAiR5dcmh3evalJbu2NPsuyB5TdmtvryG02/Ib/kflYZrinX0v/8S3Jzm+LYqvTLf0ZfvYKw9EJV8lcLB8ldGfRvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=u3pghl+atKvjB5e9EaL+Ti+mtayr6bL+6xRr3aOX0TyO88eaZ5ECCo7ZF61V65RVUVpaNzjcq3JG/LzGv7vnAVurO5E4TLl9LG7NfxdUG4FVCcn+EFlyPTiMk6TfnW5Tl3+LNO8LFLXq56qyyx71Vm10ta/wnRVFhkbYfnAWx6o=
Received: by 10.86.54.3 with SMTP id c3mr298203fga.58.1209533311748;
        Tue, 29 Apr 2008 22:28:31 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d4sm114423fga.4.2008.04.29.22.28.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 22:28:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7vzlrc45ex.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80793>

> Do you really think that it is a good idea to push down a huge change like 
> this down everybody else's throat, just because you do not want to type 
> "git remote ..." but "git fetch ..." in your workflow?

It's not that I don't want.  I couldn't care less, but I just don't see 
why I should have learnt it in the first place.

>> I wonder this a bit, too, and I am even somebody who _likes_ the new
>> behavior. But there is a difference between "should have been designed
>> this way in the first place" and "is currently designed some other way,
>> and will cause pain to switch it to this way."

Agreed.

>> So it might simply not be worth the trouble to change. OTOH, I think
>> this is how we end up with many commands to do slightly different
>> things, which can end up confusing new users. I'm not sure what the
>> right answer is.
> 
> Well, the thing is, push and fetch are different, so expecting the same
> behaviour and syntax from them is a lost cause to begin with.  Even if we
> were designing fetch and push right now, I do not necessarily think the
> series shows a way that "should have been designed in the first place".

To me, "push and pull" are different obviously (because pull modifies 
two refs, the remote one and the local one).  But "push and fetch" are 
not so different, so I do expect lots of different options but the gist 
of the command-line syntax to be the same.

There are definitely uncontroversial changes in the series, we can start 
from there.

Paolo
