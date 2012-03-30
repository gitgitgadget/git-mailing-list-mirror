From: david@lang.hm
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 15:29:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1203301513480.5814@asgard.lang.hm>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com> <201203301510.q2UFAqn6003864@no.baka.org> <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com> <7vehsam3pn.fsf@alter.siamese.dyndns.org>
 <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-2070111694-1333146552=:5814"
Cc: git@vger.kernel.org
To: Yuval Adam <yuv.adm@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:38:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkSd-0002NF-Ul
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935483Ab2C3WiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:38:17 -0400
Received: from mail.lang.hm ([64.81.33.126]:44136 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933942Ab2C3WiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 18:38:14 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Mar 2012 18:38:14 EDT
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q2UMTCJY030175;
	Fri, 30 Mar 2012 14:29:12 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CA+P+rLeDFu4KgEZPw=k67iMWVVGcZ3q48VZjgXNLXn3NdyQnow@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194418>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-2070111694-1333146552=:5814
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 30 Mar 2012, Yuval Adam wrote:

> On Fri, Mar 30, 2012 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> That's not really "is it complicated with git" question, I would have to
>> say.  Any version control system you would build history starting from one
>> point going _forward_, never inserting past event as you dig back.
>
> That is true.
> It is very clear to us that an SCM is optimized for the prevalent use
> case, which is tracking code (well, mostly code) as it is written.
> Naturally this always starts at some point in time and progresses into
> the future.
>
> However, we perceive git as a very powerful tool, that can fit
> beautifully with the way legislation works today.
> The challenge for us - should we choose to accept it ;) - is to build
> a set of wrapper tools that allow us to use git in such a way, while
> enabling us to build up past history.
>
> Yes, this is not the usual use case, but we're highly motivated on
> making this work.
> We believe this could also be an interesting experience for the git
> community in seeing how the git plumbing can be used for other cases,
> even if they veer off on some weird tangent.
>
> We'll definitely be back with more questions and updates, as we progress.
> Thanks, everyone, for your responses and feedback!

you may want to take a hint from how the linux repository works.

When git was created, the as-of-then current version was commited as the 
base and development went on from there.

Later on the linux historical repository was created (and re-created over 
time as other versions were found).

The git graft command can be used to join the 'current' repository to the 
'historical' repository so that they can be treated as one.

I strongly suspect that something along these lines is what you are 
needing.

David Lang
--680960-2070111694-1333146552=:5814--
