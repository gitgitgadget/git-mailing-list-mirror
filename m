From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 07:51:57 +0200
Message-ID: <51CBD2FD.5070905@alum.mit.edu>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 07:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us57r-0006ZJ-VO
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 07:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab3F0FwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 01:52:07 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61986 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353Ab3F0FwG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 01:52:06 -0400
X-AuditID: 12074414-b7f626d0000001f1-b0-51cbd30419d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.4E.00497.403DBC15; Thu, 27 Jun 2013 01:52:04 -0400 (EDT)
Received: from [192.168.69.140] (p57A25DC0.dip0.t-ipconnect.de [87.162.93.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5R5pvEW022228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 27 Jun 2013 01:51:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130626223552.GA12785@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsUixO6iqMty+XSgwfz/MhaP5l9gtei60s1k
	0dB7hdniydy7zBbL5l5ms/jR0sNssXvaAjaL+Ycmslp0dnxldOD02DnrLrvHw1dd7B7Pevcw
	ely8pOzxeOIJVo8/5/ewenzeJOdx+9k2lgCOKG6bpMSSsuDM9Dx9uwTujOt3WlkL9opXfD6/
	hK2B8ZFQFyMnh4SAiUT/h01sELaYxIV764FsLg4hgcuMEnuurGaEcM4zSRz9tYMVpIpXQFti
	Y9d1JhCbRUBVYu6B12DdbAK6Eot6msHiogJhEu+XTYWqF5Q4OfMJC4gtIiAr8f3wRrChzAIX
	mCRe3FnFDpIQFvCQ+HpzDhPEtslMEucvNIJ1cwpYSzzpuwlkcwB1qEusnwd2NrOAvMT2t3OY
	JzAKzEKyYxZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihMSK
	yA7GIyflDjEKcDAq8fB6sJwOFGJNLCuuzD3EKMnBpCTKu+0UUIgvKT+lMiOxOCO+qDQntfgQ
	owQHs5IIb2gOUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYJX6hJQ
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB2usF0s5bXJCYCxSF
	aD3FqMtx4MeW94xCLHn5ealS4rwuIEUCIEUZpXlwK2CJ8RWjONDHwrxRIFU8wKQKN+kV0BIm
	oCUzl5wCWVKSiJCSamBkUWqL/734jcydtT7CG/osZs2f0sllY1x2QIdztU5c5dz3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229088>

On 06/27/2013 12:35 AM, Jeff King wrote:
> On Wed, Jun 26, 2013 at 10:45:48PM +0100, Ramsay Jones wrote:
> 
>>> This patch adds some *extra* cache invalidation that was heretofore
>>> missing.  If stat() is broken it could
>>>
>>> (a) cause a false positive, resulting in some unnecessary cache
>>> invalidation and re-reading of packed-refs, which will hurt performance
>>> but not correctness; or
>>>
>>> (b) cause a false negative, in which case the stale cache might be used
>>> for reading (but not writing), just as was *always* the case before this
>>> patch.
>>>
>>> As far as I understand, the concern for cygwin is (a).  I will leave it
>>> to others to measure and/or decide whether the performance loss is too
>>> grave to endure until the cygwin stat() situation is fixed.
>>
>> Hmm, I'm not sure I understand ... However, I can confirm that the
>> 'mh/ref-races' branch in next is broken on cygwin. (i.e. it is not
>> just a speed issue; it provokes fatal errors).
> 
> I think Michael's assessment above is missing one thing.

Peff is absolutely right; for some unknown reason I was thinking of the
consistency check as having been already fixed.

> However, when we have taken a lock on the file, there is an additional
> safety measure: if we find the file is changed, we abort, as that should
> never happen (it means somebody else modified the file while we had it
> locked). But of course Cygwin's false positive here triggers the safety
> valve, and we die without even realizing that nothing changed.
> 
> In theory we can drop the safety valve; it should never actually happen.
> But I'd like to keep it there for working systems. Perhaps it is worth
> doing something like this:
> 
> [...#ifdef out consistency check on cygwin when lock is held...]

Yes, this would work.

But, taking a step back, I think it is a bad idea to have an unreliable
stat() masquerading as a real stat().  If we want to allow the use of an
unreliable stat for certain purposes, let's have two stat() interfaces:

* the true stat() (in this case I guess cygwin's slow-but-correct
implementation)

* some fast_but_maybe_unreliable_stat(), which would map to stat() on
most platforms but might map to the Windows stat() on cygwin when so
configured.

By default the true stat() would always be used.  It should have to be a
conscious decision, taken only in specific, vetted scenarios, to use the
unreliable stat.

For example, I can't imagine that checking the freshness of the index or
of the packed-refs file is ever going to be a bottleneck, so there is no
reason at all to use an unreliable stat() here.

On the other hand, stat() seems definitely to be a bottleneck when
testing for changes in a 100,000 file working tree, and here occasional
mistakes might be considered acceptable.  So for this purpose the
unreliable stat() might be used.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
