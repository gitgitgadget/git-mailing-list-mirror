From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Suggestions for "What's cooking"
Date: Thu, 13 Sep 2012 15:14:26 +1000
Message-ID: <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org> <504F8427.1020507@web.de>
 <7vhar4gxdq.fsf@alter.siamese.dyndns.org> <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 13 07:15:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC1lR-0000q1-Or
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 07:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab2IMFOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 01:14:48 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50960 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab2IMFOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 01:14:47 -0400
Received: by qaas11 with SMTP id s11so2836715qaa.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 22:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=at5Rms10oejNcyp/NBgx0RV1tHVxnzHu/nr3d+c77SI=;
        b=qIGOPgsZ2kmEC5uqLNtJjNQ2PA7akBdNMyZTHYua5t8eh0QBrjMgNn0JDzS8CK2TOn
         PxbzMBqvTMxY2i3WPDuU0SUN1z80bPFoUgoxDzkKHWEqD3iT4zeXQ3H5db/PNQDuoveU
         jNbKXA9Nck20WmY+p1tXMjMqToVEvdcmSrEsOPhukGmX4Zy4z1UXalP35vEpTh8VyBM7
         FYNVdKpavAfODnRn4wSu1pA8F/yHdXGOFIC7sEhyDbSfOoF+Y17eZ6ccjkuxqOjbidNE
         1qbVyu/8mM7J+q2t3NxFDZ5gsN4ZbhIoSKRtIu2c7Jqx+i/u8NyIPZYUGfK2pGN2k4nX
         1c7g==
Received: by 10.224.98.2 with SMTP id o2mr3078142qan.57.1347513286579; Wed, 12
 Sep 2012 22:14:46 -0700 (PDT)
Received: by 10.49.95.135 with HTTP; Wed, 12 Sep 2012 22:14:26 -0700 (PDT)
In-Reply-To: <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205353>

(sorry about double replying - html sub-part creeped in!)
On 13 September 2012 08:49, Philip Oakley <philipoakley@iee.org> wrote:
>
> From: "Jens Lehmann" <Jens.Lehmann@web.de>
> Sent: Wednesday, September 12, 2012 8:21 PM
>
>> Am 11.09.2012 21:41, schrieb Junio C Hamano:
>>>
>>> Thanks.  I wish all others paid attention to "What's cooking" like
>>> you did here.
>>>
>>> And if it is hard to do so for whatever reason, suggest a better way
>>> for me to publish "What's cooking" or an equivalent (I am interested
>>> in finding the least bureaucratic way to help people and keep the
>>> balls rolling).
>>
>>
>> I think "What's cooking" makes lots of sense in its current form
>> as one gets a very good overview over current development tracks.
>>
>> Maybe in addition it would be nice to email the author(s) of a
>> series when the state changes or new comments are added (and to
>> only include the relevant part from "What's cooking" there). For
>> me it's not a big problem as I just have to grep for "submodule"
>> to get the bits I care about, but I suspect others might have to
>> invest much more time to check the current state of their series
>> and may appreciate being mailed directly when something happens.
>> Opinions?
>
>
> My comment, as a simple reader, is that I misread the order of the items, in that I miss-associate the description paragraph with the * title _below_. That is, I see the description first and then read on...
>
> Thinking about it, if the description paragraph was indented by one space then the * title  would create that obvious content indent that (I am) would be expected.
>
> Obviously only a useful suggestion if it's easy to implement...


I can attest to the fact that the format can be at times difficult to
parse, and I often find myself rereading sections to make sure I
understood what each was referring to.

As a casual reader, interested in the development that is going on,
the things I am interested in for each branch/topic are like:
 - Branch/Topic description
 - Current integration status
 - Next steps required
 - Notes and memoranda

I understand that references to where the branch is found (it's name)
and what it includes (commit list) are important too, but these are
less important for me.

Currently, the output for each branch looks something like:
* <branch-name> (<creation-date>) <number-of-commits>
  (<merge-status>)
 [list-of-commits]
  (<branch-usage>)
<long-description>
<notes-and-memoranda>
<next-steps>

and these are grouped by current integration status (new, graduated,
stalled etc)

A format that would make this information easier for me to parse would
be something like:

<short-branch-description>
  <long-branch-description>
  <notes>
  <next-steps>
  * <branch-name> (<creation-date>) <number-of-commits>
    (<merge-status>)
   [list-of-commits]
    (<branch-usage>)

Essentially, shifting the details of the branch to the bottom, and
adding a short description for the entire branch. Indent everything
after the short description to make it clear that they belong
together.

The only real 'new' information required is the short description, but
that could be replaced with the topic name if short description is not
available (or the topic name is self explanatory).

Most of the parsing benefit would come from the indentation, but
having the 'summary' information near the top would let me skip things
I am not interested in without having to scan the list of commits and
other details.

Regards,

Andrew Ardill
