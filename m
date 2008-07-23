From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 23:49:41 +0200
Message-ID: <200807232349.42244.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <20080723143810.GR2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:51:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmEe-0007R5-JS
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbYGWVtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbYGWVtv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:49:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:51816 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100AbYGWVts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:49:48 -0400
Received: by ug-out-1314.google.com with SMTP id h2so547171ugf.16
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bZjYa3Gx46ClGwNnLIbUy3+4TxZqyX8gdcCv803hRIQ=;
        b=gGUg+9Z/NZwAeomUfFBhGEDQDuPGs5JmAX+Ja4mOYficyUHZTLSOV2DEjoK6MJ6f5u
         4V7RnoIJeMdKlCry7XrdDSP7p5PqFvOHTAwlcm134ZNO6iyauorluyjW7tE6aHPNOfAb
         URfVGYRdb3t4nAvBXSI4llRKACqnfIxG12WSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=faRE3wXo7BMzMhTTw06+K/bBhYJvECMCkshD7rYpYeTOnHxwe54Zr7vZ0WR3jMEzSx
         Sxv1LXqRtttBL7w6/rQUSMSFLu9X1z/rWOuJUoUvW220RLS3bCFw4O54pocLwW56KDa3
         tcOa4mUNJgIkC5odV4PwJ0/UeA3zMtaeXAEzk=
Received: by 10.66.241.13 with SMTP id o13mr27647ugh.78.1216849785907;
        Wed, 23 Jul 2008 14:49:45 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id 34sm2497077ugh.76.2008.07.23.14.49.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 14:49:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080723143810.GR2925@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89785>

On Wed, 23 Jul 2008, Dmitry Potapov wrote:
> On Wed, Jul 23, 2008 at 03:25:03AM +0200, Jakub Narebski wrote:
> >
> >    02. What is your preferred non-programming language?
> >   (or) What is the language you want computer communicate with you?
> 
> IMHO, the later wording of the question is much better.

First just satisfies demographic curiosity.  Second is more question
about internationalization (i18n).

I'm not sure however if it is worth it, and not just simply remove
this question from the survey.

> >    05. How did you hear about Git?
> >        (single choice?, in 2007 it was free-form)
> >      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
> >        news site or magazine, blog entry, some project uses it,
> >        presentation or seminar (real life, not on-line), SCM research,
> >        IRC, mailing list, other Internet, other off-line, other(*)
> 
> I think "friend" would be a reasonable choice here too.

Or: "word of mouth (off-line)".  Good catch, thanks.

> >    09. When did you start using git? From which version?
> >      - pre 1.0, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
> >      + might be important when checking "what did you find hardest" etc.
> >      + perhaps we should ask in addition to this question, or in place
> >        of this question (replacing it) what git version one uses; it
> >        should be multiple choice, and allow 'master', 'next', 'pu',
> >        'dirty (with own modifications)' versions in addition.
> 
> I think: "What version do you use now?" and "How long do you use git?"
> may be more useful here. From which version may give rather confusing
> results because someone may "start" with 1.4 a week ago just because
> that is the version included in Debian Etch and after realizing that
> version 1.4 has serious usability issues upgraded git to 1.5. Besides,
> 1.5 is around for a long time now (as most as long as all previous
> versions), so 1.5 can mean either one month of usage or 18 months...

Good idea (provided that for "How long do you use git?" there is an
answer "Don't remember").

Should "What version do you use now?" be multiple choice (using git
on more than one machine / operating system)?  What should be possible
choices for "How long do you use git?"?  Perhaps.

      10. How long do you use git?
          (single choice)
       -  never/few days/few weeks/month/few months/year/few years/
          from beginning/I wrote it(*)
       +  (*) just kidding ;-)

-- 
Jakub Narebski
Poland
