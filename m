From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sun, 01 May 2011 11:34:41 -0700
Message-ID: <7vfwoys20u.fsf@alter.siamese.dyndns.org>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net> <7vfwp1yqnq.fsf@alter.siamese.dyndns.org> <1304238652.9638.1446946253@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 01 20:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGbTr-0007NB-6I
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 20:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761325Ab1EASet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 14:34:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761286Ab1EASet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 14:34:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C4F3E4E9B;
	Sun,  1 May 2011 14:36:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GVTz56PyeNwcp1FQ0e9JotxIKbM=; b=HMTk8kWeVY8IBZ0wU2i+
	iploMJ0hPCRAgJymu+gKwwiiZ1NI/pTHo4RTz9UzrWQHMjZljziRg8hJnxi05Mqv
	F9q+AZLSUYLFZBIQZC5TbLzLQMVjUUepZFsPBHDjfFKeetZyiNj7yA1bu7uYb8Us
	WNE0Tmcvhd/Y8fwQb0YSBjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pH5BC7auH0uMuwURZTIrdtzIgkllFsq4cAzVlkSJCYa7w9
	5xuypN5lF7jgBXiHOMmWHg9y57hQfj8A/Nf2+RdMbBdAONDT6JitY8pJ5TjBCA0Y
	HbDfzF81VClaZU3SxXQO5BUzryCacuA0f97AC2O1LerrRdQ319x4tTFJ49NTQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FD804E98;
	Sun,  1 May 2011 14:36:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA3BA4E8C; Sun,  1 May 2011
 14:36:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9DB1D5E-7421-11E0-AF39-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172542>

"Michael J Gruber" <git@drmicha.warpmail.net> writes:

> I meant "rebase -i", sorry. And in fact I mostly mean those cases where
> I want to "amend" a commit which is not the top most one.

I also see myself getting tempted to say "rebase -i -2" every once in a
while; it seems to go well with "log -2" especially when the history is
linear.
