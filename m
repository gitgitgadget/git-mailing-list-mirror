From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 16:06:11 -0700
Message-ID: <7vobcxey3g.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7vwqrlezcs.fsf@alter.siamese.dyndns.org>
	<CAMP44s2iTBW3P25RCDQCoM02K1JTs9v6-8SG91MJeUxh4b1qEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:06:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWx9I-0006Ar-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307Ab3D2XGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:06:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890Ab3D2XGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:06:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7312D1B05A;
	Mon, 29 Apr 2013 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:in-reply-to:mime-version
	:content-type; s=sasl; bh=TYDDeuWarGCMMNXhOR5L6Bg9rJo=; b=tldt0G
	NffmL0s42FP/QC/m1S/lvjwaFWAjuKZZTjZN6q1Na4VLlSwSbysIM8/XaDUgnSpu
	OVr09VREjPVwg++VcOBO6XxL+inS5fBr66hb644T+ZW+HWsXyivAxD8RckOwdt13
	2jd3h5G8ME8rBmGyGMoH+28UeeNpq1XMxSihA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:in-reply-to:mime-version
	:content-type; q=dns; s=sasl; b=hvz/y37meBxiR2IyYsVlC56ORYO2F+I1
	VGkDacpDZycBuKHbserplJlU30thsR6is082ue99A5B1xHD25qECOG4FiTVvWGa4
	F0+NJPwvFA7WuKjKLUrSgchE7kOROLn2vlOxEpO7yGt6zyDxbj1Be48e9qgKtwlj
	30mzFpqH9Cc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A3A01B059;
	Mon, 29 Apr 2013 23:06:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7A431B058;
	Mon, 29 Apr 2013 23:06:13 +0000 (UTC)
Newsgroups: gmane.comp.version-control.git
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:VrHxdLKlUc8zFpQjUBC/VEBMcTY=
In-Reply-To: <CAMP44s2iTBW3P25RCDQCoM02K1JTs9v6-8SG91MJeUxh4b1qEQ@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 17:49:24 -0500")
Posted-To: gmane.comp.version-control.git
X-Pobox-Relay-ID: 63B01322-B121-11E2-ACF2-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222876>

The following message is a courtesy copy of an article
that has been posted to gmane.comp.version-control.git as well.

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Apr 29, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
>>> index 813cc1b..426c63f 100755
>>> --- a/t/t1503-rev-parse-verify.sh
>>> +++ b/t/t1503-rev-parse-verify.sh
>>> @@ -115,4 +115,13 @@ test_expect_success 'master@{n} for various n' '
>>>       test_must_fail git rev-parse --verify master@{$Np1}
>>>  '
>>>
>>> +test_expect_success 'empty @' '
>>> +     rev_hash=$(git rev-parse --verify @) &&
>>> +     test "$rev_hash" = "$HASH4" &&
>>> +     rev_hash=$(git rev-parse --verify HEAD@) &&
>>> +     test "$rev_hash" = "$HASH4" &&
>>> +     rev_hash=$(git rev-parse --verify master@) &&
>>> +     test "$rev_hash" = "$HASH4"
>>> +'
>>
>> Don't we have different refs that resolve to something other than
>> $HASH4 at this point in the test?
>
> No.

Of course we're free to make some as needed; perhaps like this?

 t/t1503-rev-parse-verify.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 426c63f..f8f3b34 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -115,13 +115,18 @@ test_expect_success 'master@{n} for various n' '
 	test_must_fail git rev-parse --verify master@{$Np1}
 '
 
-test_expect_success 'empty @' '
+test_expect_success 'empty @ and ref@ without trailing {stuff}' '
+	test_when_finished "git branch -d twoago" &&
+	git branch twoago HEAD~2 &&
 	rev_hash=$(git rev-parse --verify @) &&
 	test "$rev_hash" = "$HASH4" &&
 	rev_hash=$(git rev-parse --verify HEAD@) &&
 	test "$rev_hash" = "$HASH4" &&
 	rev_hash=$(git rev-parse --verify master@) &&
-	test "$rev_hash" = "$HASH4"
+	test "$rev_hash" = "$HASH4" &&
+	rev_hash=$(git rev-parse --verify twoago@) &&
+	test "$rev_hash" = "$HASH2" &&
+	test_must_fail git rev-parse --verify nosuch@
 '
 
 test_done
