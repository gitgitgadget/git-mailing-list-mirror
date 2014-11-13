From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: fix an inconsistency
Date: Thu, 13 Nov 2014 10:30:36 -0800
Message-ID: <xmqqppcr0x83.fsf@gitster.dls.corp.google.com>
References: <5463DA20.3080703@inventati.org> <5463FB4C.2060203@inventati.org>
	<xmqqy4rf0xod.fsf@gitster.dls.corp.google.com>
	<xmqqtx230xax.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: slavomir vlcek <svlc@inventati.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XozAQ-0000HS-0w
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627AbaKMSal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:30:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933226AbaKMSaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:30:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 605081C352;
	Thu, 13 Nov 2014 13:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZyWrrWjoJv8FVxVt9t1Mfxs/UQ=; b=UEbnGc
	zNf4vKablqM1UZLCsT+gwMZAulF8TVO/KyT75/60Y+MpVLAVyCw2Dig7/5njXuvC
	bWxD4TH0+lXnBREIrW0euWbK+pep/hPCE9p0vld9TIB6vbGi8P3J4yFGXqfI0aZy
	/taHEZqq5MTLCA1+4TFG/+kuAUgRf9i0dm2S4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SO9z7QfO2l3CoL5kwa9gVlj2kpJ78Osc
	opb7sMrIX+PBSx+rOOBNDdK80CFl8u99ABCgTLgj90ZCDX/qJk4vUoO6moQoKhy5
	plLplWLSS553JJcRYYuMt1QSf7OFqrJX3wheaJMsxu9vwigWO5mWLnhnnURiVNz0
	wekcrLwJvBY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BDD71C351;
	Thu, 13 Nov 2014 13:30:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A52661C350;
	Thu, 13 Nov 2014 13:30:37 -0500 (EST)
In-Reply-To: <xmqqtx230xax.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Nov 2014 10:28:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29E67750-6B63-11E4-8995-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Signed-off-by: slavomir vlcek <svlc@inventati.org>
>
>> The same comment applies to the log message part.
>
> I said:
>
>> Will queue; no need to resend.
>>
>> Thanks.
>
> But one thing to make sure.  Do you really mean to have your
> sign-off with all lowercase?  I can amend the patch to read
>
>     Signed-off-by: Slavomir Vlcek <svlc@inventati.org>
>
> while applying, so that your name does not stand out like a sore
> thumb in "git shortlog -20 -s" output, if you want.

... by the above, I mean something like what appears after the
scissors "-- >8 --" line below.

-- >8 --
From: Slavomir Vlcek <svlc@inventati.org>
Date: Thu, 13 Nov 2014 00:18:39 +0100
Subject: [PATCH] SubmittingPatches: final submission is To: maintainer and CC: list

In an earlier part there is:

  "re-send it with "To:" set to the maintainer [*1*] and "cc:" the list [*2*]"

for the final submission, but later we see

  "Send it to the list and cc the maintainer."

Fix the later one to match the previous.

Signed-off-by: Slavomir Vlcek <svlc@inventati.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e6d46ed..fa71b5f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -337,7 +337,7 @@ suggests to the contributors:
      spend their time to improve your patch.  Go back to step (2).
 
  (4) The list forms consensus that the last round of your patch is
-     good.  Send it to the list and cc the maintainer.
+     good.  Send it to the maintainer and cc the list.
 
  (5) A topic branch is created with the patch and is merged to 'next',
      and cooked further and eventually graduates to 'master'.
-- 
2.2.0-rc1-84-gcd6439f
