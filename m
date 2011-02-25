From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/3] git-add: make -A description clearer vs. -u
Date: Fri, 25 Feb 2011 11:04:45 -0800
Message-ID: <7vzkpk9bqq.fsf@alter.siamese.dyndns.org>
References: <cover.1298644872.git.git@drmicha.warpmail.net>
 <059f131e50675ac53d5d304a51530984e1b7b8a8.1298644872.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt2yX-0004iM-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab1BYTFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:05:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab1BYTEy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:04:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E396F4844;
	Fri, 25 Feb 2011 14:06:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kluPeQM3axWxhOo4H8yucbC0fwY=; b=cfJqgW
	qzNV6Arc3GSrACb/W7Xj/3zoq2AZUDZjO1ZP3pXd5VsIp+4IkJxxc3vEThlefQa7
	CYFRU8AUvvBfzNGLFo14XNy6uI8XiF8DFGd4/yhfVzvA810Ortg/qPKzA0rcLb9q
	/dmU71VEf9OkR3w3fbGfWE/5jwgAx0AQ2gjS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T16idGksz7FeR5XktLuFrTVmd4DKQtRU
	yvmOIkLLNYHAXM4KbapFehz3ylF2Vb3EyQNI9JaZL1ZHNyh125FDgkl9dnxILR92
	ToU5TN+2kOXK0+auDBqHTGaVhdW3FT3Di2NManrnPTSXk7LwQN4fiRU7Zrir7O/k
	QgPBV1kdqRA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD63B4841;
	Fri, 25 Feb 2011 14:06:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9FB29483F; Fri, 25 Feb 2011
 14:06:02 -0500 (EST)
In-Reply-To: <059f131e50675ac53d5d304a51530984e1b7b8a8.1298644872.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 25 Feb 2011 15\:45\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C510F82-4112-11E0-9610-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167920>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, it sounds as if "notice removal of files" distinguishes "-A"
> from "-u", and there is no mention of the worktree.
>
> But both notice the removal, and only "-A" adds changes from untracked
> files. Say so.

I think talking about "add new files" is a good change.

The "noticing of removal" was the reason that "-u" says "update" not
"add".  Your new wording for "-A" does not even hint that removal is
noticed; wouldn't it cause confusion to the end user?
