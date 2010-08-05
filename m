From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 15:18:15 -0400
Message-ID: <AANLkTimzn05tvwY=uG6VP6PXDHwA=wS9ECuK_9eWKtSx@mail.gmail.com>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
	<20100805001629.GC2901@thunk.org>
	<7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
	<7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
	<20100805173635.GA15760@sigill>
	<7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
	<20100805190653.GA2942@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, "Ted Ts'o" <tytso@mit.edu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 05 21:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh5xO-0006FU-Cl
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 21:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994Ab0HETSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 15:18:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60037 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0HETSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 15:18:16 -0400
Received: by iwn33 with SMTP id 33so400732iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=4c9yIByY/rXcf557cfSCYkog6Lm24jofPLBOgA6soAk=;
        b=Q0/1DtdBtCtpGZUUn9NMLydZARD/AcT58anD2Vwl/1rqCrWlnCSwnvW9pSB7UUpv43
         mDrERBLMg4W+RttODK9EvTyzon0rnOl5rB+HJyZJUW3fbKhSXSCqbDeGa/t8H1t43VVR
         u3u11GEz/CR1M4mpiHIc8vKigFdCPck5s4mt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Alx/fiZOKvUzoZir9BPL7zN3joYGdcSEQ7Ai4TXf7A175nRMgtJHzTGIFyRdvN7gdb
         ZE3od1Eqd5ILZ7TKxRsSv+Oc1I5B5445pi55AnoApIu8UsG7FxAg84gxoIRTPhvhTAIY
         d4ya2OKJLKglBDeVsjULquC7ZBYZZEbKG1024=
Received: by 10.231.60.5 with SMTP id n5mr12350907ibh.162.1281035895856; Thu, 
	05 Aug 2010 12:18:15 -0700 (PDT)
Received: by 10.231.155.74 with HTTP; Thu, 5 Aug 2010 12:18:15 -0700 (PDT)
In-Reply-To: <20100805190653.GA2942@sigill>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152705>

On Thu, Aug 5, 2010 at 3:06 PM, Jeff King <peff@peff.net> wrote:
> I agree it's a pretty generic name. I was trying to make this as generic
> as possible, at least within the domain of commits, so it could be a
> faster replacement for calls to is_descendant_of. Maybe commit_contains?

I'm going to side-track this slightly. I wonder why branch and tag
have --contains, but it is not more generically available via
rev-list?  I needed it the other day and spent 5 minutes looking at
what it would take before I ended up just calling merge-base in a loop
for the commits I wanted to check.

j.
