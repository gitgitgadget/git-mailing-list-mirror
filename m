From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] commit -c/-C/--amend: reset timestamp and authorship 
	to committer with --reset-author
Date: Thu, 5 Nov 2009 17:11:18 -0200
Message-ID: <55bacdd30911051111x68539bf5i6ad91bd55dc23feb@mail.gmail.com>
References: <1257304811-26812-1-git-send-email-erick.mattos@gmail.com> 
	<7vpr7ykbh8.fsf@alter.siamese.dyndns.org> <20091105123456.6117@nanako3.lavabit.com> 
	<7vws25a5s2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N67kW-0006uh-LX
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 20:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758367AbZKETLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 14:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757932AbZKETLd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:11:33 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:39039 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904AbZKETLc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 14:11:32 -0500
Received: by ywh40 with SMTP id 40so276812ywh.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wdZOdvrd7kccwnBIzIcBG94bRoquvJ8F40udpx8kktY=;
        b=PkOoX4In+PEHraBKfWyRSHGfoBm0XcYWBhpcOxL0mZQ4NDqj2HnEef2HvnYXN28WlS
         HdoImxwW7/4lNZH54P3YDJ10PYUzUkgNxicbdsjKtCqavByaGYusM1rNWo3yDcKLnxdV
         eRtYvamSqN5p1xoWXw/90hzbaSsXLFhuhziBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iBqVe+mBDndEx1ZH46kruQUowtbok6SX2ugRyYK2NnFLHFJZEi9sbktCUC7ReKQ2Bf
         qG9kgVXp1NA5fLgvBwHyZ0OO+yijruQaAjwZYWYaaD/yLxEiRXKtQNxaNKt+fV+EEjmp
         hOwQV9MJovaKSh5rQmTK/hDPRCuphUu3nVj9g=
Received: by 10.150.114.3 with SMTP id m3mr5928981ybc.56.1257448298085; Thu, 
	05 Nov 2009 11:11:38 -0800 (PST)
In-Reply-To: <7vws25a5s2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132234>

Hey, I do understand you can be very stressed.  It is a huge project.
Very important for an uncountable group of people.  A lot of demands
and argumentation from all over.

I know too that it is human nature to ask other people to agree with
them completely.  Much more when they are in charge.

So, no problem.  It was just a big surprise when I read your email.
You had been so nice to me until that moment...

But let's keep talking about code.  I am not a big fan of human nature =
subjects.

Although I have to be more personal for just a little.  I want to show
you my way of seeing things:

I love defaults!  A command or an option already set for the most
common scenario... It's wonderful.

But I like to have full control of any tool I use.  If I want to do
any bizarre thing nobody has
ever thought about... I think I should be able to.  Without any hacking=
=2E

I can hammer a nail with a wrench.  But I would prefer a hammer for tha=
t.

I think your suggestions which changed the path of this intended
function since the beginning were very good for a default.  So I think
--reset-author did it.  Normally 95% of the time its behavior is what
people will be needing.

But cutting off a remote possibility for no heavy and unbearable
reason imho makes features incomplete.  That is why I had suggested
not cutting off --author functionality when using --reset-author.

I did not try to conceive all possible uses for this combination but I
knew someone could find some.  I have told you a simple case just to
picture some figures.  Nanako showed you a case you agreed.  Thanks
Nanako.

I was not defying your judgment or showing lack of respect to you.  My
text after "---" was very clear about that.  Thank you again Nanako
for showing me the importance of this little text.

About scripting abilities: I don't see a way to compare scripting
"levels".  Scripts are so easy that you just know or not.

Different approaches could be compared.  At start I really did not get
the use of the "t" folder tests.  I thought it was just to show
functionalities.

Nanako in her critics made me understand within her speach the
importance of those tests.  Then you clarified it much more later.  So
I got those informations and made another script trying to test
--reset-author completely.  Separating every bit of data that could
show a malfunctioning.  And taking also the care of letting auditing
more reliable and informational.

So I accepted your rough saying about "teaching" as an explosion of str=
ess.

I have to tell that our work-flow on that time was: you demanded and I
made a change.  The script you added was an example to me under this
work-flow.

I am not a kid and I have a real and busy life but I do think spending
time sharing some changes I use to improve something which I value is
not a lost time.  As you can see by the time I had sent the emails, I
was doing them overtime.

So I would like to make clear that I did and do want to help as much
as I can.  If it is not possible to use my work then just know you and
every free software coder has a big fan in me.  I will be transmitting
good energies to you all in any case.

No hard feelings.  :-)

I hope you can continue doing the wonderful work you have been doing
for a very long future.

Best regards.

2009/11/5 Junio C Hamano <gitster@pobox.com>:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> It may be wise to forbid a combination of options if it
>> encourages mistakes or a wrong workflow, but I don't think
>> using --author and --reset-author with 'git commit --amend'
>> is such a case.
>>
>> Imagine somebody other than you (eg. me) were the maintainer,
>> and a message by Szeder was sent with a good commit log message.
>>
>> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/132029
>>
>> Then you sent a replacement patch that solves the same problem
>> in a more elegant way, but without anything that is usable as the
>> commit log message.
>>
>> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/132041
>>
>> If I were the maintainer, I would find it very convenient if I can
>> work like this:
>>
>> =C2=A0% git am -s 132029 =C2=A0 --- first I apply Szeder's version
>>
>> Then I see your message. Replace the code change but use Szeder's
>> log message.
>>
>> =C2=A0% git reset --hard HEAD^
>> =C2=A0% git am 132041 =C2=A0 --- your version with no usable log mes=
sage
>> =C2=A0% git commit --amend -s -c @{2} --author=3D'Junio C Hamano <..=
=2E>'
>
> Thanks.
>
> So you commit Szeder's and then commit mine (make them independent), =
and
> amend the log message of the latter using the message from the former=
, and
> assign the authorship of the latter to the resulting commit?
>
> That is a much more understandable argument than just claiming "--aut=
hor
> should be usable with --reset-author" without clearly stating why tha=
t
> would help. =C2=A0I think you forgot to add --reset-author to the las=
t command
> line, though.
>
> But I think it is showing that --reset-author is actually suboptimal =
way
> to solve your scenario. =C2=A0In the last command in your sequence, y=
ou don't
> want to add "--reset-author --author=3DX" but want "--reuse-only-mess=
age"
> option.
>
> And I think it makes much more sense than the alternative semantics w=
e
> came up with during this discussion. =C2=A0--mine (or --reset-author)=
 to
> declare that "I am the author" was not what we wanted after all(yes, =
I am
> guilty for suggesting it). =C2=A0What we want is "I am using -C/-c/--=
amend and
> I want to borrow only the message part from the named commit (obvious=
ly
> "amend" names the HEAD commit implicitly). =C2=A0Determine the author=
ship
> information (including author timestamp) as if I didn't use that opti=
on."
>
