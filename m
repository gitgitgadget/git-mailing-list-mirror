From: Junio C Hamano <gitster@pobox.com>
Subject: Re: History for Strbuf and ParseOpts?
Date: Sun, 17 Apr 2011 11:51:08 -0700
Message-ID: <7vtydwaezn.fsf@alter.siamese.dyndns.org>
References: <BANLkTimg-a-k8wR-gotEYUQ+C3LcwsBGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:51:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBX46-0007yP-T7
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 20:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab1DQSvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 14:51:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab1DQSvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 14:51:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9724A5D32;
	Sun, 17 Apr 2011 14:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N6S3PnQLv2DGwv17H1XTI5Jr/FQ=; b=dqRH5R
	rYm4KO7HyGE8wv3AwoMXPF9CA/WU02lvbHBRd9AlNqgs39V4CgacSlUkMXuBZJnP
	jcuSJVxcRR4nktsotnM/prMMeJtXnJsH9t4dWxDh5/eFO0MKbjtvi+2VLl9F47te
	hsOluc9DWcy5vg5vT/P9MQ75pld6pliKWYZ18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HAqE0OiXfH6VnbqBHEXCfo9ozw4VudhZ
	GKEjMgBhPtY6Nor/ZYuUY0D53ufYyj+uQsUEdFnMwJ/z+vV/ra+7lBWPVp6zrzYp
	zycaKb1b/8YuB1Xb0QlKbaYpgVrVmf3AaN0qfV1wcD5M8ez9udqc/GO8elTUGvyh
	sE96rXtCyfc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 762A75D31;
	Sun, 17 Apr 2011 14:53:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B46A5D30; Sun, 17 Apr 2011
 14:53:10 -0400 (EDT)
In-Reply-To: <BANLkTimg-a-k8wR-gotEYUQ+C3LcwsBGuw@mail.gmail.com> (David
 Chanters's message of "Sun, 17 Apr 2011 16:13:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F27AD4D6-6923-11E0-9DEF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171728>

David Chanters <david.chanters@googlemail.com> writes:

> I shouldn't conflate to two (parseopts and strbuf) but can someone
> tell me how these two things came about -- that is, when/why/how?

I do this sort of digging fairly often.

I am not going to do this particular one myself, but the general procedure
is to first run "git log --diff-filter=A strbuf.[ch] parse-options.[ch]"
to find which commits introduced them (hence, learn who did it, when and
why), then go back to the list archive to find the discussions that lead
to these changes.
