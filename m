From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Wed, 13 Nov 2013 17:03:31 +0100
Message-ID: <5283A2D3.2080309@alum.mit.edu>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com> <878ux7g1ml.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Nov 13 17:10:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgd1f-00053I-03
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 17:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027Ab3KMQKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 11:10:39 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51370 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756573Ab3KMQKi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Nov 2013 11:10:38 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2013 11:10:38 EST
X-AuditID: 1207440e-b7fbc6d000004ad9-83-5283a2d888bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 49.CD.19161.8D2A3825; Wed, 13 Nov 2013 11:03:36 -0500 (EST)
Received: from [192.168.69.146] (p57A241BF.dip0.t-ipconnect.de [87.162.65.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rADG3VjU015422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Nov 2013 11:03:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <878ux7g1ml.fsf@linux-k42r.v.cablecom.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqHtjUXOQwb77zBZdV7qZLBp6rzBb
	HDwm6cDscfGSsseUe/9ZPT5vkgtgjuK2SUosKQvOTM/Tt0vgzvj5cTljwX6eipbFd9kbGP9y
	djFycEgImEjcuCbbxcgJZIpJXLi3nq2LkYtDSOAyo8TpfXsZQRJCAueZJL5uBCviFdCWePJt
	MjOIzSKgKnHt1AQ2EJtNQFdiUU8zE4gtKhAk8ejQQ3aIekGJkzOfsIDYIgJKEpc+3AeLMwtY
	S6x4fRisXljATmLjgSMsIPcICaRK9P1kBzE5Bcwlevo0QUyQ6m+7iyAa5SW2v53DPIFRYBaS
	+bMQqmYhqVrAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyRc+XYwtq+X
	OcQowMGoxMP7ILIpSIg1say4MvcQoyQHk5Ior8aC5iAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
	IrylC4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3hUgQwWLUtNT
	K9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB8RlfDIxQkBQP0F6dRSB7iwsSc4GiEK2nGI05
	jrz78I2RY94XICnEkpeflyolzpsLskkApDSjNA9uESxRvWIUB/pbmPcHyCM8wCQHN+8V0Com
	oFUuHmCrShIRUlINjO6B7uHr7sgvM5vTK+Mwc7WPiMDJXyz5H7fXv5omfSQ70ivw0YqyW3IW
	xc4vmtyu1M+J117ZX17d0TN9A+PWiqP3tu/a88e1/MjRDp7eZwsMWs/+M1xRzqNc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237791>

On 11/02/2013 12:09 AM, Thomas Rast wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> * tr/merge-recursive-index-only (2013-10-28) 3 commits
>>   - merge-recursive: -Xindex-only to leave worktree unchanged
>>   - merge-recursive: internal flag to avoid touching the worktree
>>   - merge-recursive: remove dead conditional in update_stages()
>
> FWIW -- since you dropped the earlier note to the same effect -- I still
> consider this "hold until Michael finds a use for it".

Thomas,

Sorry, I didn't realize that you are waiting on me.  I've been very busy 
lately and just got back from a trip to San Francisco.  The chaos is 
scheduled to continue for at least another week.

The biggest win from being able to run test merges without touching the 
tree would be to move a lot of the time-consuming processing work of 
git-imerge into the background while the user is asked to resolve 
conflicts.  It's kindof awkward, though, because for the user to resolve 
a conflict control has to be passed back to the user.  So the main 
git-imerge process would have to spawn off a worker daemon process that 
would continue working in the background.  But then there has to be some 
kind of communication between the worker thread and the user's 
*subsequent* call to "git imerge continue".

So the bottom line is that it is nontrivial to implement this so I will 
need a bit of concentrated time to dedicate to git-imerge before I will 
be able to give you any feedback.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
