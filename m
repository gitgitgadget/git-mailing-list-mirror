From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Mon, 8 Aug 2011 13:54:04 +0530
Message-ID: <CALkWK0mKTXUxW=PT_wHEVAzUSgPdZ1s18-9ndZKJqSf6NwVH7w@mail.gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
 <1312454356-3070-18-git-send-email-artagnon@gmail.com> <CAP8UFD0izFOW0xHQB8ZT3+bbTjGtSm-ZWHs6AWdJoEneRX32mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 10:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqL8R-00040I-8f
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 10:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab1HHIY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 04:24:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41439 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab1HHIYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 04:24:25 -0400
Received: by wwf5 with SMTP id 5so1356547wwf.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9YFJV7Ei1ELzsS0NuvSdXsMYVM+/R6cheKWZp7bl+xg=;
        b=a9A5pr0kbziBN/4YhX+Zuug+TCOeDRrfMI0fmJThaYFj/X60c9McivjE1S37CuGvIp
         1AdUGNor2fpQ58vWjzibnahBretfsecSNqKztQ/r4fFq8Oaa2udlFa3REXz+YgpP1mJ0
         YC4CECbWZEueWwBSiGmz0Ws2c+NBd/kTH+BKo=
Received: by 10.216.168.198 with SMTP id k48mr680261wel.109.1312791864063;
 Mon, 08 Aug 2011 01:24:24 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 8 Aug 2011 01:24:04 -0700 (PDT)
In-Reply-To: <CAP8UFD0izFOW0xHQB8ZT3+bbTjGtSm-ZWHs6AWdJoEneRX32mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178947>

Hi Christian,

Christian Couder writes:
> On Thursday 04 August 2011 12:39:15 Ramkumar Ramachandra wrote:
>>
>> +test_expect_success '--signoff is not automatically propogated to resolved
>> conflict' '
>
> s/propogated/propagated/
>
> I found nothing else from another look at the tests in the series so you can
> add an "Acked-by: Christian Couder <chriscool@tuxfamily.org>" or "Signed-of-
> by: Christian Couder <chriscool@tuxfamily.org>".

Thanks for being so thorough! :)
Junio: Here's another small fixup patch for your convenience.

--8<--
Subject: [PATCH] fixup! revert: Introduce --continue to continue the
 operation


Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 78f3f01..3bca2b3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -171,7 +171,7 @@ test_expect_success '--continue respects opts' '
        grep "cherry picked from" anotherpick_msg
 '

-test_expect_success '--signoff is not automatically propogated to
resolved conflict' '
+test_expect_success '--signoff is not automatically propagated to
resolved conflict' '
        pristine_detach initial &&
        test_must_fail git cherry-pick --signoff base..anotherpick &&
        echo "c" >foo &&
-- 
1.7.6.351.gb35ac.dirty
