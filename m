From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stripspace: add --line-count flag
Date: Fri, 04 Mar 2016 10:57:33 -0800
Message-ID: <xmqqfuw6yste.fsf@gitster.mtv.corp.google.com>
References: <1457116723-20206-1-git-send-email-tigerkid001@gmail.com>
	<56D9D750.1030703@gmail.com>
	<xmqqk2liyt7j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:57:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abuv2-0004rU-RY
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759487AbcCDS5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:57:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759462AbcCDS5g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:57:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9B5F46D84;
	Fri,  4 Mar 2016 13:57:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSyNFq4oGGuYMN1NZI9kfqZODis=; b=Qkw2lb
	stw6q6a1gpW3MtPQXRbsvRWEPkaD/JAZpKxUhmSYqQ4RVf4ioAayz9NfafmQNcJ1
	WvmIRHwmmPWc/eZhc/Dtwwzta4r37NBwAZb6urZ5dBE5isCIFxPOJsEaccMEM1Bx
	6yxbhma85r7TSldlPqnpq7BbUGYLlgqIrKeSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D1gJu4b31/31cTxYQdMiJfVCe+N4Hrgf
	XVWrDv9GmzGOJv+LcKwDkPqhwxWSDU/iP+ePX85uxVhmLEeoSueh8PjPaK4bWt3c
	Eu5vhRzIWDLJ++1UlzELGP8XNZsu5/Ag7980E0A3Qx9iaUbEQP2l47Ed4y1bCVEB
	EmQ5gegGp4Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0FE946D82;
	Fri,  4 Mar 2016 13:57:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1611946D7D;
	Fri,  4 Mar 2016 13:57:35 -0500 (EST)
In-Reply-To: <xmqqk2liyt7j.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 04 Mar 2016 10:49:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4FF5084-E23A-11E5-8727-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288272>

Junio C Hamano <gitster@pobox.com> writes:

> Sidhant Sharma <tigerkid001@gmail.com> writes:
>
>> This is my first attempt at the small project listed here: https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27.
>
>> Comments?
>
> Isn't that page somewhat stale?
>
> http://git.661346.n2.nabble.com/PATCH-0-3-stripspace-Implement-and-use-count-lines-option-tt7641360.html#none

And its reroll:

  http://thread.gmane.org/gmane.comp.version-control.git/279742

The discussion seems to indicate that we weren't in favor of
addition of this feature at least back then, e.g.

http://thread.gmane.org/gmane.comp.version-control.git/279742/focus=279888
