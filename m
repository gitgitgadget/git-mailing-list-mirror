From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fixup! t3210: test for spurious error messages for dangling
 packed refs
Date: Wed, 24 Apr 2013 17:25:53 +0200
Message-ID: <5177F981.60105@alum.mit.edu>
References: <7vehe2nr16.fsf@alter.siamese.dyndns.org> <1366708556-9172-1-git-send-email-mhagger@alum.mit.edu> <7vehe1i1bo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 17:26:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV1a9-0004lP-Im
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 17:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab3DXP0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 11:26:00 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:57076 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755928Ab3DXPZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 11:25:59 -0400
X-AuditID: 1207440d-b7fd06d000000905-2d-5177f986fda5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A2.B7.02309.689F7715; Wed, 24 Apr 2013 11:25:58 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3OFPsbQ023426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Apr 2013 11:25:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vehe1i1bo.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqNv2szzQYGqHokXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oyeo1vYCu6zVhzd846tgfEw
	SxcjJ4eEgInEti997BC2mMSFe+vZuhi5OIQELjNKnJ3cwgLhHGeSWLj1DCNIFa+ApkR7YwMr
	iM0ioCrx7+J9sG42AV2JRT3NTCC2qECYxKr1y5gh6gUlTs58ArZNREBNYmLbITCbWcBIYuaa
	H2AzhQXiJP5OmQW1eTqjxIbOXWBDOQXMJO4/mM8G0aAj8a7vATOELS+x/e0c5gmMArOQ7JiF
	pGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MULCl3cH4/91MocY
	BTgYlXh4dzwvDxRiTSwrrsw9xCjJwaQkylv5HSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfR
	G6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCd8UPoEbBotT01Iq0
	zJwShDQTByfIcC4pkeLUvJTUosTSkox4ULTGFwPjFSTFA7QXrJ23uCAxFygK0XqK0Zhj1tYn
	rxk5Vl4BkkIsefl5qVLivCdBSgVASjNK8+AWwRLXK0ZxoL+FeQ+CVPEAkx7cvFdAq5iAVtVO
	B1tVkoiQkmpgNBAqetXQHW64gt3uswjDvb09X87OCGVIcP200kPVkevCBs6y9T8+mL15bHhp
	pU6EkfTBM8rsir9S7ryS/7c5Y1eB7Y6yA43FkamuR1e0NRhIWGqfspq+meUq+2uf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222256>

On 04/23/2013 07:50 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Let me know if you would prefer that I re-roll.
> 
> Your fix-up cleanly applied to the result of applying the series up
> to 16/33 and it was trivial to squash it in.
> 
> Please holler if what I push out on 'pu' in 8 hours or so looks
> wrong.

It looks like you did the right thing, except using v1 of my patch
series rather than v2.  Please do the same procedure with v2: apply the
v2 series on top of jc/prune-all, apply the fixup commit "fixup! t3210",
and rebase the fixup to autosquash it onto patch 16/33.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
