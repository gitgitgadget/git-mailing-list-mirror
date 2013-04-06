From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFD] annnotating a pair of commit objects?
Date: Sat, 06 Apr 2013 09:55:53 +0200
Message-ID: <515FD509.4070307@alum.mit.edu>
References: <7vr4m2ycij.fsf@alter.siamese.dyndns.org> <50E5568A.5060909@alum.mit.edu> <CALWbr2xOt-tRy1iPJft28O1-fDVo1=DZhEZX6Me3Mt4pZjMyFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWT0-0001b9-46
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab3DFH4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 03:56:00 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:47393 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932635Ab3DFHz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Apr 2013 03:55:59 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-c6-515fd50e4897
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C0.32.02295.E05DF515; Sat,  6 Apr 2013 03:55:58 -0400 (EDT)
Received: from [192.168.69.140] (p57A25776.dip.t-dialin.net [87.162.87.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r367tsNP013580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 6 Apr 2013 03:55:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <CALWbr2xOt-tRy1iPJft28O1-fDVo1=DZhEZX6Me3Mt4pZjMyFw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqMt3NT7QYGufhsWvs7tYLLqudDNZ
	NPReYbZ4Mvcus8WPlh5mB1aPnbPusns8fNXF7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGe07jnLXtAtVvHl/B+mBsYTgl2MnBwSAiYSrSteMELYYhIX7q1n62Lk4hASuMwose3i
	M2YI5zSTxPGpb9hBqngFtCVe7FnECmKzCKhKnHx6AyzOJqArsainmQnEFhUIk9h7YRobRL2g
	xMmZT1hAbBEBDYn2tudg9cwCzYwSz7bVgtjCAhYSvx/fZYJYNotR4vCDY2ALOAUCJS7vPQ90
	BQdQg7rE+nlCEL3yEtvfzmGewAhUjLBiFkLVLCRVCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+bl
	pRbpGurlZpbopaaUbmKEhDjPDsZv62QOMQpwMCrx8FrcjgsUYk0sK67MPcQoycGkJMqbcCk+
	UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIr+xzoHLelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS
	1OzU1ILUIpisDAeHkgRvzxWgoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgSI0v
	BsYqSIoHaK8hSDtvcUFiLlAUovUUoy7HyitPXjMKseTl56VKifOyXwYqEgApyijNg1sBS2iv
	GMWBPhbmrQQZxQNMhnCTXgEtYQJawn8BbElJIkJKqoGx/H+O1zap679VZj0SbLzAvcBlcse8
	x5xKy5onf1hx11ttyfT5i95LP5igLZz95GF7+ux9728oRzClpKWZfTs4b88+9S2L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220230>

On 04/05/2013 09:36 PM, Antoine Pelisse wrote:
> On Thu, Jan 3, 2013 at 10:59 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> How could M be stored?  Assuming that these type of premerge merges are
>> sparse, then Jeff's analysis seems good.  Concretely, one could simply
>> store pointers to M from both X and Y; e.g.,
>>
>> * Add a note to X with the information "when merging this commit with Y,
>> use premerge M"
>>
>> * Add a note to Y with the information "when merging this commit with X,
>> use premerge M"
>>
>> Then, when merging, create the set J..B, scan all of the commits on B..J
>> for these "premerge" notes (O(|B..J|)), and for each one, look in the
>> set J..B to see if it is present.  The effort should scale like
>>
>>     O( |J..B| + |B..J| * lg(|J..B|) )
>>
>> where, of course J and B could be exchanged for either aesthetic or
>> performance reasons.  (One would also need a mechanism for preventing M
>> from being garbage-collected.)
> 
> I like the idea of using notes and a kind of "pre-merge". The proposal
> seems decent to me.
> 
> Michael, have you started implementing such a thing ? If you did, I
> would love to help as much as I can.
> If you didn't, I would like to start implementing this feature (I
> think I now have some time to do so).
> Maybe that would require some kind of mentoring though. It could be a
> nice opportunity for the community to improve that too as a fake
> "gsoc" (no google, no summer, no student)

No, I haven't pursued this topic per se.  We don't use such a workflow
on my projects, so it isn't a particular itch of mine.  I am currently
more interested in approaches to merging branches that have diverged
"too far" from each other [1].

There will be some overlap with this idea and my "git-mergemate" project
[2], if I ever find the time to make progress on it.  For that project,
I will also need to store lots of intermediate merge commits, in fact
also merges between parts of two branches.  I had planned to
autogenerate branch names by simply sticking the SHA1s of the parents
together, like maybe

    refs/mergemate/NAME/SHA1-SHA1

or

    refs/mergemate/NAME/SHA1/SHA1

where NAME is the overall name of a merge that is in progress.  These
references would be cleaned up when the merge was complete but would
prevent garbage collection of the intermediate results until then.

I would be happy to collaborate with you but it might not turn out so
well because my time for open-sourcing is so limited and unpredictable.

Michael

[1]
http://softwareswirl.blogspot.de/2012/12/the-conflict-frontier-of-nightmare-merge.html

[2] https://github.com/mhagger/git-mergemate  (yes I know the name sucks)

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
