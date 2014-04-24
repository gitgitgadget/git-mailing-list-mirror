From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Wed, 23 Apr 2014 22:35:55 -0500
Message-ID: <5358869b2937_59ed83d308fe@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <5356e62feb9f3_6cbadd72f0f1@nysa.notmuch>
 <87y4yxc89r.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 05:46:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdAcE-0005Il-L7
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 05:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaDXDqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 23:46:22 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:38928 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaDXDqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 23:46:21 -0400
Received: by mail-oa0-f54.google.com with SMTP id i7so2031121oag.41
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=imB/md5Stu16AQfQqSElsgH31ByJnjS+Jwoa4iSsmwM=;
        b=nX5OlXea6xRtouO0TJW1b0442zrLT77g0Ljvvh1+57pBdRUbHJkVWBSt7iomjuNluG
         jprEzU7P6Vpy0PY4tYHhsOXgVdyUj9H4O+6zt3dUj9oTskfnQqruasGvE6CzH3Bp/nsk
         LJI1HolQFL+fXejCdZLjrSraqYdQVH9t25oc0kpPeIZnfWsTn6eA/UNfb7xDs+J1JjeO
         ZJisS2I6yBAWOTLIDJB3sbQrbzQfB17wtI+KBkjsXwH/RMTAs6nv39S1QBAgeei1vStZ
         wkE7fvwyVExm/7HU1ZoOZabmg1oz6SIPcwJFJUPOk6schsT5IWdt5mL95lQZbLsnsL2A
         P+fg==
X-Received: by 10.182.104.71 with SMTP id gc7mr2192563obb.34.1398311181463;
        Wed, 23 Apr 2014 20:46:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm5976272obb.11.2014.04.23.20.46.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 20:46:20 -0700 (PDT)
In-Reply-To: <87y4yxc89r.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246930>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Theodore Ts'o wrote:
> >
> >> This is especially true for commands which might not be used as often
> >> -- e.g., "rebase", and for commands where the meaning of "git commit"
> >> without any argument is qualitatively different from what "ci" (for
> >> checkin) means in most other source management systems.
> >
> > ci means commit in Mercurial.
> 
> Does it mean "commit the staging area"?

It means "hg commit".

> > It would help when the user starts to think "Geez, I seem to be typing
> > `git checkout` an awful lot, I wonder if there's a shortcut", which if
> > the .gitconfigs out there are any indication, it happens all the time.
> 
> Actually, it happens very rarely if you are talking about _real_
> gitconfigs deployed by projects as compared to _sample_ gitconfigs
> demonstrating Git features for _personal_ rather than project-wide use.

There's no such thing as gitconfigs deployed by projects, and if there were
they would be irrelevant.

We are talking about *people* using Git's command line interface, and people
have *personal* configs, that's it.

And it's only those configs we have access to, and the only sources of
information we have to make a guess if users ask the question "Geez, I seem to
be typing `git checkout` an awful lot, I wonder if there's a shortcut".

> >> And for a command like "rebase" where the user can very easily shoot
> >> themselves in the foot to begin with, I'd actually suggest that it's
> >> a _good_ thing that they have to type it out in full.
> >
> > And now you contradict yourself; you actually want to make life harder
> > for new users, on purpose.
> 
> Life's hardness is not proportional to the number of typed characters

It is. Why do you think people set aliases? To make their life harder?

Anyway, if you disagree change one of your frequently used passwords to a
chapter of The Lord of the Rings for a day. Let's see if you still think that.

-- 
Felipe Contreras
