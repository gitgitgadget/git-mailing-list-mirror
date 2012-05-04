From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Index format v5
Date: Fri, 04 May 2012 09:12:46 +0200
Message-ID: <4FA3816E.8090005@alum.mit.edu>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com> <87obq5p1t0.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net, spearce@spearce.org,
	davidbarr@google.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 04 09:19:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCo2-0005UG-2v
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab2EDHTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:19:53 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:55144 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134Ab2EDHTx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 03:19:53 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 03:19:52 EDT
X-AuditID: 1207440e-b7f256d0000008c1-11-4fa38172335e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 56.50.02241.27183AF4; Fri,  4 May 2012 03:12:50 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q447Clr2012412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2012 03:12:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <87obq5p1t0.fsf@thomas.inf.ethz.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsUixO6iqFvUuNjfoPm6hcWjk5uZLLqudDNZ
	NPReYbb40dLDbDH/0ERWiwurb7NbrNy1kMmB3WPnrLvsHgs2lXo8693D6HHxkrLHn/N7WD3m
	flrE6vF5k1wAexS3TVJiSVlwZnqevl0Cd8apU4vZCiYLVFyfso61gfEWTxcjJ4eEgInExmsr
	GCFsMYkL99azdTFycQgJXGaU2L7oHiOEc4xJYsaL5SwgVbwC2hIdT2Yzg9gsAqoSOw7MA4uz
	CehKLOppZgKxRQXCJPpvb2GCqBeUODnzCViNiIC6xMd1rWBxZoF5jBKtU/O7GDk4hAVkJDas
	9wIJCwmUSDTMOwRWzilgIHG9YQEzSAmzgLXEt91FEJ3yEtvfzmGewCgwC8mCWQhVs5BULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokREgV8Oxjb18scYhTgYFTi4dVa
	uchfiDWxrLgy9xCjJAeTkijvmYbF/kJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeBnzgXK8KYmV
	ValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQmIoYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgKI0vBsYpSIoHaO92kHbe4oLEXKAoROspRl2O2Uu2XmUUYsnLz0uV
	EuftBykSACnKKM2DWwFLea8YxYE+FuY9DlLFA0yXcJNeAS1hAloibbAIZElJIkJKqoGR6bkr
	Q+aflx2fL8954buP6+zHTlP1ZJUdQtbrmoyWO9oaMi60DfdYfskvVPl0zfrazV+c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196998>

On 05/03/2012 08:16 PM, Thomas Rast wrote:
> Thomas Gummerer<t.gummerer@gmail.com>  writes:
>
>>    32-bit crc32 checksum over ctime seconds, ctime nanoseconds,
>>      ino, file size, dev, uid, gid (All stat(2) data except mtime) [7]
> [...]
>> [7] Since all stat data (except mtime and ctime) is just used for
>>      checking if a file has changed a checksum of the data is enough.
>>      In addition to that Thomas Rast suggested ctime could be ditched
>>      completely (core.trustctime=false) and thus included in the
>>      checksum. This would save 24 bytes per index entry, which would
>>      be about 4 MB on the Webkit index.
>>      (Thanks for the suggestion to Michael Haggerty)
>
> This is the part I'm most curious about.  Are we missing anything?
> Michael brought it up on IRC: the stat() results are only used to test
> whether they are still the same, with the exception of the mtime (which
> also undergoes raciness checks).
>
> As far as I can see, none of st_{ino,dev,uid,gid} are useful for
> anything.  st_size might conceivably be used as a hint for a buffer
> size, but nobody actually does that.  The ctime undergoes stricter
> checks, but AFAICS it's also all about whether it has changed, and
> besides that can be turned off.  We think all of those fields can be
> replaced by an arbitrary hash/CRC and only tested for equality.  32 bits
> should be plenty, probably even if we just xor the values together.

XOR is definitely *not* adequate; for example, changing uid=gid="you" to 
uid=gid="me" would not affect the XOR of the values (assuming, as is 
often the case, that each user has his own uid/gid with the same 
numerical values).

Which hash to use depends on some estimate of the likelihood that the 
hashes collide and simultaneously that the other metadata coincide.  It 
seems to me that CRC-32 would be adequate.  But if not, a longer hash 
could be used (albeit with less space savings).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
