From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Wed, 17 Sep 2008 12:55:39 +0100
Message-ID: <b0943d9e0809170455m53eaf677t87e9ade3f001d044@mail.gmail.com>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
	 <20080914085118.GC30664@diana.vm.bytemark.co.uk>
	 <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
	 <20080915075740.GB14452@diana.vm.bytemark.co.uk>
	 <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com>
	 <20080916074024.GA2454@diana.vm.bytemark.co.uk>
	 <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com>
	 <20080916193647.GA12513@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11671_31986204.1221652539353"
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfvel-0008RH-9H
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYIQLzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYIQLzl
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:55:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:55729 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYIQLzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:55:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2996055wfd.4
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=M0r8inPuNfMW2GPGM6NhA5kW6NBWwO2lOgOqSwG5ojc=;
        b=GAA8qhiUnSKyH1TJxzDXHLcOId/UQvzIqCTlH/+O1KhHpODCZPUUw/y2l6sMonMqPG
         7WZrHAizTodwCi94T7dMGI0xukJi8ac7V6Uz6qpIFM4afijGrs8GG66olEt4Rm8PRufc
         HcN0WuGXUFYpheNtK/9oCjOJGN2HZV3hHAGCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=MO0sfL5kKYakk2cwwyE2/PjhPjNXV3DDbhsYM/y8FmFyCRNZlKRNTcQ/UeeObh2bG4
         bdymfi/sUetebqhxERlyV7wyFwhc6qR77wC/nh+yUvtUU6PD0dbN4hrjg0/S9a5lJTWU
         pFov2jipH6ok/bcitphfFX2thx6eTSBRbjuj4=
Received: by 10.114.241.15 with SMTP id o15mr1905202wah.164.1221652539371;
        Wed, 17 Sep 2008 04:55:39 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Wed, 17 Sep 2008 04:55:39 -0700 (PDT)
In-Reply-To: <20080916193647.GA12513@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96098>

------=_Part_11671_31986204.1221652539353
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2008/9/16 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-16 15:59:31 +0100, Catalin Marinas wrote:
>> I think we could merge your experimental branch into master. I gave
>> it a try and seems OK. The only issue I had was that I had an older
>> version of Git and it failed in really weird ways (stg pop still
>> busy-looping after 4 minutes and in another case it failed with
>> broken pipe). Once I pulled the latest Git, it was fine but we
>> should try to be compatible at least with the Git version in the
>> Debian testing distribution. It might be the patch at the top with
>> diff-ing several trees at once but I haven't checked.
>
> There are two patches that depend on new git versions. One needs git
> 1.5.6, which is in testing so I'll be pushing that to you;

OK.

> the other
> needs Junio's master branch, and i won't even consider asking you to
> take it until it's in a released git.

Correct :-)

> I hope to push it out to you tonight or tomorrow, but I have a small
> pet patch I'd like to finish first, so I might be late.

OK, no problem. I won't have much time before the weekend anyway.

>> BTW, I ran some benchmarks on stable/master/kha-experimental
>> branches with 300 patches from the 2.6.27-rc5-mm1 kernel. See
>> attached for the results. Since performance was my worry with the
>> stack log stuff, it turns out that there isn't a big difference with
>> real patches. I think pushing can be made even faster by trying a
>> git-apply first and taking the diff from the saved blobs in the log.
>
> When benchmarking recent StGits, you'll want to try goto as well,
> since push and pop are not yet new-infrastructure-ized (meaning
> they're getting slowdowns from the stack log, but no speedups (if any)
> from the new infrastructure).

Indeed, goto is faster even than the stable branch. I attached the new
figures. I think it could go even faster if pushing attempts a "git
apply" first before the index merge. With the stack log, the patch
diff should be saved already so no need for a "git diff" (as in the
stable branch).

--=20
Catalin

------=_Part_11671_31986204.1221652539353
Content-Type: text/plain; name=stack-log-benchmarks.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fl7wa6pp0
Content-Disposition: attachment; filename=stack-log-benchmarks.txt

