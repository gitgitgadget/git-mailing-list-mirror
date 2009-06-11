From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: EasyGit Integration
Date: Thu, 11 Jun 2009 02:42:55 +0200
Message-ID: <200906110242.57475.jnareb@gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <m38wjz4odq.fsf@localhost.localdomain> <94a0d4530906101730p22053cbbl347eddd31b347c3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEYNp-0004Zt-5I
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 02:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbZFKAnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 20:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756780AbZFKAnD
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 20:43:03 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:51071 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbZFKAnB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 20:43:01 -0400
Received: by fxm9 with SMTP id 9so1205995fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ki9KsOqlofgKfySxX+qgoicxZ5toK/GdSv1PsR/xcnU=;
        b=oRs5uToRU1hGXZtL1ZUuY9WMecKK714HCJRLGJe1ldMzRax23NQazHGcP92w0353Kw
         LNl3oJcCXWP7hSZUGgbKcLqiWdcjHdKRnjFZ/qnlWnnvZziYezaHkP5+WPMfelBBGrfY
         yEGeYKQDeUx2ElGlNE6HNaq3Qyu50U9L1WTXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jBZqsGpMlxGfcQU3LMKkcAXg2XAyhOklj38M9PCbantP7U3mGeOVQycAjjGqKkNvNn
         reKnAQ7VRm5BOk8fFJLmwQyzd40KeqNCVHj52Zj3y+JjwnMw+EBFjt10wKMbrLcrfJe/
         LoAydw6coAeSLK0S63mQgkH5y3GuMfCY2quDw=
Received: by 10.86.91.3 with SMTP id o3mr1668887fgb.29.1244680983390;
        Wed, 10 Jun 2009 17:43:03 -0700 (PDT)
Received: from ?192.168.1.13? (abwl198.neoplus.adsl.tpnet.pl [83.8.235.198])
        by mx.google.com with ESMTPS id 4sm1070251fgg.8.2009.06.10.17.43.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 17:43:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530906101730p22053cbbl347eddd31b347c3c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121322>

On Thu, 11 June 2009, Felipe Contreras wrote:
> On Thu, Jun 11, 2009 at 3:15 AM, Jakub Narebski<jnareb@gmail.com> wro=
te:
>> Scott Chacon <schacon@gmail.com> writes:
>>> On Wed, Jun 10, 2009 at 4:04 PM, Linus
>>> Torvalds<torvalds@linux-foundation.org> wrote:
>>>>
>>>> IOW, both would be "if you give it a commit, it acts at a commit l=
evel",
>>>> and "if you give it pathnames, it acts on a pathname level".
>>>>
>>>> That is totally obvious, and not in the least confusing. They are =
two
>>>> different things, but at the same time, there is no question about=
 which
>>>> is which.
>>>>
>>>>> In my mind these are 2 completely different commands.
>>>>
>>>> They are two different things, but they both make sense within the
>>>> _context_.
>>>>
>>>> Only earthworms and FOX news have no concept of "in context". So i=
t does
>>>> make sense to say "git checkout filename" (and expect it to check =
out that
>>>> _filename_ - surprise surprise), and also say "git checkout branch=
" (and
>>>> expect it to check out that branch - again, big surprise).
>>>
>>> The problem here is that you're using 'check out' in your descripti=
ons
>>> of the expectations to mean two different things. =C2=A0One means '=
switch
>>> branches' and the other means 'extract content'.
>>
>> In both cases it means getting something out of repository (checking
>> out) and into working area.
>=20
> 'git reset' also gets something out of the repository and into the
> working area, that's not reason enough to put them under the same
> 'checkout' command, is it?

Nope. 'git reset' resets something to the state in repository (to given
commit).  The fact that some combination of options for 'git reset' giv=
es
the same result as some specific combination of options of 'git checkou=
t'
means only that one can arrive at some destination in two different way=
s.

--=20
Jakub Narebski
Poland
