From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 02:19:04 -0500
Message-ID: <5358bae8ab550_1f7b143d31037@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Lang <david@lang.hm>, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 09:29:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdE6D-00076f-QV
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 09:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbaDXH3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 03:29:33 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:34028 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaDXH3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 03:29:32 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so2203397oag.22
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=JufGVL9B55TIzkRJE3G/YRyTJyk4oPm9JrExqTehtM4=;
        b=YQWEOsUkKQzowxx7bqvZY0FsL1r3rfloIc7ZiiWzHxoyU9Jxp4T4STZaqeqM0YBYsB
         1QZkRJ+2woAblIPSDkpZyZQHtBa12VfEYtgvZdThjzNMaiidgjCBkClGzjht+JHzbbY/
         Dkn7TaN1v7ptLD508g2w2iZjXREmMiUNWWgXgiNHxrP5HIdTYSGks/Jg/9CmKVyF+SBo
         9+kEgTwlqj41MEJN/uc0UC3YncFU1i82jtSXW0dNV/WznnRtN0gjeZ6olCFwkwsRaCwr
         z3yAUBIyUoICrtpuAUXszNHonqWqyrdO3BTnCgCewmNA1Wq01pvrdjXMhJyWSwsKGvrW
         ctJA==
X-Received: by 10.182.200.131 with SMTP id js3mr248550obc.0.1398324571796;
        Thu, 24 Apr 2014 00:29:31 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm14324923oeb.13.2014.04.24.00.29.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 00:29:30 -0700 (PDT)
In-Reply-To: <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246943>

James Denholm wrote:
> Felipe Contreras wrote:
> >This is a false dichotomy; there aren't just two kinds
> > of Git users.
> >
> > There is such a category of Git users who are not
> > fresh-out-of-the-boat, yet not power users either.
> 
> Oh, I didn't mean to suggest a dichotomy of any kind. However these are the
> two groups (I suggest) are the most immediately relevant - one calls for
> change, and the other would be negatively impacted.

Nobody would be negatively impacted. Who would be impacted negatively by having
default aliases?

> > Unless the aliases are already there by default.
> 
> Others, with knowledge far beyond mine, have pointed out the problems
> with this.

And I have showed they are not problems.

> I'd suggest the argument most relevant to my own statements is how it impacts
> the learning proccess, and makes it more likely that users will learn aliases
> _as_ commands, which of course is incorrect and potentially harmful.

That is an assumption. Why would a user think 'co' is a command?

> > And if default aliases were such a bad idea, why do most (all?) version
> > control systems out there have them?
> 
> I'm so tempted just to sass and say that it's because they aren't git...
> 
> But on a more serious note, a feature (any feature) being in one vcs doesn't
> mean, by default, that it's right for git.

How is Git different from any other version control systems?

Commands are commands.

> The status quo may be a mistake on the part of it's followers.

Yes, it might, but it's not.

> (And, historically, has been many times - for an transculturally-acceptable
> example, consider the rejection of Galileo's astronomical research by the
> Vatican of the time.)

Yes, I'm perfecly aware that everybody _can_ be wrong, that doesn't mean they
_are_.

> Just because Mercurial et. all does something doesn't mean git needs to, or
> even should. It needs objective consideration, not to just be ushered through
> on the basis of tradition.

Again, this is a red herring. Nobody argued that Git should do this because
others are doing it.

You failed to answer the question, so I'm asking it again:

If default aliases were such a bad idea, why do most (all?) version control
systems out there have them?

Your answer seems to be along the lines of: they made a mistake and they are
all wrong. Is it?

But, surely if it's a mistake on their part you should be able to find people
affected by this horrible error. This would validate the arguments that others
have put forward; if we do X we will have problem Y. Well, other projects have
done X, do they have problem Y?

-- 
Felipe Contreras
