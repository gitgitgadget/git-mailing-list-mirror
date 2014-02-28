From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 10:49:52 +0100
Message-ID: <53105BC0.5040304@alum.mit.edu>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com> <xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com> <530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com> <8538j31u1n.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK5F-000066-10
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaB1JuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:50:15 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46334 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbaB1JuM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 04:50:12 -0500
X-AuditID: 12074413-f79076d000002d17-8b-53105bd3e1f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 82.E1.11543.3DB50135; Fri, 28 Feb 2014 04:50:11 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1S9nqUX022554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 04:50:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <8538j31u1n.fsf@stephe-leake.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqHs5WiDY4MoidYuuK91MFjuez2B2
	YPLYtn4Nu8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmNb1ewFSzlrNj5zaeB8TR7FyMnh4SAicTy
	OXPYIGwxiQv31gPZXBxCApcZJe486mWEcM4xSZy8tRWsg1dAW2L5718sIDaLgKrE9V3XwWw2
	AV2JRT3NTCC2qECwxOrLD1gg6gUlTs58AmaLCBhJdPzbAFTDwcEsIC7R/w8sLCygKXH1wisW
	iF03GCW27r8BdhGngJ7Eib83mEHqJYDqexqDQMLMAjoS7/oeMEPY8hLb385hnsAoOAvJtllI
	ymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyR8hXcw7jopd4hR
	gINRiYd3gid/sBBrYllxZe4hRkkOJiVR3plRAsFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjz
	3IFyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3oUgQwWLUtNTK9Iy
	c0oQ0kwcnCDDuaREilPzUlKLEktLMuJB8RtfDIxgkBQP0N46kHbe4oLEXKAoROspRl2O222/
	PjEKseTl56VKifPKgBQJgBRllObBrYAlq1eM4kAfC/M2gVTxABMd3KRXQEuYgJZweoItKUlE
	SEk1MBZu3K564Lhpu8g3239HjVZaCGp8e/vi1PboVqEjU/e6BlUf+fSQReD+3hcxU3YtlP47
	J4F55s2eE19XMDlxPvooXtVczvSp8qCe8c0ly80P57b2HF+dsLRMLc7mdOOZjC3B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242932>

On 02/28/2014 10:11 AM, Stephen Leake wrote:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> If I understand the issue correctly, the problem is that packed-refs
>> are always case-sensitive, even if core.ignorecase=true. 
> 
> Perhaps that could be changed? if core.ignorecase=true, packed-refs
> should be compared with case-insensitive string compares.

I think you are putting too much focus on what the local Git repository
does.  As soon as you pull content from somebody else, you are at the
mercy of the reference names that they have chosen.

In my opinion, a more fruitful approach is to have a pre-receive hook at
your central repository that prevents references that differ in case
only from being pushed in the first place.  As an extra convenience, you
can set your local repos up with a pre-commit hook that does the same
thing, so that developers (usually) see the problem immediately rather
than only when they try to push.

Of course, the pre-receive/pre-commit hooks could be even stricter by,
for example, allowing only lower-case branch names.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
