From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 08:29:18 -0800
Message-ID: <xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
References: <87zjb78u7g.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:29:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvTqo-0003YO-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbaLAQ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:29:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752892AbaLAQ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:29:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B15FC22F00;
	Mon,  1 Dec 2014 11:29:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8LYDy4shdCPkmrWyFgvyxr8qXw=; b=MVloWo
	hbAi+BZHcjcNiiNTYOXx7hPS/w+jlZYPs5518FQ7DkOfVGPmFs0huwLYp8thQSm+
	RRzE9XQP8cx8SKJH4zb88QY7IjjWsu9Wz89rbmC2nDaeqXAvVgrscgB5pUKtyykL
	SKg+o+EJF3KiBIYK4LuMyKdjGyUXgRZOTS2Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CX6YXuuSTTmGlgM/n+c7Gr3752bsMq56
	sNPHMvcQ1hcwnCRjx2iAE7gsfv65WBhvSzxrdBt0+qTdVxVbmFIjz4tKklbM4Bjd
	xC/fNCxD4IL8sKK+7lzyVuoTgY4xodR3+Z+ZPLM+aad1Yuw6+WnQsL2w+Yfzjm+B
	GujrZRYAo+4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A82E322EFF;
	Mon,  1 Dec 2014 11:29:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00E5022EFE;
	Mon,  1 Dec 2014 11:29:19 -0500 (EST)
In-Reply-To: <87zjb78u7g.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
	01 Dec 2014 14:50:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33816334-7977-11E4-98F4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260490>

Sergey Organov <sorganov@gmail.com> writes:

> Hello,
>
> $ git help log | grep exit-code
>            problems are found. Not compatible with --exit-code.
> $
>
> What --exit-code does in "git log"?

It doesn't.  That is why it is not listed.
