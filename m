From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Tue, 09 Sep 2014 12:15:23 -0700
Message-ID: <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
References: <540F426E.6080908@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRQt7-0001IK-8W
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaIITPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 15:15:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62637 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbaIITP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 15:15:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E536837CD9;
	Tue,  9 Sep 2014 15:15:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AMKjFssRxVQ81m5jOQxFVj3QFS0=; b=tc1lpl
	4O+JfPM4VKQNHlYRoyq5EjZprzpqi4A5N9a7MQ20wmsE4IXXTaDczC46dVtgutTv
	1o8LrD3H4OVKESKBWJVQOl9xB6VLx8J6fl6p+I1NSm4sfl8vdSPHx654SQjwiGo3
	7p1uXvyZXAuEoc8MhY+HpSdwsOFQQq0vBaUqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJbMmuawm/0VkrQSL7fhQFZcjhUIE+X5
	URQb6dgT5xJavrLi25eeywLVkgcGrFi9CeCFfx0vV7Nxpdd+MMzLk7j7ZAVaXQFa
	6NDkfOwwXcAK9kINBtZP4e8e52QpQC9hRRedgrnevIBa7Xi2p3pRRhA1Iie33Bgz
	+8QXmXbACJU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 700CC37CD7;
	Tue,  9 Sep 2014 15:15:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6AA0537CD5;
	Tue,  9 Sep 2014 15:15:25 -0400 (EDT)
In-Reply-To: <540F426E.6080908@exec64.co.uk> (Harry Jeffery's message of "Tue,
	09 Sep 2014 19:09:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7143F14-3855-11E4-BF13-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256704>

Harry Jeffery <harry@exec64.co.uk> writes:

> Add a new format prefix `_` that causes a line-feed to be inserted
> immediately after an expansion if the expansion expands to a non-empty
> string. This is useful for when you would like a line for an expansion
> to be prepended, but only when the expansion expands to a non empty
> string, such as inserting a '%_d' expansion before a commit to show any
> refs pointing towards it.

Is this different from "%n%-d"?
