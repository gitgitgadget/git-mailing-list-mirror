From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 11 Feb 2016 11:31:37 -0800
Message-ID: <xmqqtwlfvyau.fsf@gitster.mtv.corp.google.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
	<56BB4BDF.3010407@drmicha.warpmail.net>
	<xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
	<56BCAC69.8030909@drmicha.warpmail.net>
	<xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
	<CAB8-syo8dCjDfCH3gAFvC1cnuB-wm9hxtmVb1OhZ7NT0Pw+EbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dickson Wong <dicksonwong@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 20:31:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTwxt-0008Un-L4
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 20:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbcBKTbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 14:31:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750735AbcBKTbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 14:31:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 704C340FD9;
	Thu, 11 Feb 2016 14:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fK7Cbv0OSqVklcS8r0g5Rb5gaok=; b=VAbJfg
	tyCJZs0hQ3REWPPzy949gqlxUmEf81dXX5NnkIcEByO21OBddAyICG88qlRUer5/
	vrCX3rGpimm+MOw0FiUqA6mWXGRu47WD3EnmFUHvy+YXCl9c8LhDEWFxi9UJzkOx
	4cp3QSf+Ct4mIebiCa9i4060aQNBYwgjCO51k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SU6T4Q0KBVmTrc14gmQxqvZnPY2i/OT1
	2LErP7sY+FMJa1azaVAVDMMu+N690IeOuMuLmzvlBoZbGbf7K2QTD/PkHWxrI3YD
	mEPb4N4lMRvbXRqR4DWDDzkrketto5nMKxEo1NOKKtIkxm7zN8YmadOu0VgMCfPR
	Qu85y0e6vPw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B88340FD8;
	Thu, 11 Feb 2016 14:31:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCA9C40FD7;
	Thu, 11 Feb 2016 14:31:38 -0500 (EST)
In-Reply-To: <CAB8-syo8dCjDfCH3gAFvC1cnuB-wm9hxtmVb1OhZ7NT0Pw+EbQ@mail.gmail.com>
	(Dickson Wong's message of "Thu, 11 Feb 2016 11:24:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12140558-D0F6-11E5-AE09-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285991>

Dickson Wong <dicksonwong@gmail.com> writes:

> Thanks for looking into the patch.

No.  Thank _you_ for contributing ;-)

> Vim buffers are not reorderable and windows are always numbered from
> top-left to bottom-right. However, I can see someone who is familiar with
> the old behavior issue a "CTRL-W_K" command to move the merged window from
> the bottom to the top, making the merged window the first window and
> consistent with buffer indexes. If they use this command after the patch,
> the indexes would no longer be consistent. The command would most likely be
> issued manually and not through a vim startup script.

So it should suffice to mention it in the release notes as one
bullet item that describes one positive change, among all other
updates described in a simlar way.  And there is no special
"warnings for existing users" necessary, I would say.

Thanks.
