From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Sun, 13 Sep 2009 01:44:28 +0400
Message-ID: <20090912214428.GB30385@dpotapov.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> <20090912103156.GA30385@dpotapov.dyndns.org> <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brendan Miller <catphive@catphive.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 23:51:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmaVZ-0002RF-1v
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 23:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbZILVtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbZILVtj
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 17:49:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:8588 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbZILVti (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 17:49:38 -0400
Received: by fg-out-1718.google.com with SMTP id 22so231557fge.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BlEDr1aP1J/9yrH9Yhph7I56PZheru+yORXZYdqdtbY=;
        b=hQj/rxHlq3Jsv6e8pMIHqRUy3aGCZFWUj2ZdNbsNhxaeLihMaQJdO8WjvVo59B8fBC
         WZ5SWbJZQVO+GEZ+IWnSzlQsK36QC64+gqNuDORxAGEv3fQKCySvUWbJbWoz9dIlVppH
         kwt85T3U+VmraLuVe0xEkK6CwVmiu//APiAlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fyFH+jGnv2f6jh2JbobglJ8/SMOSL3GM4G0VidvVXROXdNWSquEa1xtEf0sL/23fs3
         k9JuRYfphwl/AdtVTt5UBLzKehq7OnEf1Bmmy5fU7MUrJD+OQD6NZzuZlmxOAQAEGj5j
         8KLJa6qEn5qNbRXpROp7dl8zSFrVcln8fc3Wc=
Received: by 10.86.227.1 with SMTP id z1mr3511290fgg.56.1252792181313;
        Sat, 12 Sep 2009 14:49:41 -0700 (PDT)
Received: from localhost (ppp91-77-226-194.pppoe.mtu-net.ru [91.77.226.194])
        by mx.google.com with ESMTPS id 4sm2288893fgg.17.2009.09.12.14.49.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 14:49:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128301>

On Sat, Sep 12, 2009 at 09:32:09PM +0300, John Tapsell wrote:
> 2009/9/12 Dmitry Potapov <dpotapov@gmail.com>:
> > On Wed, Sep 09, 2009 at 05:09:31PM -0700, Brendan Miller wrote:
> >> On Wed, Sep 9, 2009 at 2:54 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> >> > Brendan Miller <catphive@catphive.net> writes:
> >> >>
> >> Is the goal of interface design to make
> >> it difficult so I need to learn a lot of things, or easy so I can
> >> remain blissfully ignorant but still do what I want?
> >
> > Neither. You cannot get what unless you have specified what you want,
> > and for that you have to learn how to say that. Having good defaults is
> > very important, but the problem with choosing them is that people have
> > different preferences about them. For instance, you wanted the default
> > prefix for git-archive to be $myproject. For me, a good default would be
> > either $tag_name, or $myproject-$tag_name, or empty (as it is now!). So,
> > what you propose is *never* a good default for me. Moreover, changing
> > any default will cause a lot of pain for other people who use Git now.
> > Besides, writing something like --prefix='' is very ugly. So, the
> > current default makes perfect sense.
> 
> Ah, great logic.  You can't find a default that will suit everyone,
> therefore don't bother.

I did not say "don't bother". On contrary, I said that defaults are very
important, but, in this case, the current default makes far more sense
that what was proposed by Brendan.

> 
> >> Yeah, I've been reading them. I'm saying that the docs are a crutch.
> >> RTFM is the problem not the solution. It makes the user do more work
> >> to avoid fixing usability issues.
> >
> > A usability issue exists when a person knows how to do that, but it is
> > inconvenient or error-prone; or when a learning curve is too steep.
> > But when someone cannot use, let's say, a compiler, because he or she
> > refuses to read to learn the language, it is not a usability issue.
> 
> It's a usability issue when it doesn't just do the right thing in the
> majority of cases and lets you specify what you want it to do in the
> rest of the cases.

It does the right thing for me, and not just in most cases, it does so
in _all_ cases, because it does exactly it is told to do. And it is a
very important characteristics for any VCS, otherwise you can mess up
things easily. What is also good about Git is that it does not require
much keystrokes to do even rather complex stuff. And many defaults and
commands are configurable, so you can adjust it to your workflow. So,
I am not sure what your problem is.


Dmitry
