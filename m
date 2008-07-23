From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 18:38:10 +0400
Message-ID: <20080723143810.GR2925@dpotapov.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfVK-0002As-EP
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbYGWOiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbYGWOiR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:38:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:53366 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYGWOiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:38:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1144673fgg.17
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NtuYVi7r9yTm/yO+uqFzWqW7c7UhKwALWM/KSMqLEts=;
        b=Qoa70lbIho2W2GRn3qb6T0n4k4jP8ud3Br5KtsEpRPX5U62O8bKOhhic+1o1GVSI0B
         +Ep0LXWOn0JuQHe9Qss6F+9gF7tANBsddhDC3UsRiHC0M8DE/Yj2I8c8+u0u5bBUxSQM
         S+Zy90Xk0H06Q9RosF6BazagJv0/TcGXZquLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tiy7HzGqzsIJXryRLj0z4EP8ouKsrgI9hjpW3tw9Jg2yo1DfNRm+pjL2ALxjI7nwob
         bg6/brdfkemNnNVX8b2dWDuHu8eIUJW2o/0VaQGCNepy/Iewo6m2qntQYGmQa3dMnTpG
         NMzzQyHgipCKMoYlEokBaLa/mFfnYiJn5iz6U=
Received: by 10.86.87.5 with SMTP id k5mr128631fgb.59.1216823894219;
        Wed, 23 Jul 2008 07:38:14 -0700 (PDT)
Received: from localhost ( [85.140.170.138])
        by mx.google.com with ESMTPS id d6sm4822427fga.2.2008.07.23.07.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:38:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89663>

On Wed, Jul 23, 2008 at 03:25:03AM +0200, Jakub Narebski wrote:
>    02. What is your preferred non-programming language?
>   (or) What is the language you want computer communicate with you?

IMHO, the later wording of the question is much better.

>    05. How did you hear about Git?
>        (single choice?, in 2007 it was free-form)
>      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
>        news site or magazine, blog entry, some project uses it,
>        presentation or seminar (real life, not on-line), SCM research,
>        IRC, mailing list, other Internet, other off-line, other(*)

I think "friend" would be a reasonable choice here too.

>    09. When did you start using git? From which version?
>      - pre 1.0, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
>      + might be important when checking "what did you find hardest" etc.
>      + perhaps we should ask in addition to this question, or in place
>        of this question (replacing it) what git version one uses; it
>        should be multiple choice, and allow 'master', 'next', 'pu',
>        'dirty (with own modifications)' versions in addition.

I think: "What version do you use now?" and "How log do you use git?"
may be more useful here. From which version may give rather confusing
results because someone may "start" with 1.4 a week ago just because
that is the version included in Debian Etch and after realizing that
version 1.4 has serious usability issues upgraded git to 1.5. Besides,
1.5 is around for a long time now (as most as long as all previous
versions), so 1.5 can mean either one month of usage or 18 months...


Dmitry
