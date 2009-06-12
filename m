From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Fri, 12 Jun 2009 23:57:44 +0300
Message-ID: <94a0d4530906121357h63723278i7663c25707d3c754@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <m38wjz4odq.fsf@localhost.localdomain>
	 <94a0d4530906101730p22053cbbl347eddd31b347c3c@mail.gmail.com>
	 <200906110242.57475.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFDow-0004z2-1t
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 22:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbZFLU5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbZFLU5o
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 16:57:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:61523 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbZFLU5n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 16:57:43 -0400
Received: by fg-out-1718.google.com with SMTP id 16so747404fgg.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OD0ulB54LqdE6mx8MAWe4zUbQ8HIon1o27aa16TQ3bA=;
        b=en1+qmI9Th9ywBaazQIHuuP/Qsdr3O1fR7GMb25ZGwI6Subt1pBCVHthEi8UD5X6PB
         5p+tO0n1xbc2VN0c7y2hu+fo16qu3cRT7SPBNr4gM85w2m57UmRVd/mkDPXAXH6wy8vg
         Max3bZp8iCpblbzoldxdFhABq5VoV9CYGvKy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eua9eXOFEuhQ3Pxnj0WMwraWWpp92iMhH/5m36wu1RmfAuI9XrfOY8H1iPdppljVLm
         0X4qMVt/LsUjrjru5u6appn06VlLFrreNQPlCtcUsF+3pmzprqHf+t0CDp/0S+1HO4RQ
         kBRvFVE64sAQX2Q4ZhYHfzjedSROR53lCo/8Y=
Received: by 10.86.71.8 with SMTP id t8mr4323718fga.60.1244840264575; Fri, 12 
	Jun 2009 13:57:44 -0700 (PDT)
In-Reply-To: <200906110242.57475.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121449>

On Thu, Jun 11, 2009 at 3:42 AM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> On Thu, 11 June 2009, Felipe Contreras wrote:
>> On Thu, Jun 11, 2009 at 3:15 AM, Jakub Narebski<jnareb@gmail.com> wr=
ote:
>>> Scott Chacon <schacon@gmail.com> writes:
>>>> On Wed, Jun 10, 2009 at 4:04 PM, Linus
>>>> Torvalds<torvalds@linux-foundation.org> wrote:
>>>>>
>>>>> IOW, both would be "if you give it a commit, it acts at a commit =
level",
>>>>> and "if you give it pathnames, it acts on a pathname level".
>>>>>
>>>>> That is totally obvious, and not in the least confusing. They are=
 two
>>>>> different things, but at the same time, there is no question abou=
t which
>>>>> is which.
>>>>>
>>>>>> In my mind these are 2 completely different commands.
>>>>>
>>>>> They are two different things, but they both make sense within th=
e
>>>>> _context_.
>>>>>
>>>>> Only earthworms and FOX news have no concept of "in context". So =
it does
>>>>> make sense to say "git checkout filename" (and expect it to check=
 out that
>>>>> _filename_ - surprise surprise), and also say "git checkout branc=
h" (and
>>>>> expect it to check out that branch - again, big surprise).
>>>>
>>>> The problem here is that you're using 'check out' in your descript=
ions
>>>> of the expectations to mean two different things. =C2=A0One means =
'switch
>>>> branches' and the other means 'extract content'.
>>>
>>> In both cases it means getting something out of repository (checkin=
g
>>> out) and into working area.
>>
>> 'git reset' also gets something out of the repository and into the
>> working area, that's not reason enough to put them under the same
>> 'checkout' command, is it?
>
> Nope. 'git reset' resets something to the state in repository (to giv=
en
> commit). =C2=A0The fact that some combination of options for 'git res=
et' gives
> the same result as some specific combination of options of 'git check=
out'
> means only that one can arrive at some destination in two different w=
ays.

You can describe what 'git reset' does in many ways, but in the
process it's still getting something out of the repository and into
the working directory, does it not? 'git checkout <commitish>' and
'git checkout <commitish> -- <path>' also do that.

Is that relevant? No. What is relevant is the final action the user is
expecting to achieve.

Therefore, the fact that 'git checkout <commitish>' modifies the
working directory is irrelevant, it's still doing an extra step;
update HEAD, and that final action is what is important for this
particular command; it switches to another commitish.

--=20
=46elipe Contreras
