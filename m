From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 17:28:56 +0200
Message-ID: <51964CB8.40903@alum.mit.edu>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com> <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com> <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu> <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com> <5195F3EB.8000308@alum.mit.edu> <CACPiFCLqtSy_=1yw6mGWFhNOi=M1rrPNbD6=qpo4FOO_QywCgg@mail.gmail.com> <51962D52.7070200@alum.mit.edu> <20130517133457.GA11496@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 17 17:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdMaj-00057S-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 17:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3EQP3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 11:29:03 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:55387 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755485Ab3EQP3B (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 11:29:01 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-e1-51964cbcfd0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.71.02380.CBC46915; Fri, 17 May 2013 11:29:00 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4HFSvfo001937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 May 2013 11:28:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130517133457.GA11496@inner.h.apk.li>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqLvHZ1qgwbIjohbLjnUyWmyYe5fF
	outKN5NFQ+8VZouN60wcWD12zrrL7vHhY5zHxUvKHp83yQWwRHHbJCWWlAVnpufp2yVwZ3w+
	9oW94Jh4xel9U5kbGB8JdTFyckgImEgsavzAAmGLSVy4t54NxBYSuMwocWVZQBcjF5B9nUli
	y92nYAleAU2Jpskt7CA2i4CqROvp62DNbAK6Eot6mplAbFGBMIlV65cxQ9QLSpyc+QSsRkRA
	QeLA+h2MIEOZBTYwSvQuWgc0lINDWEBHYt7MUIhlF5klvnetAGvgBLpu879OVhCbGajmXd8D
	ZghbXmL72znMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW
	6KWmlG5ihIQ13w7G9vUyhxgFOBiVeHhnOE8LFGJNLCuuzD3EKMnBpCTKG+wNFOJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTCe/zj1EAh3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IEbzAwfoUEi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQbEaXwyMVpAUD9Be
	P5B23uKCxFygKETrKUZdjhk/Jr9jFGLJy89LlQK6AKRIAKQoozQPbgUsib1iFAf6WJg3CqSK
	B5gA4Sa9AlrCBLSE9RrIc8UliQgpqQZG9zPNlWtWnv1q91Lz6pvFW7TzZ14vdA8R43Cvk1+8
	8sNpjk25YjuOCr8/+7LDrWLpjya3eW31D06tNhebJreYe9rH26ou6pUhxZ3rvfZ9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224696>

On 05/17/2013 03:34 PM, Andreas Krey wrote:
> On Fri, 17 May 2013 15:14:58 +0000, Michael Haggerty wrote:
> ...
>> We both know that the CVS history omits important data, and that the
>> history is mutable, etc.  So there are lots of hypothetical histories
>> that do not contradict CVS.  But some things are recorded unambiguously
>> in the CVS history, like
>>
>> * The contents at any tag or the tip of any branch (i.e., what is in the
>> working tree when you check it out).
> 
> Except that the tags/branches may be made in a way that can't
> be mapped onto any commit/point of history otherwise exported,
> with branches that are done on parts of the trees first, or
> likewise tags.

This is true, but cvs2git nevertheless puts the required content on the
branch so that it checks out correctly.  In other words, a "CVS tag
creation" (which might not have been done a single point in time) is
done by cvs2git roughly like this (assume it is from master):

1. Make a list of all versions of all files that have to be in the tag.

2. When one of those file versions has to be overwritten (e.g., because
a later version of that file needs to be added to master), create a Git
tag-branch containing all of the files that are currently at the correct
version for the tag.  (It has to be a Git branch, not a tag, because we
might have to change it later.)

3. As other files on master go through the revisions needed for the tag,
create new commits on the tag-branch that add those revisions of those
files to the tag-branch.

At the end of the process, the tag-branch has the same contents as the
CVS tag, though it may have had to be created via multiple commits.

Currently, step 3 creates merge commits from master to the tag-branch.
This is sometimes what one would expect, sometimes not--a matter of
taste, really, because the CVS history is in this aspect more flexible
than what is representable in Git's history model.

> ...
>> That being said, I appreciate that cvsimport can do incremental imports.
>>  cvs2git doesn't even attempt it.  I've thought about what it would take
>> to implement correct incremental imports in cvs2svn/cvs2git, and it is
> 
> Do these two produce stable output? That is, return the same commits
> for multiple runs on the same repo?

It usually produces stable output, but not always.  I've had reports of
users using cvs2svn successfully as an "incremental importer" by simply
running the full import each time and relying on Git to match up the
overlapping part of the history simply because the SHA-1s are identical.
 But (1) the later conversions would be just as slow as the first, (2)
some of the heuristic decisions for grouping CVS file changes into Git
changesets can be affected by later commits, and (3) CVS history is
mutable; if the CVS history is changed retroactively in any way then it
won't work at all.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
