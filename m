From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Thu, 28 Jan 2016 16:06:34 -0500
Message-ID: <20160128210634.GD9629@LykOS>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
 <20160127073357.GA7066@sigill.intra.peff.net>
 <56A87764.9070101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:06:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtm7-0003ZZ-BO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbcA1VGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 16:06:40 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33515 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbcA1VGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 16:06:37 -0500
Received: by mail-qk0-f175.google.com with SMTP id s5so16630864qkd.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 13:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=VUD8mYv6r+MxYReaRlFBiqVv69TV2FxSkGv7pcNIBxA=;
        b=hT+vw+68h3fe52VAg7pRy3LDJJrZi4TVJ9NWPgpjKuwtR2NVMkPVg9MGS637at79fD
         SUy3/zvp7pWNfAKg6tvKmohuRZMi4y9L7THv4CWqnX+vQrGVTNaFBbSjqlzQ4AuePz1o
         BdZbNeP8ip6U/PQ3Jbhf3Bp6lykXKDXYxDfLEokXbTRPPG8YQZ0DEIxP+5ovw9ifzLBs
         tJ6BNZ5mwbxDIvuFuBWSDktzKTIje8ycPVOOeWXhLyz600Nd/XvevpRAFLuRejohd6Lq
         oh9MjyduVE/vHAVeHtIzeH67TJJSaQIHTb+yMY/V0qHWJI9NWvLceawKDZJnUNtb0IzD
         3L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=VUD8mYv6r+MxYReaRlFBiqVv69TV2FxSkGv7pcNIBxA=;
        b=R/v05AsV0wqUUfz0d5Ft1y8qt+d3OiejxoVq4Mp2CSxO76ZPydVmgitD4dWo+U/H9h
         UCcfG3KonHOfuo3/rbmDQ7PRDLAC2kEmgxcl0yr5O5AOhGi6eYGfhNZDdRHDIyVBxnH9
         IdWBNBw0z/WmjmzQfnVzV+x/RWrHTFJ0RdpmX8vuQDdFmTAPHdxtsksiFz0b3FdO19n1
         I20hdDCrkuQ0M33nKIiIcQso7O/1L83/Blmh9KPSRN+kZUFrXLuaBEuFLBfzBDnCenXJ
         qM4nIfkhhvb+k73uc8wNKxPbyDgPqLjNN4q1D8XgDiO81+NOJCcm+u4z9X1fUgrfawU7
         IIyA==
X-Gm-Message-State: AG10YORCqBJxJYyVzA4p1jhXwOSpJI8vcKi1kErurgkbpiKES0WUaAOEfRlEA9o72SHCNKrc
X-Received: by 10.55.76.134 with SMTP id z128mr6426835qka.90.1454015197080;
        Thu, 28 Jan 2016 13:06:37 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-12.NATPOOL.NYU.EDU. [216.165.95.1])
        by smtp.gmail.com with ESMTPSA id y104sm5579371qgd.33.2016.01.28.13.06.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jan 2016 13:06:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56A87764.9070101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285030>

Hello, sorry for being MIA yesterday among all this movement...

