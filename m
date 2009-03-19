From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 01:37:15 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903190129110.4560@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com> 
 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm> <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903181645440.16753@asgard.lang.hm>
 <alpine.DEB.1.00.0903190141300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 09:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkDmG-0007Pm-Jo
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 09:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbZCSIhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 04:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbZCSIhb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 04:37:31 -0400
Received: from mail.lang.hm ([64.81.33.126]:60040 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbZCSIha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 04:37:30 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2J8bF7a027292;
	Thu, 19 Mar 2009 00:37:15 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903190141300.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113734>

On Thu, 19 Mar 2009, Johannes Schindelin wrote:

> On Wed, 18 Mar 2009, david@lang.hm wrote:
>
>> On Thu, 19 Mar 2009, Johannes Schindelin wrote:
>>
>>>
>>> In my humble opinion, we should focus on the data types we want to be
>>> able to support at the end of the summer first.
>>>
>>> For example, if we decide that OOXML is a must (as it is a proper
>>> standard, and many people will benefit from it), we will most likely
>>> end up in having to write a merge _driver_ (to handle those .zip
>>> files), _and_ a merge _helper_, although we can avoid writing our own
>>> GUI, as we can create an OOXML that has its own version of conflict
>>> markers.
>>
>> do you mean OOXML (the microsoft format) or ODF (the open office
>> format)?
>
> Oops.
>
> EOVERLOAD

it happens.

>>> If we decide that SVG is something we want to support by the end of
>>> the summer, then we can probably avoid writing a merge _driver_, as
>>> plain text is handled reasonably well in Git.  OTOH it could turn out
>>> that there are _real_ conflicts in overlapping tag ids, and it would
>>> still be easier to write a merge driver, too.
>>>
>>> IOW the details are not as important as
>>>
>>> - knowing what data types we want to support _at the least_, and what
>>>   data types we keep for the free skate,
>>>
>>> - a clear picture of the user interface we want to be able to provide,
>>>
>>> - a timeline (weekly milestones should be fine, I guess) what should
>>>   be achieved when, and
>>>
>>> - being flexible in how to support that (IOW if a merge driver appears
>>>   unnecessary first, but necessary later, we should be able to fit
>>>   that into both the design and the timeline).
>>
>> it's up to the student, but I suspect that the best approach would be to
>> start with defining a merge driver to handle XML (with a minimum set of
>> capabilities, and additional optional ones), and go from there.
>
> Well, the thing is: if the student decides to have a go at an XML driver
> first and foremost, then I'll just flatly refuse to mentor that.  Because
> I sincerely believe that this project is best designed from top to bottom,
> not the other way round.
>
> After all, the project is based on a user's request, not just a
> playthingie for an XML enthusiast (if such a thing exists).

all three formats mentioned here (OOXML, ODF, SVG) are XML-based formats 
and a single flexible XML merge driver could potentially handle all three 
(as well as other formats). for that matter, the ODF specs cover multiple 
types of data, and I suspect that appropriate conflict markers for text 
could well end up being different than the ones for spreadsheets.

that's not a 'plaything for an XML entusiast', it's making the tool 
slightly more general than it would need to be for any one of these 
formats to let it handle all of them.


but I'm not a mentor or a student, just an interested user.

David Lang
