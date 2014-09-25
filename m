From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Thu, 25 Sep 2014 14:55:21 -0700
Message-ID: <xmqqbnq39xh2.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
	<xmqqfvff9ydi.fsf@gitster.dls.corp.google.com>
	<20140925214049.GP1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 23:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXH0c-00019V-5q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 23:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbaIYVz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 17:55:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65264 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbaIYVzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 17:55:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDAB23E036;
	Thu, 25 Sep 2014 17:55:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3toLBXDWeOOMliFFeMzcT45fnI=; b=kOZZYT
	DBRWKStfGW/4m00O9R+/3KcVug+dqMzi1KUERnjCjZFY5bB0XRdyHpxRr+gprkgS
	xMhXfpQ4ne3UtDzGzwizMedErdHajIzwzAMau7xJ/JbnCFv9xqcfY52mGxqPNU0e
	DSsknLE8hxPXJZqC0wdymzKySsWCYDwUtlksY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nreWrPClxPOKSuvpRw7ZcaWzcjugFHXE
	9X1cIg5qBVIuy2BMBp0OLzFH43LhR2fIArUODo3t8noRtPziokAr80BOIskRPDfY
	YwuzGiBghRcXFzz9sXVELsSDVj57PmXQgI41zxyas56eo/Y6QHY8qZD7S30N5z7a
	nerk0tb6mGk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4EC0C3E035;
	Thu, 25 Sep 2014 17:55:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CAB3E3E033;
	Thu, 25 Sep 2014 17:55:22 -0400 (EDT)
In-Reply-To: <20140925214049.GP1175@google.com> (Jonathan Nieder's message of
	"Thu, 25 Sep 2014 14:40:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A62EA6E2-44FE-11E4-95A0-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257499>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The patch "fix handling of badly named refs"[1] is still undergoing
> heavy churn.
>
> I think it's worth getting that one right.

Oh, no question about it.  I was only making sure that I didn't miss
availability of updates for larger series we saw during this cycle.
