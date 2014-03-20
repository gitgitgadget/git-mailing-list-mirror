From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Thu, 20 Mar 2014 18:01:05 +0100
Message-ID: <532B1ED1.3090208@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu> <531DF079.9050909@kitware.com> <531E30D7.40208@alum.mit.edu> <xmqqa9cwpkiw.fsf@gitster.dls.corp.google.com> <531F82FE.9030305@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:01:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgLF-0004BC-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 18:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbaCTRBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 13:01:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43425 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751271AbaCTRBK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 13:01:10 -0400
X-AuditID: 12074411-f79ab6d000002f0e-95-532b1ed548fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 01.B9.12046.5DE1B235; Thu, 20 Mar 2014 13:01:09 -0400 (EDT)
Received: from [192.168.69.148] (p5B15629D.dip0.t-ipconnect.de [91.21.98.157])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2KH163D022654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Mar 2014 13:01:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531F82FE.9030305@kitware.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqHtVTjvYYMVpPYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZG+fNZyt4KlyxqHU2YwPjC/4uRk4OCQETiQ0Hf7FB2GISF+6tB7K5
	OIQELjNKLPv7lAkkISRwjkni/bWALkYODl4BbYnLDZ4gYRYBVYn1sycxg9hsAroSi3qawcpF
	BYIlVl9+wAJi8woISpyc+QTMFgGqX7WuAWwXs8AaRombG2tAbGGBAIk9P5qh9rYxSVy5cJ8R
	JMEJtOv517NsIHslBMQlehqDQExmAXWJ9fOEIMbIS2x/O4d5AqPgLCTbZiFUzUJStYCReRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSBwI7mCccVLuEKMAB6MSD+9Fbu1g
	IdbEsuLK3EOMkhxMSqK8b2SAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR480ByvCmJlVWpRfkw
	KWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3ihgvAsJFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEg2I3vhgYvSApHqC9H8H2Fhck5gJFIVpPMepybNi2ppFJiCUvPy9VSpxX
	FGSHAEhRRmke3ApY0nvFKA70sTCvCUgVDzBhwk16BbSECWgJ/1QtkCUliQgpqQZG38rTCo83
	fFy/d0P1kyX6Ygxnz3YyP59+2y7H9aF8qXFh/gyxWu9GXdHigv//cy4x/1Te9Kvm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244558>

On 03/11/2014 10:41 PM, Brad King wrote:
> On Tue, Mar 11, 2014 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I may be misremembering things, but your first sentence quoted above
>> was exactly my reaction while reviewing the original change, and I
>> might have even raised that as an issue myself, saying something
>> like "consistency across values is more important than type-saving
>> in a machine format".
> 
> For reference, the original design discussion of the format was here:
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/233842
> 
> I do not recall this issue being raised before, but now that it has
> been raised I fully agree:
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/243754/focus=243862
> 
> In -z mode an empty <newvalue> should be treated as missing just as
> it is for <oldvalue>.  This is obvious now in hindsight and I wish I
> had realized this at the time.  Back then I went through a lot of
> iterations on the format and missed this simplification in the final
> version :(

It's not your fault; anybody could have reviewed your code at the time
(I most of all, because I have been so active in this area of the code).

> Moving forward:
> 
> The "create" command rejects a zero <newvalue> so the change in
> question for that command is merely the wording of the error message
> and there is no compatibility issue.
> 
> The "update" command supports a zero <newvalue> so that it can
> be used for all operations (create, update, delete, verify) with
> the proper combination of old and new values.  The change in question
> makes an empty <newvalue> an error where it was previously treated
> as zero.  (BTW, Michael, I do not see a test case for the new error
> in your series.  Something like the patch below should work.)
> 
>> I am not against deprecating and removing
>> the support for it in the longer term, though.
> 
> As I reported in my above-linked response, I'm not depending on
> the old behavior myself.  Also if one were to start seeing this
> error then generated input needs only trivial changes to avoid it.
> If we do want to preserve compatibility for others then perhaps an
> empty <newvalue> with -z should produce:
> 
>  warning: update $ref: missing <newvalue>, treating as zero

This last suggestion is what I am implementing for the re-roll (coming
shortly).  Thanks for the discussion.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
