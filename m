From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Tue, 24 Feb 2015 10:06:00 +0100
Message-ID: <54EC3EF8.7040302@alum.mit.edu>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>	<1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>	<20150221062754.GC29665@peff.net>	<xmqqzj87wxck.fsf@gitster.dls.corp.google.com>	<20150221073509.GA32548@peff.net> <xmqqvbitx0eh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Matt Whiteley <mattwhiteley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQBS1-0001Bs-DY
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 10:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbbBXJGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 04:06:19 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59133 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481AbbBXJGO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 04:06:14 -0500
X-AuditID: 1207440f-f792a6d000001284-1b-54ec3efbae7a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.2B.04740.BFE3CE45; Tue, 24 Feb 2015 04:06:03 -0500 (EST)
Received: from [192.168.69.130] (p5DDB21CD.dip0.t-ipconnect.de [93.219.33.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1O9609h027174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Feb 2015 04:06:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqvbitx0eh.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPvb7k2IQXcnm0XXlW4mi4beK8wW
	L48vZrX40dLD7MDisXPWXXaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE748GmqIKZ
	YhW3WvtZGxjvC3YxcnJICJhIPLrzlBHCFpO4cG89WxcjF4eQwGVGid+9h9khnPNMEov+/GQC
	qeIV0JbYPP02O4jNIqAqcevDcrA4m4CuxKKeZjBbVCBI4tDpxywQ9YISJ2c+AbNFBBwlTjy4
	ztrFyMHBLGAv8fZnKkhYWMBbovPEQqhdi5kkvu7bwwqS4BSwlnjxbyvYLmYBPYkd13+xQtjy
	Es1bZzNPYBSYhWTFLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pS
	uokREs78Oxi71sscYhTgYFTi4T0g8yZEiDWxrLgy9xCjJAeTkiivjw1QiC8pP6UyI7E4I76o
	NCe1+BCjBAezkgjvAlugHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJ
	gvciSKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFLji4GxCpLiAdr7DGxvcUFi
	LlAUovUUo6KUOO9ekIQASCKjNA9uLCxJvWIUB/pSmPc5SBUPMMHBdb8CGswENHjP41cgg0sS
	EVJSDYwrMr+9qyjbXL7c0ud2rRWP/d7U/bPvPQtt7iiYFr3IKlLSWe2mMIPMo9o1Fa/ev1uy
	6FrVZpUV/mxyCwV8jy+fP3liVmLI4/TvGisvLL++bPOqi3Mvri1YeeFBH3dQ0fHO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264314>

On 02/22/2015 07:32 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I wonder if there is some better word that could become a synonym for
>> "--reference --dissociate". Maybe "--borrow", but that does not
>> necessarily carry the implication that the relationship ends as soon as
>> the clone is done.
> 
> You are retracing the exact line of the thinking that led me to a
> cop-out that is a separate "--dissociate".
> 
> The original idea was to give "--borrow /local/repository/path", but
> that would have made it unclear what the differences between that
> new option and existing "--reference" were.  Both borrow the objects
> in order to reduce the network cost, and the difference is that one
> keeps borrowing while the other one limits the borrowing to strictly
> the initial phase.  The two words, "borrow" and "reference", would
> not convey that key distinction.  "Do the reference thing (which is
> well understood from old days, even before v1.6.0) and then severe
> the ties" was suboptimal but was easy to explain, and that is why I
> call it a cop-out.
> 
>> What is really happening is that we are reusing
>> objects in order to save bandwidth. Maybe "--reuse-from" would work?
>>
>> I dunno. I am not extremely happy with any of the suggestions I made,...
> 
> I dunno, either.
> 
> We are all on the same page.  We know the cop-out is suboptimal, we
> understand why the cop-out is better than "--borrow", and we cannot
> come up with a better name that contrasts with the existing
> "--reference" to make it clear how the new thing is different.

I'll take that as an invitation to brainstorm :-)

    --use-objects-from=
    --copy-objects-from=
    --precopy-objects-from=
    --precopy-from=
    --donor=
    --object-donor=
    --steal-from=
    --steal-objects-from=

Of these, I think I like "--object-donor" the best.

By the way, once we have stopped thinking about this feature as
"--reference" and then "--dissociate", it becomes obvious that a nice
generalization would be to allow *any* repository (including remote
ones) to serve as the object donor. This would allow users to get most
of their objects from a "nearby" repository (e.g., a mirror on the LAN)
and then top off from a more distant "authoritative" repository.

In fact, this donor/recipient relationship could be made persistent:
before fetching from repository A, always first fetch any objects that
repository B has available. OTOH, making the relationship persistent
would presumably require us to retain remote-tracking references for
repository B even though they are not intrinsically interesting to the
user, and would lead to reference namespace conflicts if the user wants
a "--mirror" clone.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
