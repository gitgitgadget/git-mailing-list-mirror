From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 20 Mar 2009 00:47:24 +0530
Message-ID: <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
	 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkNlc-0000cT-7V
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbZCSTRb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 15:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZCSTRa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:17:30 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:48579 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbZCSTR3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 15:17:29 -0400
Received: by gxk4 with SMTP id 4so2393771gxk.13
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yOw/joTlP8v7s/4kgQN9NdFVtyftNieqoHBdmmPRpjY=;
        b=XclhFfQ1nNEizJ2/IqTB+znyavJf98/8uMijncIFbyb/8Iw7G3IjgG1TmHK0wygm9J
         ezP3eZTsRO1Xm38ghjoIM+nV+MliR2R+CQ4BDzFA8eY496bZ6NTDLDLd5t7wuR2/yCeV
         3eSzYLzDJkmsZEaJm8lRa5msgElnFyzzGT8B4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ud0bXplYWlAB9yZcGMJVSeZcZYlGQw9IBHIGPj7SYgG4x+PE73dx5SaqJUWqiBYZmg
         CygdXPjhA/Fs9kN+BVXMWy1xzPX46Lj2/p8qnUSOPfTy0nwBSN6EPUa6tO2fuFNdPs5j
         Ys+zj5Qo3GQIR0gjCxpJGxH9BKXv71jU9hgDA=
Received: by 10.231.14.141 with SMTP id g13mr371384iba.56.1237490245096; Thu, 
	19 Mar 2009 12:17:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113809>

Hi all,

Sorry for replying so late as I was busy in my college's mid-semester e=
xams :-|

On Thu, Mar 19, 2009 at 4:46 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 13 Mar 2009, saurabh gupta wrote:
>
>> On Fri, Mar 13, 2009 at 1:29 AM, =A0<david@lang.hm> wrote:
>> > On Fri, 13 Mar 2009, saurabh gupta wrote:
>> >
>> >> Very well described, David. I agree with you and providing these
>> >> merge options to the user, merge drivers can do the work and mark=
 the
>> >> conflicts according to the option. The work to do is to modify th=
e
>> >> merge driver. I think in this way, even people who have only a
>> >> terminal can also gain from it. They can choose the apt option to=
 see
>> >> the conflict markers in their way. So, the aim is to make merge
>> >> driver configurable and create the merged/conflicted file accordi=
ng
>> >> to the options.
>> >
>> > for the GSOC I suspect that the right thing to do is the define on=
e or
>> > more merge drivers to create, and list what applications are going=
 to
>> > be used for testing these merges.
>> >
>> > you and the mentor can decide what is a reasonable amount of work.
>>
>> I will very glad to hear about this thing from the mentor (Johannes
>> Schindelin, according to wiki). I will try to plan out the things in=
 a
>> proper way to carry out this project if I get a chance to work on th=
is
>> for GSoC 2009.
>
> Well, now that we have been accepted as an organization, we can move
> forward with this idea!

Congrats for getting accepted in GSoC 2009.

> My main concern is that we define early on what should be the user
> interface, preferably with a quick sketch.
>
> The technical details, we can hash them out later, I have no doubt th=
at
> with the help of the complete Git community, we can overcome almost e=
very
> problem handling XML data or some such.
>
>> > it may be just doing an XML merge driver is a summer's worth of wo=
rk,
>> > or it may be that it's not really enough and you should try to do
>> > another one or two.
>> >
>> > it also may be that there is a lot of overlap between different me=
rge
>> > drivers, and once you have the XML driver the others become fairly
>> > trivial to do. (I'm thinking the config file examples I posted ear=
lier
>> > in the thread)
>>
>> with the options given to the user, one can handle the config files
>> also where order doesn't matter and also the whitespaces problem can
>> also be handled in the similar way.
>
> In my humble opinion, we should focus on the data types we want to be
> able to support at the end of the summer first.
>
> For example, if we decide that OOXML is a must (as it is a proper
> standard, and many people will benefit from it), we will most likely =
end
> up in having to write a merge _driver_ (to handle those .zip files), =
_and_
> a merge _helper_, although we can avoid writing our own GUI, as we ca=
n
> create an OOXML that has its own version of conflict markers.

Well, for ODF type document, we can write a merge driver which will
change the xml file in an appropriate way that OO can understand it
and the user can see the merge result/conflict in a comfortable way.
As described by Junio, in this case, a dedicated merge helper is not
needed as OO can parse the markers made by merge-driver and provide
the user to resolve the conflict and register the changes to index.


>
> If we decide that SVG is something we want to support by the end of t=
he
> summer, then we can probably avoid writing a merge _driver_, as plain=
 text
> is handled reasonably well in Git. =A0OTOH it could turn out that the=
re are
> _real_ conflicts in overlapping tag ids, and it would still be easier=
 to
> write a merge driver, too.

>
> IOW the details are not as important as
>
> - knowing what data types we want to support _at the least_, and what=
 data
> =A0types we keep for the free skate,

As of now, how about going for XML files. For this summer, we can go
for XML files and latex files can be handled later.

>
> - a clear picture of the user interface we want to be able to provide=
,

In my opinion, we have following things to do:

=3D> while merging an ODF document, merge-driver will merge the file at
file level. If changes don't overlap, then it returns the result with
a success. For example, if the file is changed only on one side, then
the driver will simply add the new content.

=3D> If conflicts appear, then the merge driver will put the markers in
an appropriate manner which the end-user application (e.g. open
office) can understand and show the user. For example, the XML file of
that ODF document will be modified and OO can show it  to user in its
way. We will have to study about the OO style of version marking.
Another method is to implement the marker style in our own way. For
example, to show any marker, the XML file is modified so that user can
see markers like ">>>> " or "=3D=3D=3D=3D" in openoffice....In this cas=
e, we
will have to just change the xml content in this way.

>
> - a timeline (weekly milestones should be fine, I guess) what should =
be
> =A0achieved when, and

Timeline can be decided once we reach some conclusion and the work
which needs to be done become clear to us.

> - being flexible in how to support that (IOW if a merge driver appear=
s
> =A0unnecessary first, but necessary later, we should be able to fit t=
hat
> =A0into both the design and the timeline).
>
> How does that sound?
>
> Ciao,
> Dscho
>
>



--=20
Saurabh Gupta
Senior,
NSIT,New Delhi, India
