From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Thu, 15 Nov 2012 09:18:09 +0100
Message-ID: <50A4A541.6090201@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <7v7gqkgvxe.fsf@alter.siamese.dyndns.org> <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com> <508E0FAC.5050600@alum.mit.edu> <7v4nkuiuhe.fsf@alter.siamese.dyndns.org> <CAJDDKr5F5EcXaTuPWgE5MZJQ=Of6MwW+RmRhhXOLyfQzanjEwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYued-0000Gi-SD
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab2KOISS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:18:18 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:47854 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980Ab2KOISR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2012 03:18:17 -0500
X-AuditID: 1207440c-b7f616d00000270b-20-50a4a54872f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E1.54.09995.845A4A05; Thu, 15 Nov 2012 03:18:16 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAF8IAkZ020712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Nov 2012 03:18:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <CAJDDKr5F5EcXaTuPWgE5MZJQ=Of6MwW+RmRhhXOLyfQzanjEwQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRzvuZvbOT0558sepxhNTSlnSVH3Icyg4PpgGFIfhNDTXW65neNu
	sykhg3ypqWiWlEtFcgaFpYllmgiO1GZamjMxWC8gYkP7kNAL2Mvdhi9fHn48v7fn4f/HUIU3
	SIXpWTPDsbRBLZVLFLKTezRUlzP74JgPkr1d3Sj5cnUJJe2eWoS01XtQcqnNi5LLN5/IyLFJ
	kqxu7peQvyrrULLn2zyaKaeqGmql1GpNPaAGHV4Z9cVnl1HL9cOAmhlwo9TsuwRqvS8+G8sN
	OVZAm0tz9EXsgYz8EN3qrXVgGoy2PnV0Sm3gkcIOgjFIHIYNVT8lARwNZz72SEWsIOYA/N0k
	twO5gCcQuFA/JBMJnNgPK7++8IskRBKcub/mx1JCA+/VXUVEHEWch93DLiSgD4fuliV/QSSR
	CAfnZqViKEosIPDth7tBIhFBZMH5iXYk0OZCYFvdqN8dTJyF96ZXBDcmOJJhT7v/1SixGw6s
	taKNgHDs6HBsqxw7VB0AfQjiaYPFqDHSegPPFGr4QpplGU6TnmbUm9MYraUPBAYT+hz8eBzn
	AgQG1KH4q8XObEUQXcqXGV0gBkPUUfjndme2IqygRFumo3ldHmcxMLwLQAxVR+Iro4Ic19Jl
	5QxXsknFYhK1Ek9yJp9REEW0mSlmGBPDbbJxGKaGeLVTCA3nmCLGelFvMG/TCBYshstVkTzD
	ahmOtph1eeJQ83hhqiIVKvRaRTvOm2ijcBuwToJDWGtLzRLAenuEUyFhS1hGpcQTRSkhSnUW
	dqtocyt9QCn8OwIvF1Whws5u5fmEKkSo6o/zV5npbUplA6kRI7pnpy5xzo3c1Yyw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209808>

On 11/13/2012 09:50 PM, David Aguilar wrote:
> On Mon, Nov 12, 2012 at 9:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> The log message of the original commit (0454dd93bf) described the
>>> following scenario: a /home partition under which user home directories
>>> are automounted, and setting GIT_CEILING_DIRECTORIES=/home to avoid
>>> hitting /home/.git, /home/.git/objects, and /home/objects (which would
>>> attempt to automount those directories).  I believe that this scenario
>>> would not be slowed down by my patches.
>>>
>>> How do you use GIT_CEILING_DIRECTORIES that the proposed changes cause a
>>> slowdown?
>>
>> Yeah, I was also wondering about that.
>>
>> David?
> 
> I double-checked our configuration and all the parent directories
> of those listed in GIT_CEILING_DIRECTORIES are local,
> so our particular configuration would not have a performance hit.
> 
> We do have multiple directories listed there.  Some of them share
> a parent directory.  I'm assuming the implementation is simple and
> does not try and avoid repeating the check when the parent dir is
> the same across multiple entries.
> 
> In any case, it won't be a problem in practice based on my
> reading of the current code.

OK, so we're back to the following status: some people (including me)
are nervous that this change could cause a performance regression,
though it seems that the most sensible ways of using the
GIT_CEILING_DIRECTORIES feature would not be affected.

In favor: Currently, if a directory containing a symlink is added to
GIT_CEILING_DIRECTORIES, then GIT_CEILING_DIRECTORIES will not work, git
has no way of recognizing that there is a problem, and the only symptom
observable by the user is that the hoped-for performance improvement
from using GIT_CEILING_DIRECTORIES will not materialize (or will
disappear after a filesystem reorg) [1].

Against: The change will cause a performance regression if a
slow-to-stat directory is listed in GIT_CEILING_DIRECTORIES.  The
slowdown will occur whenever git is run outside of a true git-managed
project, most nastily in the case of using __git_ps1 in a shell prompt.

I don't have a preference either way about whether these patches should
be merged.

Michael

[1] It is also conceivable that GIT_CEILING_DIRECTORIES is being used to
*hide* an enclosing git project rather than to inform git that there are
no enclosing projects, in which case the enclosing project would *not*
be hidden.  This is in fact the mechanism by which the problem causes
failures in our test suite.  But I don't expect that this is a common
real-world scenario, and anyway such a failure would be obvious to the
user and quickly fixed.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
