From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 12:08:39 -0700 (PDT)
Message-ID: <m33a7noc3u.fsf@localhost.localdomain>
References: <32541b130908191107v2ab6752awb43f521f805b5f1a@mail.gmail.com>
	<4a8c4425@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Ingo Bruecki <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:08:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdqWb-0000E4-K6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbZHSTIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZHSTIk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:08:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:25093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbZHSTIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:08:39 -0400
Received: by fg-out-1718.google.com with SMTP id e12so850816fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0w55Ym2CeTjmIxo/IVsn0H0Bsk6/3Mm18u6Vkh0PnN0=;
        b=bVcHjgQLl2D0KsTx/Kf4h01+BrKibrXpz6M+qY438u+OpLg5R4GL0y+ld8qd0evupV
         w5JUVlFHLxwIoj43/Iw2Syx4WqlWsx7nhjq1AquYI2HVZAwxOxH8HNb/n09934yc5IWL
         2J4b7DER5RZJAO2fmkzOFcMXtOT+GNl4Oosjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KgmnKVaa+S3f+85kCYYN71CrxJG9PRx+ffLTyotdEg0tDDL+orsKX6H2MFtFe7f7zz
         qImPFt2VIhice2gj3nP0tZViVnYbjkqrccMYhvFm8IinbEeGHJ9SBk18Mj81fB9O0q5s
         RaWoyDoHEAT6e1ZLpruNrh8CzFDD2CxdkxKGA=
Received: by 10.86.187.38 with SMTP id k38mr4435262fgf.5.1250708920478;
        Wed, 19 Aug 2009 12:08:40 -0700 (PDT)
Received: from localhost.localdomain (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id e20sm8948738fga.22.2009.08.19.12.08.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 12:08:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7JJ8dhn014838;
	Wed, 19 Aug 2009 21:08:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7JJ8cr6014835;
	Wed, 19 Aug 2009 21:08:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4a8c4425@wupperonline.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126574>

ib@wupperonline.de (Ingo Brueckl) writes:

> Avery Pennarun <apenwarr@gmail.com> writes:
> 
> > You seem to have forgotten the "git commit" step before switching back
> > to master.
> 
> No, I passed over the commit in my example. I know that after the commit the
> things are as they ought to be, but what if I can't do a commit because I am
> in the middle of coding and have to have a break?

Then you use git-stash.  It was invented for that.
 
> > You have a modified file in your repository; what did you *want* to happen
> > when you switched branches?
> 
> I want an unchanged file in master if I switch there (because I worked in a
> different branch) and a changed version in the test branch.
> 
> Why is the *master* different depending on whether my work in test in still
> going on or committed?!

Branches are about commits.  State of a working directory doesn't
belong to a branch (in Git).  Learning concepts behind Git would help
you in understanding it (Git is very consistent), which in turn would
help in using it.

What about untracked files?  Do you want to lose them when you switch
branches?

> 
> Actually, I cannot image how branches are practicable if I always have to
> have in mind possibly still uncommitted work. Shouldn't it be git's work
> to ensure that master will remain it was when branching?
> 
> Without git I'd make a copy for testing new features. With git, it seems that
> I have to do the same (a clone). This is what I don't understand.

You finish old work (or stash it away), _then_ you begin new work.

> 
> > (Many people find the current behaviour very convenient.)

Take the following example.  You started coding some feature on
'master' branch, then you realized that this feature is more
complicated than you thought at first, so it should be developed in
separate topic branch.  You do "git checkout -b featureA", and voila
you are now coding on feature branch 'featureA'.

> > You might also want to look at the "git stash" command.
> 
> Yes, but isn't it annoying to leave the test branch always either with stash
> or commit in order to have an unchanged master?!

No, it isn't.

-- 
Jakub Narebski

Git User's Survey 2009: http://tinyurl.com/GitSurvey2009