Q1BVOiBJbnRlbCBQZW50aXVtIDQgQCAyLjVHSHoKTWVtb3J5OiAxR0IKCjIuNi4yNy1yYzUtbW0x
IGtlcm5lbCwgMzAwIHBhdGNoZXMgdW5jb21taXR0ZWQKCnBvcC9wdXNoIHJhbiBhIGZldyB0aW1l
cyB0byBoZWF0IHRoZSBjYWNoZXMgYmVmb3JlIHJ1bm5pbmcgdGhlCmJlbmNobWFya3MuCgoKU3Rh
YmxlIHN0Z2l0ICh2MC4xNC4zICsgc29tZSBmaXhlcykKCiQgdGltZSBzdGcgcG9wIC1hCgpyZWFs
CTBtMS43NzVzCnVzZXIJMG0wLjk1NnMKc3lzCTBtMC43MjRzCgokIHRpbWUgc3RnIHB1c2ggLWEg
KGZhc3QtZm9yd2FyZCkKCnJlYWwJMG01LjAwMXMKdXNlcgkwbTEuODQ0cwpzeXMJMG0yLjg2MHMK
CiQgdGltZSBzdGcgcHVzaCAtYSAobm8gZmFzdC1mb3J3YXJkKQoKcmVhbAkxbTI3LjEzM3MKdXNl
cgkwbTM2Ljk5OHMKc3lzCTBtMzQuODk0cwoKJCB0aW1lIHN0ZyBnb3RvIHRvcC1wYXRjaCAoZmFz
dC1mb3J3YXJkKQoKcmVhbAkwbTUuMzE0cwp1c2VyCTBtMS45MjBzCnN5cwkwbTIuNzY4cwoKJCB0
aW1lIHN0ZyBnb3RvIHRvcC1wYXRjaCAobm8gZmFzdC1mb3J3YXJkKQoKcmVhbAkxbTM5LjA0MHMK
dXNlcgkwbTM3LjAyMnMKc3lzCTBtMzUuNjY2cwoKCkN1cnJlbnQgc3RnaXQgbWFzdGVyIChubyBz
dGFjayBsb2cpOgoKJCB0aW1lIHN0ZyBwb3AgLWEKCnJlYWwJMG0xLjYyMXMKdXNlcgkwbTAuODIw
cwpzeXMJMG0wLjY4OHMKCiQgdGltZSBzdGcgcHVzaCAtYSAoZmFzdC1mb3J3YXJkKQoKcmVhbAkw
bTI3LjIwNXMKdXNlcgkwbTguNzQxcwpzeXMJMG0xNi44NDlzCgokIHRpbWUgc3RnIHB1c2ggLWEg
KG5vIGZhc3QtZm9yd2FyZCkKCnJlYWwJMm04LjIwOXMKdXNlcgkwbTQ2LjAzMXMKc3lzCTBtNTcu
MjYwcwoKJCB0aW1lIHN0ZyBnb3RvIHRvcC1wYXRjaCAoZmFzdC1mb3J3YXJkKQoKcmVhbAkwbTEw
LjQzN3MKdXNlcgkwbTIuMTYwcwpzeXMJMG0yLjQ2NHMKCiQgdGltZSBzdGcgZ290byB0b3AtcGF0
Y2ggKG5vIGZhc3QtZm9yd2FyZCkKCnJlYWwJMW0yMy4yNDRzCnVzZXIJMG0zOC4xNThzCnN5cwkw
bTM2LjA4NnMKCgpraGEvZXhwZXJpbWFudGFsIHN0Z2l0ICh3aXRoIHN0YWNrIGxvZyk6CgokIHRp
bWUgc3RnIHBvcCAtYQoKcmVhbAkwbTIuNDE5cwp1c2VyCTBtMS4xNDRzCnN5cwkwbTEuMTMycwoK
JCB0aW1lIHN0ZyBwdXNoIC1hIChmYXN0LWZvcndhcmQpCgpyZWFsCTBtMjkuNTk0cwp1c2VyCTBt
OS4yMTdzCnN5cwkwbTE3LjE0NXMKCiQgdGltZSBzdGcgcHVzaCAtYSAobm8gZmFzdC1mb3J3YXJk
KQoKcmVhbAkybTEwLjI3MHMKdXNlcgkwbTUwLjkxOXMKc3lzCTFtMi4wODhzCgokIHRpbWUgc3Rn
IGdvdG8gdG9wLXBhdGNoIChmYXN0LWZvcndhcmQpCgpyZWFsCTBtMi4xNzBzCnVzZXIJMG0xLjA4
NHMKc3lzCTBtMC40NjBzCgokIHRpbWUgc3RnIGdvdG8gdG9wLXBhdGNoIChubyBmYXN0LWZvcndh
cmQpCgpyZWFsCTFtMTguMjcxcwp1c2VyCTBtMzkuMDI2cwpzeXMJMG0zMS45MzhzCg==
------=_Part_11671_31986204.1221652539353--
