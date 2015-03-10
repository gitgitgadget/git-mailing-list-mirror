From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Tue, 10 Mar 2015 10:23:45 -0700
Message-ID: <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:26:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVNvR-00038H-El
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbbCJR0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 13:26:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752718AbbCJR0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 13:26:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B1EB3DFF9;
	Tue, 10 Mar 2015 13:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FwsSlo36u5dBTvIbfdb1AmrR0yk=; b=nzaJFT
	3BoeQUP+NaWsaGzZEKTXcx2jtEIsj/3hgnWYykbzd4XOvxGUd6jE185zJkkJxyHE
	1fTaVeFzq22Yo3BzgZACCF42rNrd3amteE0n/IoemeINDgrOVqDuinfnjWA8jw5g
	NQumBSzIl8MTf0r5t5zD4wQfJVo+1GiPcP27g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BVvDBUswFug5gSMSTjKcHQfbFDJJzcXg
	Q8IG+QsltfsGrU8YR8mg+/LfGXr7dqDoPajDXhU8HhwPD8VXz3FpcTk6ZJCxq7js
	uPOr8UGq/16gDZ9jjY4xtuWT1t1cLSnrkvGhMvzo7crbhGaLR2lczGKKBsLuRmWf
	Di2DvF40/AU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 161693DFF8;
	Tue, 10 Mar 2015 13:26:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92E433DF3D;
	Tue, 10 Mar 2015 13:23:46 -0400 (EDT)
In-Reply-To: <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 10 Mar 2015 12:51:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35723BAC-C74A-11E4-9853-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265245>

Christian Couder <christian.couder@gmail.com> writes:

> I don't want to write again about each of these points now. I am more
> interested in discussing a good strategy to try to revert the sad
> trend of Git developers being promoted less and less, because I think
> that it is really very important.

I would suspect that those who agree with you would appreciate if
you or somebody volunteered to act as our CKDO (chief kudos
distribution officer).  I do not think I have enough time to do that
well.  One good place to start might be to scan the list and
summarize something like the following on weekly or monthly basis,
as these are not something you can get by pointing people to "git
shortlog" output.

 - Those who gave helpful review comments, "how about going this
   way" illustration patches, etc.  Bonus points to those who helped
   onboarding newcomers.

 - Those who asked pertinent questions on common pain points, and
   those who answered them helpfully.

If you are more ambitious, the source of the kudos may want to cover
activities outside of this mailing list (e.g. giving talks and
tutorials at conferences, etc.).
