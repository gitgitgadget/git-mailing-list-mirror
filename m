From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -m: only call "notes copy" when rewritten exists
 and is non-empty
Date: Sun, 26 Feb 2012 16:01:09 -0800
Message-ID: <7vpqd1cfga.fsf@alter.siamese.dyndns.org>
References: <1330144282-22540-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1o1k-0005eU-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 01:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab2B0ABM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 19:01:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab2B0ABL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 19:01:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7019A7BEA;
	Sun, 26 Feb 2012 19:01:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CE8nTnQ0KKoW33AxvzN8oJ9KOu4=; b=Em7bmy
	/NblpCUjNQ/YCDrfriVWs4x8xOTyM+xrNQY3UCpliZajLcap9tGIymXpFKgvOKfv
	h8rckXdQnkdek4NBo9m1vXn9yVwsjcIPAMRY/DseaLQQf/9M0qZnwS73HOuMWmmr
	TrrlBZdZiBoX/6xzOkOvX2LjpZBH/KoHytTsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NStf1nI/JVvHwie9HPkq3SiMOuT/B7Rf
	X0OQne6Bom9wYJY1ODZldbmnrgxhnmMYUqxFdeDlgkyU5Q0Rae2HYKz7PZUJQJfH
	DmaZ/Gq7cUVrCB2eq7MnWggQ9+iwncev2k8UACkBPwA3r9CuevbWEzjcxSUOAtTv
	/WMLbPKmwD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 671D47BE7;
	Sun, 26 Feb 2012 19:01:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF6D37BE6; Sun, 26 Feb 2012
 19:01:10 -0500 (EST)
In-Reply-To: <1330144282-22540-1-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Fri, 24 Feb 2012 23:31:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 281A57BA-60D6-11E1-9FEE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191585>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> This prevents a shell error complaining rebase-merge/rewritten doesn't exist.

Yeah, the updated logic overall makes more sense, too.  "when we have
rewritten, then we do these two things" is clear from the text.

Thanks.
