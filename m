From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 11 Feb 2016 08:03:57 -0800
Message-ID: <xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
	<56BB4BDF.3010407@drmicha.warpmail.net>
	<xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
	<56BCAC69.8030909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Dickson Wong <dicksonwong@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 11 17:04:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTtj4-0006Ww-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 17:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcBKQEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 11:04:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750889AbcBKQEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 11:04:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F33283F596;
	Thu, 11 Feb 2016 11:03:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NVTf1jumxAS403IQAI2Ldt6NhpY=; b=ebjlpS
	0CErEoeqWIXU5/ktmyeZi45l/46Owp7CxLGZeghy+uf16efW13S0NIcTE4DtTpZI
	IMWqPhqbM/gCxDqB2XKqxql917JS23cKKm1nanp15oyPomLWVCPjuUgiZ5gERvtq
	yAB5WtnKpXlhIv1GhjCb5NR2rzSrawXMxD7Ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BoPP/GtG50yp9U/XBrK2aTUMrEh7ITzz
	gc9dn/BzfR6F3fv1VvU8UAXoHtzHpi7amLKXQJW5UvEoFblsyLahKJbS6OoftaWZ
	tO2YXkqPqIHc23VY2fXso2S1giaoaq/Tyit1ycy/92Iv/TEqLkjI19AYovfpNU1r
	PyJBTx6Tfkg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8C8C3F595;
	Thu, 11 Feb 2016 11:03:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 675603F594;
	Thu, 11 Feb 2016 11:03:59 -0500 (EST)
In-Reply-To: <56BCAC69.8030909@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 11 Feb 2016 16:44:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0FB0C2B4-D0D9-11E5-A8D9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285982>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Does this mean that I should warn in the release notes that some
>> existing users might get their expectation broken but we are going
>> ahead anyway because we think most people read left to right and
>> then top down?  I am OK with saying that--I just wanted to make sure
>> we know that it is what we are doing.
>
> I would claim that anyone who notices the difference in buffer numbering
> would be positively surprised.

Thanks. I, being a non-user of vim, was wondering if people who had
their own user-defined commands (macros? and possibly short-cut keys
to invoke them) built around the old (and odd) numbering need to
adjust--in which case we may need to forewarn.

> In any case, the buffer numbering is not the same (it is local remote
> base merge) but it doesn't matter in this case because only one window
> is displayed, so there is no visual association.

OK, thanks.
