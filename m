From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! mergetools: simplify how we handle "vim" and
 "defaults"
Date: Mon, 28 Jan 2013 19:02:47 -0800
Message-ID: <7vy5fcu1wo.fsf@alter.siamese.dyndns.org>
References: <20130128192856.GA7498@serenity.lan>
 <CAJDDKr5wsYqnBk+kvKj1qzUYKJBJ5nAiwMJZ=HpzPPgJf8BBTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U01Td-0006Xw-P3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 04:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab3A2DCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 22:02:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723Ab3A2DCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 22:02:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EBC2B2D6;
	Mon, 28 Jan 2013 22:02:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3K327eBZZHZkFWmOuIpi6weHjag=; b=UBMHSK
	h24RYSVJjYfzrjf3QCMZK5DSpBHoDGKbT2o6wNN3LWhBeXxSGKYHLtth9F1PWu2+
	kNjQSlHLEwmCVjOd+lHAYWOQmTpH0ZpJpOIJjYpWd9AF4QXHAoTAoiUKQ8cVxvMQ
	AM6OGqrvsIbxMsUfGTeMaAhqgrxvGpGP2xOlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQy1WxbA7/xBkKuVgrPDjhS1+6XTODuF
	3P009cpkwLcVSFpkhr7U/1wJtmHGXDhTP3bUuFwzWWA6Jqm5zkVdQF1Vzabs4Ydb
	kpISXLMG7GzshhFkXaxzUtJbVcBFTlCsa8ruk2oYMWV31e71EFVRaN5ZynsZfvMb
	v8/1mGyD7Uw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435B4B2D5;
	Mon, 28 Jan 2013 22:02:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1171B2D4; Mon, 28 Jan 2013
 22:02:49 -0500 (EST)
In-Reply-To: <CAJDDKr5wsYqnBk+kvKj1qzUYKJBJ5nAiwMJZ=HpzPPgJf8BBTQ@mail.gmail.com> (David
 Aguilar's message of "Mon, 28 Jan 2013 17:37:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D823852-69C0-11E2-B6A3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214894>

David Aguilar <davvid@gmail.com> writes:

> On Mon, Jan 28, 2013 at 11:28 AM, John Keeping <john@keeping.me.uk> wrote:
>> ---
>> Junio, please can you squash this into f9924e5 on jk/mergetool,
>> providing that David is OK with that?
>
> This looks good to me.

Thanks for a quick response.  Will squash this in and rebuild the
two affected branches.
