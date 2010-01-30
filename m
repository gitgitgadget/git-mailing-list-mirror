From: Mark Lodato <lodatom@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:59:49 -0500
Message-ID: <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> 
	<7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> 
	<alpine.LFD.2.00.1001292013150.1681@xanadu.home> <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com> 
	<alpine.LFD.2.00.1001292208470.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 05:00:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb4VV-0008WD-Uv
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 05:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab0A3EAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 23:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755849Ab0A3EAM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 23:00:12 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:50169 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab0A3EAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 23:00:10 -0500
Received: by pzk2 with SMTP id 2so2236958pzk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 20:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8UDFeQzAIb4Ppf3g9WMBfJo8ndmq6i+ZfBgW+bN7rF0=;
        b=W++zEOdj809t1ecUg5YSju7O+KZvw13qdddv0kHVspQfRmzehmU7IpFxY2xlwCu1ck
         4xD6GBVbMW8KOvb8RRKE1TLvQtO4pi3hidzcFqQdQTrzyxsibA44i2h4XCvUeqGycd5R
         R0sPiOQGt7RLLIdqa1EttsLg5+KjUwfaSe3Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PVTAH5h660eTxRAOP499x8czZk/2T8Mz32+xQEjO+zIHxVCfoy9O0LuB1jUQGy4KgW
         gb8VVEHoEhsRWn5N+TqSQsxgaksZMaClzENlSlIFNGuXZz3fasCfx2wfulgNXpHAJZum
         HfSI6FwV6HdDUufOLX4Rm+nW1WJ4TldKMAkDM=
Received: by 10.114.28.19 with SMTP id b19mr1149611wab.71.1264824009072; Fri, 
	29 Jan 2010 20:00:09 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001292208470.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138437>

On Fri, Jan 29, 2010 at 10:11 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Fri, 29 Jan 2010, Mark Lodato wrote:
>> On Fri, Jan 29, 2010 at 8:22 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> > On Fri, 29 Jan 2010, Mark Lodato wrote:
>> >
>> >> Still, I find it slightly confusing and unfriendly. =C2=A0How abo=
ut the following?
>> >
>> >> Checking out commit 'master^0'.
>> >>
>> >> Since this is not a local branch head, any commits you make will =
be lost
>> >> when you check out another branch or commit. =C2=A0(In git termin=
ology, HEAD
>> >> is detached.) =C2=A0If you just wish to look at files without com=
mitting,
>> >> this is fine. =C2=A0If you wish to make commits and retain them, =
you may
>> >> create a new branch by running:
>> >>
>> >> =C2=A0 git checkout -b <new_branch_name>
>> >
>> > This gives the impression that any commit you make on a detached H=
EAD
>> > are going to be lost, unless you create a new branch first.
>>
>> What about "...you may want to create..."? =C2=A0This does not imply=
 that
>> creating a new branch now is the *only* way, just the most likely. =C2=
=A0If
>> a user knows another way, that user probably does not need this
>> warning in the first place.
>
> Still, you don't know what way the unsuspected user will take to get
> there.

Sorry, I don't understand.  What do you mean by "take to get there"?
Are you referring to how the user arrived in this detached HEAD state,
or what the user wishes to do next?  Either way, I still am not sure
why this wording is no good.  Could please elaborate?

> Do you still have a problem with the latest version of the text from
> Junio? =C2=A0Looks like you based your modification on an earlier ver=
sion.

Yes, I do.  I thought his earlier version was more clear.  Particularly=
:

  Note: 'master^0' isn't a local branch head;

This isn't very friendly.  It sounds like an admonition.  Rather, I
suggest that the first sentence be similar to, but distinct from,
"Switched to branch foo," to inform the user that they did something
different, which may or may not be intentional.

  You are in 'detached HEAD' state. You can look around, make experimen=
tal
  changes and commit them, and you can discard any commits you make in =
this
  state without impacting any branches by checking out another branch.

=46irst, we shouldn't start off with the term "detached HEAD".  I used =
a
parenthetical comment to mention it, in case the user wants to look it
up or refer to this state.  Otherwise, the term conveys no meaning,
unless one understand enough about git to not need this advice.

Second, this advice should be a warning that commits may be lost
unless one knows what one is doing.  Saying "you can discard commits"
makes it sound like a feature!  Sure, that may be so for advanced
users, but for beginners (for whom this advice is intended), this is a
common trap.  I tried to word the advice so that the users will know
that they should not commit without first creating a branch (or
knowing what they're doing), but that if they don't commit, there's no
problem.  The wording quoted above does not convey this meaning to me.

  If you want to create a new branch to retain commits you create, you =
may
  do so (now or later) by using -b with the checkout command again. Exa=
mple:

    git checkout -b <new_branch_name>

I basically retained this, with rewording.


This discussion brings up another good point: The main worry about a
detached head is losing commits.  Back in 2008, it was suggested to
have a warning when committing on a detached HEAD:

http://kerneltrap.org/mailarchive/git/2008/9/2/3169744

This was before the advice system, so folks complained about it
getting in the way, and it was never implemented.  Since we now have a
way to easily turn off the warning, perhaps we should bring this topic
up again (probably as a separate thread.)
