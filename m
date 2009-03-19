From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 20 Mar 2009 00:53:15 +0530
Message-ID: <ab9fa62a0903191223s221269ffs765dd7097ace3f2e@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903181645440.16753@asgard.lang.hm>
	 <alpine.DEB.1.00.0903190141300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkNrG-0002xw-RS
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbZCSTXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbZCSTXT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:23:19 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:56218 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbZCSTXS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 15:23:18 -0400
Received: by gxk4 with SMTP id 4so2399961gxk.13
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s6vABGoMv4yctUhRdVLv8xpX3GtDK+bH733lFTjMD+g=;
        b=uLmVU2v6VTqOZbRfd97e5jdIgu9WSz7tsO4s3AtnmXpbUj6Y/rKkFoFdS1XRB9JeJn
         vJ5g7t4U1xGW3a9vM87cwSse09HnE4E5WpbWcfTdO5es+WfOOZchGEQ6onIUp1vW18GA
         eTC6x2EWQUPW4LOiDM2jteTF4wYlhVcPcq6NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZmX8bCnvzEwRjtMVIebVLivQR4yKu0c4qojyYFIzMWSNYw/65gtvuX3WAQ943Py1gP
         gSMDlz2b2p3TDCFu9dlsAEg7QiF1gmNhxfQCh1cPvDe7hk80kpLajGbPQhOf9EKA7BAt
         Nj/sEKbNotIiY1dZEpIst/oVdRhnRTQj4VNVg=
Received: by 10.231.15.130 with SMTP id k2mr918628iba.31.1237490595621; Thu, 
	19 Mar 2009 12:23:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903190141300.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113810>

On Thu, Mar 19, 2009 at 6:13 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 18 Mar 2009, david@lang.hm wrote:
>
>> On Thu, 19 Mar 2009, Johannes Schindelin wrote:
>>
>> > On Fri, 13 Mar 2009, saurabh gupta wrote:
>> >
>> > > On Fri, Mar 13, 2009 at 1:29 AM, =A0<david@lang.hm> wrote:
>> > > > On Fri, 13 Mar 2009, saurabh gupta wrote:
>> > > >
>> > > > it may be just doing an XML merge driver is a summer's worth o=
f
>> > > > work, or it may be that it's not really enough and you should =
try
>> > > > to do another one or two.
>> > > >
>> > > > it also may be that there is a lot of overlap between differen=
t
>> > > > merge drivers, and once you have the XML driver the others bec=
ome
>> > > > fairly trivial to do. (I'm thinking the config file examples I
>> > > > posted earlier in the thread)
>> > >
>> > > with the options given to the user, one can handle the config fi=
les
>> > > also where order doesn't matter and also the whitespaces problem=
 can
>> > > also be handled in the similar way.
>> >
>> > In my humble opinion, we should focus on the data types we want to=
 be
>> > able to support at the end of the summer first.
>> >
>> > For example, if we decide that OOXML is a must (as it is a proper
>> > standard, and many people will benefit from it), we will most like=
ly
>> > end up in having to write a merge _driver_ (to handle those .zip
>> > files), _and_ a merge _helper_, although we can avoid writing our =
own
>> > GUI, as we can create an OOXML that has its own version of conflic=
t
>> > markers.
>>
>> do you mean OOXML (the microsoft format) or ODF (the open office
>> format)?
>
> Oops.
>
> EOVERLOAD
>
>> > If we decide that SVG is something we want to support by the end o=
f
>> > the summer, then we can probably avoid writing a merge _driver_, a=
s
>> > plain text is handled reasonably well in Git. =A0OTOH it could tur=
n out
>> > that there are _real_ conflicts in overlapping tag ids, and it wou=
ld
>> > still be easier to write a merge driver, too.
>> >
>> > IOW the details are not as important as
>> >
>> > - knowing what data types we want to support _at the least_, and w=
hat
>> > =A0 data types we keep for the free skate,
>> >
>> > - a clear picture of the user interface we want to be able to prov=
ide,
>> >
>> > - a timeline (weekly milestones should be fine, I guess) what shou=
ld
>> > =A0 be achieved when, and
>> >
>> > - being flexible in how to support that (IOW if a merge driver app=
ears
>> > =A0 unnecessary first, but necessary later, we should be able to f=
it
>> > =A0 that into both the design and the timeline).
>>
>> it's up to the student, but I suspect that the best approach would b=
e to
>> start with defining a merge driver to handle XML (with a minimum set=
 of
>> capabilities, and additional optional ones), and go from there.
>
> Well, the thing is: if the student decides to have a go at an XML dri=
ver
> first and foremost, then I'll just flatly refuse to mentor that. =A0B=
ecause
> I sincerely believe that this project is best designed from top to bo=
ttom,
> not the other way round.
>
> After all, the project is based on a user's request, not just a
> playthingie for an XML enthusiast (if such a thing exists).

I do agree with you that unless an end user get to see the conflict
result in an appropriate manner, there is no use of having an xml
merger. But, once we decide as what will be the end file type which we
will aim this summer, we can then start working whether its about
making a GUI first, or creating a merge driver first.




> Ciao,
> Dscho
>
>



--=20
Saurabh Gupta
Senior,
NSIT,New Delhi, India
