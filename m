From: John Tapsell <johnflux@gmail.com>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 28 Aug 2009 09:05:54 +0100
Message-ID: <43d8ce650908280105x70327db0p7fce1bd6575297d2@mail.gmail.com>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, teamgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Aug 28 10:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgwTM-0006rP-VA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbZH1IF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZH1IFz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:05:55 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:63308 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZH1IFx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:05:53 -0400
Received: by gxk1 with SMTP id 1so2184941gxk.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=cfxOtqUBzMuntY4rD/P4x5Igc9Ol/6CSUpNjh6+W5FE=;
        b=ZXgQLAhwk6+gliJSXP2VJSCrPoXkeibjqBY65QYN/tV+m0zjfeZYx9D2ndlt0n1nyn
         bfwOXAK9vkcJCNR4DVVpyZ4KrYOuv8HY9G4TbOotrkn8wDCJZKtCC5fnCFTaLIWio0sq
         2WKXNGSxakEGrHVe411GdYX2L6COEMaj9XBFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=lZroT8RCTwBbY7+HviawIFwgg5j5tDl8PqCDjoVfndk1EuHUA2kzDQKeygMCwLYUPF
         xNRvk3A1+PSkjYEqjRXxwQk4Pu6XeZ55QVoqZ8VTNBMFSLoth8qsVizB+tGtW+ZWkP4d
         SV4Eg5BCeOe4wVTL/nztmmceqRqw3aRj0xYY0=
Received: by 10.150.130.33 with SMTP id c33mr1537452ybd.298.1251446754252; 
	Fri, 28 Aug 2009 01:05:54 -0700 (PDT)
In-Reply-To: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127275>

2009/8/28 Abhijit Bhopatkar <bain@devslashzero.com>:
> Hi,
>
> After a long pause in the development, i am back to drawing boards for teamGit.
>
> Ever since i adopted git as my preferred version control system for my
> teams, I had this tough time keeping up with every one. Of course this
> is a GoodThing(TM) since this means pace of development is rather
> good. But it has its usual problems of forcing everyone to religiously
> publish _AND_ keep rebasing on main branch every so often. Also my
> major problem is that we discover conflicts only _after_ a developer
> tries to rebase his work, typically (by design) after he has fully
> coded and tested a feature.

What sort of time frame are you talking about?  How long are your
sprints, or however you partition your work.

I can't help but feel the problem should be solved elsewhere.  Do you
have daily scrums?  Everyone should know, roughly, what everyone is
doing.  If you are using 2-3 week sprints (or however you partition
the time) and everyone is roughly aware of what everyone else around
them is doing, there shouldn't really be so much of a problem.

> The current way to get around this is shouting aloud before you start
> working on a new feature/file/section.

How do you allocate the features in the first place?  At the start of
a sprint?  If so, it should be the person in charge of that that
should see if there are going to be conflicts.  If you don't have
sprints, then how do you divide up tasks?

John
