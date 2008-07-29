From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 02:09:18 +0200
Message-ID: <bd6139dc0807281709u43218e97p8ba239f3e520e10@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <20080728192651.GA26677@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:10:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcnH-0003cv-My
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 02:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbYG2AJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 20:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYG2AJT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 20:09:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:56462 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbYG2AJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 20:09:18 -0400
Received: by wf-out-1314.google.com with SMTP id 27so6060282wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J2eF92qTHvgYpYFPBzaViA6F8+me+Qr9xYH/GoGya/0=;
        b=fGXKreHL9r/510Q3E2mS61EplOGTElRdGMmPUC2H6fTMkvVbeUGi4qZK2Nu+6Za5aV
         +Ot3B2su5Aqw2m5kjJ+CX9rCmP4WipWqif+rDZcOAdHqjPaC/rWB3GHOu+RFOyaWxqLM
         4qNS0xc9dUnHoeUrEN3s1DgNsB1InIsPWvois=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=i8JTQjf/f3QFh8BcZkbBBhoj3iK7bJ7FUryptpdNr1DfaguCJBdbZnfhJmutYVjRBS
         Sj/k1qC/QUEREJ6eW/f8dWrM48Pxku8DDPSTf0m2tAoFg3yi4TXz10tJkcz7n3qOxkCX
         2TKwZBPwY0p7ol/Eos+CZJKnz3TB625w4Q/C8=
Received: by 10.142.84.5 with SMTP id h5mr1806576wfb.339.1217290158307;
        Mon, 28 Jul 2008 17:09:18 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 17:09:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90533>

On Tue, Jul 29, 2008 at 01:27, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> To me, this suggests that they were too married to 'production' being the
> "dominant" branch.

<snip>

> If the result should become the state of 'x', too, I would then just
> 'git push origin y:x'.

But this means that everybody doing a 'git pull' on that repo will get
complaints when pulling, right? Should they just send out a message to
all their users that they'll need to rebase all their changes now?
(Not being sarcastic, am trying to work out what the recommended
workflow is here.)

-- 
Cheers,

Sverre Rabbelier