On Wed, Jan 27, 2016 at 08:53:08AM +0100, Michael J Gruber wrote:
> Jeff King venit, vidit, dixit 27.01.2016 08:33:
> > On Wed, Jan 27, 2016 at 08:23:02AM +0100, Michael J Gruber wrote:
> > 
> >>> Tag objects already have a "tag" header, which is part of the signed
> >>> content. If you use "git verify-tag -v", you can check both that the
> >>> signature is valid and that the tag is the one you are expecting.
> >>
> >> Yes, that's what I described in my last paragraph, using the term
> >> (embedded) tag "name" which is technically wrong (it's not the tag
> >> object's name, which would be a sha1) but the natural term for users.
> > 
> > Indeed. I should have read further back in the quoting. :)
> > 
> >>> Git pretty much punts on all of these issues and assumes either a human
> >>> or a smarter tool is looking at the verification output. But I don't
> >>> think it would hurt to build in some features to let git automatically
> >>> check some things, if only to avoid callers duplicating work to
> >>> implement the checks themselves.
> >>
> >> That is really a can of worms for several reasons:
> >> [...]
> >> So, for those who shy away from for-each-ref and such, we may add the
> >> header check to verify-tag, with a big warning about the marginal gain
> >> in security (or the requirements for an actual gain).
> > 
> > Yeah, definitely. My thinking was that `verify-tag` could learn a series
> > of optional consistency checks, enabled by command line options, and
> > verifying programs (or humans) could turn them on to avoid having to
> > replicate them manually. So something like:
> > 
> >   git verify-tag \
> >     --verify-tagger-matches-key \
> >     --verify-tag-matches-ref \ # or --verify-tag-matches=v2.0.0
> >     v2.0.0
> > 
> > or to implement more specific policy, maybe an option to check for a
> > _specific_ tagger, either by email (as provided by gpg) or even key-id.
> > 
> > Those are all things that are not _too_ hard to do if you're willing to
> > parse gpg or git output, but we could make life easier for our callers.
> > And hopefully by asking for specific, concrete checks, it doesn't
> > introduce a false sense of security. I.e., we're not making a foolproof
> > tool; we're making building blocks that one could use for a more
> > foolproof tool.
> 
> OK, let's make a tool that helps fooling as well as proofing :)
> 
> I'll look into the tag header check. Maybe "--check-tagname"? "check"
> seems to imply less than "verify".

This seems like exactly what I was thinking of. What I believe would be
helpful is to provide upstream tools the means to automatically verify tags
(--check-tagname could return non-0 if the tagname doesn't match), could
this possibly be the default behavior (--no-check-tagname instead)?
What worries me is something like this experiment with pip: 

(git-tag2) santiago@LykOS:~$ pip install -e git+https://github.com/santiagotorres/django/@1.8.3#egg=django
Obtaining django from

git+https://github.com/santiagotorres/django/@1.8.3#egg=django
  Cloning https://github.com/santiagotorres/django/ (to 1.8.3) to
  ./.virtualenvs/git-tag2/src/django
  Installing collected packages: django
    Running setup.py develop for django
Successfully installed django
(git-tag2) santiago@LykOS:~$ django-admin.py --version
1.4.10

I only had to swap the tag refs and push for this simulation. Needless
to say, this deprectated django version (1.4.10) is vulnerable to a wide
range known exploits that include session hijacking, DoS, "MySQL
typecasting" and XSS.  And the person who served this tampered tag could
exploit the webserver right away (knows who got this vulnerable
package).

Of course, this could also trick a CI system and have people package the
wrong version of django.

I agree that nothing beats manual inspection of a paranoid developer,
but these tools are widely used today and could avoid these edge cases.

> 
> As for the gpg related stuff: We provide the full diagnostic output from
> gpg on request. But I think a mismatch between the signing key's uid and
> the taggers' name/email is more common than not, and on the other hand a
> signature by a key identified by its uid is meaningless unless you keep
> your keyring tidy... We could punt on that and let users identify the
> key by any means that gpg allows, of course, and check that the
> signature comes from whatever "gpg --list-key <userspecified>" gives as
> long as it's unique.
> 
> But maybe I'm biased by my zoo of uids/emails addresses/full name
> spellings... and general paranoia regarding the term "verify" ;)

Yeah, I believe the gpg related stuff might be a little out of scope. I
think, for the sake of this RFC, that we could assume that tools/people
have acess to the right key and could perform verification. As it was
already pointed out, key distribution and a project-specific gpg
keychain could be integrated.

The problem I see is that, even with the right key and a proper
signature, the tag metadata can still be modified and it wouldn't be
detected.

Thanks!
-Santiago.
