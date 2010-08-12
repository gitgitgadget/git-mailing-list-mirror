From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 08:49:57 -0700
Message-ID: <7vsk2ju8yi.fsf@alter.siamese.dyndns.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <AANLkTinvWO_OakFbuHWrRWYCg4bvHuVPu8=d0_y5o0Ws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 17:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oja2o-0002w0-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760320Ab0HLPuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 11:50:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760275Ab0HLPuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 11:50:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25DC6CC8BD;
	Thu, 12 Aug 2010 11:50:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qO1N2UVO6aTE
	wfwS35l6/YEPVsQ=; b=disVF/XQhcZAsZpguIBonmQZgH6JLObdCCVpRIGUHte0
	20jarbUEwKaVuK89GDJ3uSodLVZKH5YqOSnugZH9dQzdnXnvaSORuvpd68YLpVs3
	AXfB270iNh5MpLKocDNz/+2s9CJ3k+xxUNcBJfJo5Ss3xdRWOvjUUYko8UeENyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nz/mAV
	J1dExnNk4H8Sp3pV1aAhQZ8CmnZy8WBe2kw0uiMzhXDaxT/AiEkQExpjXorwIRHr
	W/hloz9s2atpNQzjOplbAS/ThJeqcaQVF0vL74azr+yqDFvAUMC6/fYKK/0NIjFg
	+PZK7xXg2c2I7Wjm1IqU/5aU+LEMBoO5uG8Rk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04110CC8BC;
	Thu, 12 Aug 2010 11:50:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43EC6CC8BB; Thu, 12 Aug
 2010 11:50:00 -0400 (EDT)
Importance: high
In-Reply-To: <AANLkTinvWO_OakFbuHWrRWYCg4bvHuVPu8=d0_y5o0Ws@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 11 Aug 2010 23\:47\:34 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 453C9A10-A629-11DF-B89F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153382>

Elijah Newren <newren@gmail.com> writes:

> On Wed, Aug 11, 2010 at 5:35 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
>> * en/rebase-against-rebase-fix (2010-08-06) 2 commits
> It looks like you pulled my original submission, despite the fact tha=
t
> you commented on v3 of the series.  Granted, everything after v1 was
> just commit log wording changes and testsuite fixups, but I'll resend
> to make it easy for you to grab the latest.

Thanks.

>> * en/fast-export-fix (2010-07-17) 2 commits
>> =C2=A0- fast-export: Add a --full-tree option
> <snip>
>> * en/d-f-conflict-fix (2010-07-27) 7 commits
>> =C2=A0(merged to 'next' on 2010-08-03 at 7f78604)
> ...
> Out of curiosity, is there anything preventing these two series from
> advancing?

Nothing other than that we have been in pre-release freeze to 1.7.2 til
late last month, then immediately after the release I got bogged down i=
n
unpacking cardboard boxes, moving between apartments, during which peri=
od
I started slowly re-reading pent-up topics and merging ones that looked=
 Ok
to 'next'.  And then I got sick and haven't been productive for the pas=
t
few days...

Sorry.
