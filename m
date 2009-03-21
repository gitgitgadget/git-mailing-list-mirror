From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Google Summer of Code 2009: GIT
Date: Sat, 21 Mar 2009 23:06:06 +0530
Message-ID: <ab9fa62a0903211036v52c671ebx80fa82d9eb974735@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com>
	 <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903211031l78c7afadg9409a544f2bda7db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	david@lang.hm
X-From: git-owner@vger.kernel.org Sat Mar 21 18:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll58e-0004T6-Ka
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 18:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbZCURgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbZCURgL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 13:36:11 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:56970 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbZCURgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 13:36:09 -0400
Received: by an-out-0708.google.com with SMTP id d14so1143908and.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=4wVdRnE+kUHUflM3OoPjOEZFSsRWde0BkxEQ5WU/6Mw=;
        b=GbzmZ5pOyWlr/9c8Tn3hyWj6MPgH7APurBkHLxlAoxaIB7sYhybmJd3UANSjziK/T+
         2+oZ3u6WBftz0stFwIkwowAQf+xjyQdSnNX9m8R9C5kYqHR87kzfhjSvoSNnQraqYNTt
         35CmZbRPbmZWV36f5FBwpTgYEfGM7XucFpYBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=uO40VgILDaUubbQB9UywsKHIKIghSkUR6oA9E2kCPQqir7en2LtDlvQHtoBVfEX32E
         lz0pPdO/2uomQvd6+CsFxDq8mDSIko09jBtc/uqdNcFekGaWejBiZVW4pdP0xAAbJ/Q3
         N+r8ZwKNFXPAynsS5KuiBL6sE7LHCdfIcc+Qo=
Received: by 10.231.15.205 with SMTP id l13mr1454837iba.7.1237656967112; Sat, 
	21 Mar 2009 10:36:07 -0700 (PDT)
In-Reply-To: <ab9fa62a0903211031l78c7afadg9409a544f2bda7db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114046>

hi,

On Fri, Mar 20, 2009 at 5:12 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 20 Mar 2009, saurabh gupta wrote:
>
>> On Thu, Mar 19, 2009 at 4:46 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > For example, if we decide that OOXML is a must (as it is a proper
>> > standard, and many people will benefit from it), we will most likely
>> > end up in having to write a merge _driver_ (to handle those .zip
>> > files), _and_ a merge _helper_, although we can avoid writing our own
>> > GUI, as we can create an OOXML that has its own version of conflict
>> > markers.
>>
>> Well, for ODF type document, we can write a merge driver which will
>> change the xml file in an appropriate way that OO can understand it and
>> the user can see the merge result/conflict in a comfortable way. As
>> described by Junio, in this case, a dedicated merge helper is not needed
>> as OO can parse the markers made by merge-driver and provide the user to
>> resolve the conflict and register the changes to index.
>
> There is also the idea that OOffice has building blocks in place to help
> resolving merge conflicts.  For a successful application, you will have to
> show that you researched that option, and describe how well/badly it fits
> with the goal of the project.

Exactly, I will have to do some research on it and I will come back to
you as I get over with my college's mid-semester exams (this week
more).

>> > - knowing what data types we want to support _at the least_, and what
>> >   data  types we keep for the free skate,
>>
>> As of now, how about going for XML files. For this summer, we can go for
>> XML files and latex files can be handled later.
>
> If your goal is just XML files (without any more specific goal, like ODF
> or SVG), I am afraid that I think that project is not worth 4500 dollar
> from Google's pocket.  I mean, we are not talking peanuts here.

Well, I didn;t mean to say that we will end up in only having a merge
driver for xml after the summer. We will definitely make the driver in
such a way to use the maximum power of xml manipulation so that the
end application can understand it and user can get the conflict
results in a user friendly manner because the end-user application wil
be able to parse the merged xml file and will present the conflict
markers in the GUI form.


>
>> > - a clear picture of the user interface we want to be able to provide,
>>
>> In my opinion, we have following things to do:
>>
>> => while merging an ODF document, merge-driver will merge the file at
>> file level. If changes don't overlap, then it returns the result with
>> a success. For example, if the file is changed only on one side, then
>> the driver will simply add the new content.
>>
>> => If conflicts appear, then the merge driver will put the markers in
>> an appropriate manner which the end-user application (e.g. open
>> office) can understand and show the user. For example, the XML file of
>> that ODF document will be modified and OO can show it  to user in its
>> way. We will have to study about the OO style of version marking.
>> Another method is to implement the marker style in our own way. For
>> example, to show any marker, the XML file is modified so that user can
>> see markers like ">>>> " or "====" in openoffice....In this case, we
>> will have to just change the xml content in this way.
>
> That is correct, but I would appreciate a bit more definitive research
> _before_ the project proposal, as a sign that you are capable of working
> out the details of the project.

I do understand your point and will work this.

>> > - a timeline (weekly milestones should be fine, I guess) what should
>> >   be  achieved when, and
>>
>> Timeline can be decided once we reach some conclusion and the work which
>> needs to be done become clear to us.

I meant to say that time line can decided after the list of works is
decided and discussed. Of course, I will present the timeline in my
student application in GSoC 2009. :)

> Do not get me wrong, I want this project to succeed.

I will try my best.

> But on the other hand, I feel the obligation to be a bit demanding for the
> gracious donation of Google: we _do_ want to have something stunningly
> awesome at the end of the summer.
>
> And that means that I have to get the impression from the student proposal
> that something like that is at least _possible_.
>
> Ciao,
> Dscho
>



--
Saurabh Gupta
Senior,
NSIT,New Delhi, India
