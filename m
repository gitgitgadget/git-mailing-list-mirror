From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 13 Mar 2009 00:30:46 +0530
Message-ID: <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
	 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
	 <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
	 <7veix33f5e.fsf@gitster.siamese.dyndns.org>
	 <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
	 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 12 20:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqAf-0008TS-LZ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbZCLTAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZCLTAu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:00:50 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:37711 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZCLTAs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 15:00:48 -0400
Received: by gxk11 with SMTP id 11so2037035gxk.13
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AwVLZ5qtIU6cXwRUllpnaujrBINSX1+f0pFSCNWng5A=;
        b=WpVcMtBZAy7HD3mxVrBB/rhzvnnP22YqCZZVn0j1oZrD5pHqCf21tXxsdUR+gQkUF1
         Ff/ppv6wpYGWpc8oS3xsuy2rFOLnvNZ6ngw9cJRE/oDJ8i0luli3boN4ATuIu/7y7vc9
         WoSTXZ2a9T8VaUmVh8KahzXkuUM2kHgsOQLlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xUHLbthZYsTSut6Poy90Faa96y67ePcoNeyN6BJqtda0IC01QrAQVSEM36yCcN+l7f
         /UzrPCpNxEtna2A9LGcIVOfaQFNdbNjTfn6fYgCqeRyVYGhLsWo6OFgFjvlxQE+2Wboe
         wk+p2w913Nlzs3G/kwiCDm69MRjzfGRS5vrp4=
Received: by 10.231.20.3 with SMTP id d3mr85449ibb.18.1236884446361; Thu, 12 
	Mar 2009 12:00:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113105>

On Fri, Mar 13, 2009 at 12:23 AM,  <david@lang.hm> wrote:
> On Thu, 12 Mar 2009, saurabh gupta wrote:
>
>> On Thu, Mar 12, 2009 at 11:30 PM, <david@lang.hm> wrote:
>>
>>> On Thu, 12 Mar 2009, saurabh gupta wrote:
>>>
>>>>
>>>> =3D>Merging of two xml files
>>>>
>>>> =3D> existing merge driver (like xdl) is called which marks the
>>>> conflicts points just like a normal text file.
>>>>
>>>> =3D> the conflicted file can be read through a text terminal and
>>>> conflicted lines can be seen.
>>>>
>>>> =3D> suppose the xml file is from the domain of OO document. Then,=
 a
>>>> merge helper for OO xml type file is called which takes input as t=
he
>>>> conflicted file produced by xdl driver.
>>>>
>>>> =3D> The merge helper creates a new file or changes the input file=
 to
>>>> make it a valid xml file so that it can be opened in OpenOffice an=
d
>>>> user can see the markers like "=3D=3D=3D=3D" or "<<<<<" =A0in an a=
ppropriate
>>>> manner and can resolve the file manually.
>>>>
>>>
>>> with XML files it's possible to be symanticly identical, but not
>>> identical
>>> as far as a text merge driver is concerned.
>>>
> <SNIPB>
>>
>> you are right. For xml merging, what I am thinking is to create the
>> algorithm based on the document object model. Inside, any tag, all t=
ags
>> are
>> compared only in terms of content and not in order. But again, this
>> ordering
>> option can be given to the user. If the user wants order to matter, =
then a
>> conflict will be resulted if order mismatches.
>
> right.
>
>> But other issue is regarding the display of conflict markers. Either
>> conflict markers should be put in xml format or like text merger. Th=
is is
>> the main project idea for GSoC 2009.
>
> this may need to be a configurable option, but I suspect that we coul=
d get
> away with always using something in XML format. exactly what the mark=
ers are
> needs to be configurable (the markers for OO will not be the same as =
for SVG
> for example)

yeah.

> building a library of 'this works especially well for this app' marke=
rs is
> something that needs to be started as part of the GSOC project, but p=
ossibly
> only far enough to show a couple of examples and have confidence that=
 the
> tool is configurable enough.
>

I think picking up some formats and then building libraries above that
is needed. In some sense, I talked about the plug-in architecture
also. Can;t it be possible that for different applications (like OO or
SVG), different merge helper plugins are created which can be
integrated with it. Or speaking in  other words, instead of plug-ins
now, libraries for merge helpers for different applications are
created.


--=20
Saurabh Gupta
Senior,
NSIT,New Delhi, India
