From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Mon, 17 Mar 2014 11:05:12 -0700
Message-ID: <xmqqzjkoem5j.fsf@gitster.dls.corp.google.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
	<CACsJy8B3OPe1B4J8-4v_Oq0ZJpWfms8SmrrbfvYHzJ3WpE8P6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:05:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPbue-0001vC-Aq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbaCQSFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 14:05:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897AbaCQSFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 14:05:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7BF75265;
	Mon, 17 Mar 2014 14:05:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5tRjCjf6/ORAb6CSFdicSyYmQeY=; b=IHskb1
	o+bYQqabuvQiHA5OiWVWANR48jrHqxSaVJ6zVpbGnt/y7f7f3oG7Z05gZrBEEjsL
	9K3iYA9g4lIHkVBNx3sfN5vD20ocVoJJURXgZt0PqRe+LmeDHD/sNSVSLhqde6/g
	H7lw8gHWieycLTzHOE5s3jQksWqiQn6lCOuXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wGQ3qFNxFGDurl3fhBnmhMDRwckfkhbt
	nDvjU2/nAXJEeuVVG5lnoD11wRQV6JGCJ4rGpvwRk4VAgZKKjJn+qSIQw7KxUgad
	iYcTlnXZkZxW4XXzvMD+L1b5g9IH0Z6m5PNLL9PCZlCbb2tjGSbi6VRcqVDmt/rA
	OEjp7aKvtH0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47DBA75264;
	Mon, 17 Mar 2014 14:05:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CAC17525F;
	Mon, 17 Mar 2014 14:05:15 -0400 (EDT)
In-Reply-To: <CACsJy8B3OPe1B4J8-4v_Oq0ZJpWfms8SmrrbfvYHzJ3WpE8P6w@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 15 Mar 2014 19:34:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B0F26DE4-ADFE-11E3-B7D3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244260>

Duy Nguyen <pclouds@gmail.com> writes:

> There are two minor fixes [1] [2] on top of v5, but I'm not going to
> send v6 again unless I see more substantial changes. Just give me a
> signal or something before you merge to next so I have a chance to fix
> them if v6 never comes.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/243693
> [2] http://article.gmane.org/gmane.comp.version-control.git/243692

Thanks. I'd first need to give you a signal when I replace what was
queued with v5, as I have been way behind on this topic and another
large one from Michael, partly due to the "micro" storm for the past
few weeks.
