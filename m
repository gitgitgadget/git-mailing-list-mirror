From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fixup! t3210: test for spurious error messages for dangling
 packed refs
Date: Sat, 27 Apr 2013 07:43:44 +0200
Message-ID: <517B6590.2080101@alum.mit.edu>
References: <7vehe2nr16.fsf@alter.siamese.dyndns.org> <1366708556-9172-1-git-send-email-mhagger@alum.mit.edu> <7vehe1i1bo.fsf@alter.siamese.dyndns.org> <5177F981.60105@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 07:44:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVxvW-0004w4-PO
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 07:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab3D0Fns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 01:43:48 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:47594 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753639Ab3D0Fnr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Apr 2013 01:43:47 -0400
X-AuditID: 12074414-b7fb86d000000905-17-517b659260d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 61.32.02309.2956B715; Sat, 27 Apr 2013 01:43:46 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD48CC.dip0.t-ipconnect.de [79.221.72.204])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3R5hij9019783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Apr 2013 01:43:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <5177F981.60105@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqDsptTrQYPV3JYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BnLrhxjKnjDVvFz0wWWBsZt
	rF2MnBwSAiYSb3buYIOwxSQu3FsPZHNxCAlcZpTY9OkJI4Rznkli3bX5LCBVvALaEo+eP2cH
	sVkEVCU+rloINolNQFdiUU8zE4gtKhAmsWr9MmaIekGJkzOfgPWKCKhJTGw7BGYzCxhJzFzz
	gxHEFhaIk/g7ZRbU5q2MEhdWvAVLcApoSby+PocZokFH4l3fAyhbXmL72znMExgFZiHZMQtJ
	2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISvyA7GIyflDjEK
	cDAq8fA2LqkKFGJNLCuuzD3EKMnBpCTKuya2OlCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK/C
	M6By3pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ3twUoKGCRanpqRVp
	mTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoGiNLwbGK0iKB2jv/mSgdt7igsRcoChE6ylGY45Z
	W5+8ZuRYeQVICrHk5eelSonz5oNsEgApzSjNg1sES1yvGMWB/hbmrQKp4gEmPbh5r4BWMQGt
	qp1eDrKqJBEhJdXAaKFSPlPrP99O7pn/t0i9+671fVUp56fp0xeu2HB0ibEs95envVecL2j1
	R27+5H30tfeF/Wv3WrYJ5/VE/L4tNHWpR//lRx/XJGo6Wfy+4MPg6rez6nn3HrmA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222621>

On 04/24/2013 05:25 PM, Michael Haggerty wrote:
> On 04/23/2013 07:50 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Let me know if you would prefer that I re-roll.
>>
>> Your fix-up cleanly applied to the result of applying the series up
>> to 16/33 and it was trivial to squash it in.
>>
>> Please holler if what I push out on 'pu' in 8 hours or so looks
>> wrong.
> 
> It looks like you did the right thing, except using v1 of my patch
> series rather than v2.  Please do the same procedure with v2: apply the
> v2 series on top of jc/prune-all, apply the fixup commit "fixup! t3210",
> and rebase the fixup to autosquash it onto patch 16/33.

The new version (0859ff6fe6) that I just fetched from you looks right.

Thanks!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
