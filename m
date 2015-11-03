From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update japanese translation
Date: Tue, 03 Nov 2015 12:40:45 -0800
Message-ID: <xmqqio5iddf6.fsf@gitster.mtv.corp.google.com>
References: <1446554860-2539-1-git-send-email-miurahr@linux.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: miurahr@linux.com
X-From: git-owner@vger.kernel.org Tue Nov 03 21:40:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtiNw-0000ci-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 21:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbbKCUks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 15:40:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752030AbbKCUkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 15:40:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BD882916F;
	Tue,  3 Nov 2015 15:40:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KgbjGy/SHSHnRXlWo8X+g1oqcg0=; b=BRUDLV
	JiVyetBtwouOiB+w8aTrKzjd3h8nq7SIr937/EXTdC/fc1eswNSgjABEdz/2dtQa
	4zpHQHlK7/H4aLN+uTFoXsqeuKQA+jv4h2VUxzFdHmlDPMNcoKUKfR6IT8pAWBT4
	t9xHn8hQVBgAW+0GDfnNxuSPi8e16Tog2r0io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voISNCcWMDGHH27P5jjTbKjH2sqZKJ7N
	FGsdzJrFgWoCZ9TQXLZcll0nZ+K7/chB9RfBeDMY84SBN5sTizJo2/ouS91Syz2D
	HD8yIYU3ijqBMgnkhY/Lg2Z6DGFwpjhTIVkpBzH1ovO43uQakFGvit5m8non7ORW
	zJ8BVsCNc4Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0344B2916E;
	Tue,  3 Nov 2015 15:40:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6CAF429168;
	Tue,  3 Nov 2015 15:40:46 -0500 (EST)
In-Reply-To: <1446554860-2539-1-git-send-email-miurahr@linux.com>
	(miurahr@linux.com's message of "Tue, 3 Nov 2015 21:47:40 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28EFC4C6-826B-11E5-958C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280815>

miurahr@linux.com writes:

> From: Hiroshi Miura <miurahr@linux.com>
>
> - Update untranslated terms
>
> Signed-off-by: Hiroshi Miura <miurahr@linux.com>
> ---
>  gitk-git/po/ja.po | 97 ++++++++++++++++++++++++-------------------------------
>  1 file changed, 42 insertions(+), 55 deletions(-)

Sorry but I do not take patches directly to gitk or git-gui, both of
which are independent projects of their own.

Could you redo this change against Paul Mackerras's tree, which is
our upstream "gitk" project, that is found here:

    git://git.kernel.org/pub/scm/gitk/gitk.git

and Cc Paul Mackerras <paulus@samba.org>  when you post your patch?

Thanks.
