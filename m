From: "Miles Bader" <miles@gnu.org>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 7 Nov 2008 13:38:16 +0900
Message-ID: <fc339e4a0811062038x22e7a3co503f09678f9ff5aa@mail.gmail.com>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
	 <20081106213711.GA4334@blimp.localdomain>
	 <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 05:39:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyJ8B-0003u5-Ec
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 05:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbYKGEiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 23:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755322AbYKGEiT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 23:38:19 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:62568 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbYKGEiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 23:38:17 -0500
Received: by yw-out-2324.google.com with SMTP id 9so396394ywe.1
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 20:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=5xX4BuM0VhfX3rIskt5E955aXFwB9bAgiAKStqrCBgI=;
        b=O2h1OTeMrsmK9Q6dRS0S8tR/4jDDJKmwC7rmPhu7GR+f1eyiYMly0deOaFyMlRiZFW
         jwgOG8fE1hENekbATWW+wpg1DnGNSOadRAGWlXx/nHjmevJ/Qw9AGqcWtN7ctXpRWRBc
         hV3AaCUU853zCRm6d4gm90LFmkMF7PL/eM4r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=jkmBVCAwk4gaac5tF+LIJmppV2s8gWBjOndXNxcr/lT6QN77Yz17L1w0c/2RVpebhf
         z3J/lI742BC6ZcZT0dOVG2M0Jwulu99kgcWl9qxjHZLLQsxNMTcubJlJ+C94t+c9xrzo
         VHU3leHf9KdkaH3UqMvez+o6q/Gp7g/BhYGrc=
Received: by 10.231.39.65 with SMTP id f1mr1006640ibe.25.1226032696124;
        Thu, 06 Nov 2008 20:38:16 -0800 (PST)
Received: by 10.141.106.8 with HTTP; Thu, 6 Nov 2008 20:38:16 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 60b79ac1e276af7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100285>

>> git format-patch --full-index --binary --stdout <range...> | git am -3
>>
>> This will not work if you want to pick a list, not a range, of
>> commits.
>
> Doesn't "--no-walk" + list commits individually work?
>
> So it _should_ be possible to pick a list of commits too. Although I think
> that git format-patch will reverse the order.

Incidentally, the reason I like a rebase-based solution is that many
of the rebase features like -i, --abort, and --continue (after
conflict resolution) are very nice for the multi-cherry-pick case too,
and I'm already very familiar with their operation from using rebase.

[git-am seems to have some similar features, but I don't know how well
they work.]

-Miles

-- 
Do not taunt Happy Fun Ball.
