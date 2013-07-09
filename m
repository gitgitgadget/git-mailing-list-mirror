From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] merge -Xindex-only
Date: Tue, 09 Jul 2013 11:44:15 +0200
Message-ID: <51DBDB6F.7090105@alum.mit.edu>
References: <cover.1373219466.git.trast@inf.ethz.ch> <51DAD8F2.5070008@alum.mit.edu> <87k3l1gip1.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 11:44:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwUT9-0001mw-DC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 11:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3GIJoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 05:44:19 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62456 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753268Ab3GIJoS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 05:44:18 -0400
X-AuditID: 12074412-b7f656d00000102f-85-51dbdb712cb8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FD.7E.04143.17BDBD15; Tue,  9 Jul 2013 05:44:17 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r699iF80005815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Jul 2013 05:44:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <87k3l1gip1.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqFt4+3agwa3D1hZdV7qZLO5eXsXu
	wORx+/V8Zo/Pm+QCmKK4bZISS8qCM9Pz9O0SuDP6t3xhLpgjVtHY9oW1gXG+YBcjJ4eEgInE
	4UN9TBC2mMSFe+vZuhi5OIQELjNKHNh7ignCucok8XvDOrAqXgFtiT9vjrCB2CwCqhIrH74G
	i7MJ6Eos6mkGsjk4RAXCJK78VoUoF5Q4OfMJC0hYREBZYtvCGhCTGaj64ZtEEFMYaOCVbkuQ
	YiGBeon2CT/YQWxOAXOJWY3rmUFsZgEdiXd9D6BseYntb+cwT2AUmIVk/iwkZbOQlC1gZF7F
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERKiQjsY15+UO8QowMGoxMM74+Kt
	QCHWxLLiytxDjJIcTEqivCdu3A4U4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7aCdQjjclsbIq
	tSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgtf5FlCjYFFqempFWmZOCUKaiYMT
	ZDiXlEhxal5KalFiaUlGPChG44uBUQqS4gHaC9bOW1yQmAsUhWg9xajLceDHlveMQix5+Xmp
	UuK8ySBFAiBFGaV5cCtgCekVozjQx8K8AiBVPMBkBjfpFdASJqAlDWm3QJaUJCKkpBoY16c+
	q5Pb+nJtf/ijfse/ob432LIcllQsijbPD5P6cyyu33p7/cyGzbLhcR/ONKuInrx+7pPzViX1
	bf/qNbu7P98tn7A4qeNGdvAf8c0nAhoX+c9yezB7y7MVn3O/XCgJOFwz/cSrt4dn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229925>

On 07/08/2013 05:44 PM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> [Resend because of address confusion in replied-to email.]
>>
>> On 07/07/2013 08:00 PM, Thomas Rast wrote:
>>> I recently looked into making merge-recursive more useful as a modular
>>> piece in various tasks, e.g. Michael's git-imerge and the experiments
>>> I made in showing evil merges.
>>>
>>> This miniseries is the extremely low-hanging fruit.  If it makes a
>>> good first step for git-imerge, perhaps it can go in like this.  It's
>>> not a big speedup (about 2.2s vs 2.4s in a sample conflicting merge in
>>> git.git), but it does feel much cleaner to avoid touching the worktree
>>> unless actually necessary.
>>>
>>> Otherwise it's probably not worth it just yet; for what I want to do
>>> with it, we need some more reshuffling of things.
>>
>> Interesting.
>>
>> For git-imerge, it would be nice to speed up merges by skipping the
>> working tree updates.  10% might not be so noticeable, but every little
>> bit helps :-)
>>
>> But the killer benefit would be if git-imerge could do some of its
>> automatic merge-testing and autofilling in the background while the user
>> is resolving conflicts in the main index and working tree.
>>
>> Is it possible to use this option with an alternate index file (e.g.,
>> via the GIT_INDEX_FILE environment variable)?  Can it be made to leave
>> other shared state (e.g., MERGE_HEAD) alone?  If so, maybe it's already
>> there.
> 
> GIT_INDEX_FILE yes, that one works out of the box.
> 
> I think for the shared state, the following is a (probably) ridiculously
> unsupported yet magic way of achieving this:
> 
>   mkdir -p unshared/.git
>   cd unshared/.git
>   for f in ../../.git/*; do
>     case "$f" in
>       *HEAD | index)
>         cp "$f" .
>         ;;
>       *)
>         ln -s "$f" .
>         ;;
>     esac
>   done
> 
> That gives you a repository that propagates ref changes and object
> writing, but does not propagate changes to index, HEAD, FETCH_HEAD or
> MERGE_HEAD.  Which might just be what you need?
> 
> Note that as far as I'm concerned, this is a live handgrenade.  It could
> blow up in your face at any time, but it probably has its applications...

I might consider such a thing for my own use, but I don't think I'll lob
live hand grenades at innocent git-imerge users :-)

Since you've already implemented a way to merge into the index (even an
alternative index) without touching the working copy, I'll just cross my
fingers and hope for the appearance of an option that makes merge leave
HEAD, MERGE_HEAD, etc. untouched.

It's not like I have any free time to work on git-imerge anyway :-(

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
