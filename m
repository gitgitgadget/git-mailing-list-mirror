From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 23:39:56 +0100
Message-ID: <bd6139dc0901231439x1e20f06bka90a228a883681ff@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
	 <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com>
	 <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
	 <20090123223205.GA11491@coredump.intra.peff.net>
	 <bd6139dc0901231434n6d6af5a6ma8bb12a634d5b3ba@mail.gmail.com>
	 <20090123223740.GA11527@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQUiK-0008Vn-NH
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 23:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbZAWWj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756569AbZAWWj6
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 17:39:58 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:58630 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbZAWWj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 17:39:58 -0500
Received: by gxk14 with SMTP id 14so4506930gxk.13
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=wCyCQDUcZeoKh9arigPviS84FOXEn9LqCefYCZ+/MNk=;
        b=OkEp7ytYWwAFKrL16INWOYgrb/mtQquvUg76vog12incVggJOiY0ETSQ+BtR1JELfF
         kERYLC+FnNC8OpEcZYWOK8rZPI8cL0wotp9Iu5wT7XWl3aFiXIFUWlYLMhWRiWOVbZR7
         HqoAfZYkpOtke9/vVZy//Kv1LxYAPuwvji9WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Y7w6PsEljd4P0qqGXcNcqICwGQayJGVcrMsQI4NhpqqahT7h6IDML5OqEPGa4hiij3
         /X2jupAvjmpS1Lt9uPtvavaDmIP7wRLWGIkANywZZadBbtontWY+AXqdh2VFQ4isLY3J
         yKrnRPFQWUnJKaGfJ5iwS6z3/9DFa6emI5YsU=
Received: by 10.151.46.3 with SMTP id y3mr1194192ybj.195.1232750396788; Fri, 
	23 Jan 2009 14:39:56 -0800 (PST)
In-Reply-To: <20090123223740.GA11527@coredump.intra.peff.net>
X-Google-Sender-Auth: 203ab3dc2ce00019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106927>

On Fri, Jan 23, 2009 at 23:37, Jeff King <peff@peff.net> wrote:
> No, I don't mind success on cloning an empty repository. But I thought
> the issue at hand was that for some instances, we would report that we
> successfully created an empty repository, when in fact what happened was
> that we failed to clone a non-empty repository. And that that was
> fixable, but it was a problem with our code interfaces (which should be
> fixable) and not some fundamental limitation.

Ah, mhh, if that is the case then I'm afraid that's beyond me (at
least for now), someone else would have to do said refactoring first
:(.

> Or am I misunderstanding the situation?

I think you summarized it pretty well, if that is indeed what Junio meant.

-- 
Cheers,

Sverre Rabbelier
