From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 18 Mar 2009 16:55:03 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903181645440.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com> 
 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm> <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 00:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk5dA-0000zD-Kw
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 00:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbZCRXzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZCRXzM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 19:55:12 -0400
Received: from mail.lang.hm ([64.81.33.126]:39747 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbZCRXzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 19:55:11 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2INt3OD025936;
	Wed, 18 Mar 2009 15:55:03 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113707>

On Thu, 19 Mar 2009, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 13 Mar 2009, saurabh gupta wrote:
>
>> On Fri, Mar 13, 2009 at 1:29 AM,  <david@lang.hm> wrote:
>>> On Fri, 13 Mar 2009, saurabh gupta wrote:
>>>
>>> it may be just doing an XML merge driver is a summer's worth of work,
>>> or it may be that it's not really enough and you should try to do
>>> another one or two.
>>>
>>> it also may be that there is a lot of overlap between different merge
>>> drivers, and once you have the XML driver the others become fairly
>>> trivial to do. (I'm thinking the config file examples I posted earlier
>>> in the thread)
>>
>> with the options given to the user, one can handle the config files
>> also where order doesn't matter and also the whitespaces problem can
>> also be handled in the similar way.
>
> In my humble opinion, we should focus on the data types we want to be
> able to support at the end of the summer first.
>
> For example, if we decide that OOXML is a must (as it is a proper
> standard, and many people will benefit from it), we will most likely end
> up in having to write a merge _driver_ (to handle those .zip files), _and_
> a merge _helper_, although we can avoid writing our own GUI, as we can
> create an OOXML that has its own version of conflict markers.

do you mean OOXML (the microsoft format) or ODF (the open office format)?

> If we decide that SVG is something we want to support by the end of the
> summer, then we can probably avoid writing a merge _driver_, as plain text
> is handled reasonably well in Git.  OTOH it could turn out that there are
> _real_ conflicts in overlapping tag ids, and it would still be easier to
> write a merge driver, too.
>
> IOW the details are not as important as
>
> - knowing what data types we want to support _at the least_, and what data
>  types we keep for the free skate,
>
> - a clear picture of the user interface we want to be able to provide,
>
> - a timeline (weekly milestones should be fine, I guess) what should be
>  achieved when, and
>
> - being flexible in how to support that (IOW if a merge driver appears
>  unnecessary first, but necessary later, we should be able to fit that
>  into both the design and the timeline).

it's up to the student, but I suspect that the best approach would be to 
start with defining a merge driver to handle XML (with a minimum set of 
capabilities, and additional optional ones), and go from there.

David Lang

> How does that sound?
>
> Ciao,
> Dscho
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
