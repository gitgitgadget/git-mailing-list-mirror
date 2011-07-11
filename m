From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clearly specify what refs are honored by
 core.logAllRefUpdates
Date: Mon, 11 Jul 2011 14:24:26 -0700
Message-ID: <7vaackbjed.fsf@alter.siamese.dyndns.org>
References: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com> <7v7h7og1zo.fsf@alter.siamese.dyndns.org> <CAKPyHN3aef5MQh+rv4O07vrVbzziTj+==2H-hKM1XwUwCOqq6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:24:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNxz-0005fz-SM
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab1GKVYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:24:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596Ab1GKVY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:24:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4CC86A5E;
	Mon, 11 Jul 2011 17:24:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MXAEq4InIJVBZY43obZkNNLgs7I=; b=xGxb10
	AlY3F7dAb6oaQDUFutQxnC9OjtK+jgLnnwMaQFIw0eu9pwPfebzzOwNA4At+tRWy
	TpD+t5nhs/RtPISxen8AXQNT44i+XfmRWjvJEC+crnCCEGuzRoeV2mqF/+3CQRbD
	mnHRRmzStSTWPwxVSQBtJCp7XYWtMj3wEfkYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pd8ZPz4YKAltTLsdS4EJqBuDaLimHiwu
	Vx9Bz/wYS2lbujIq2ATcpRsIY0TT/hcjdiGZ9FFKfACD1GbxPwihS+akQrZAPJ+s
	5MPa65/51q19wtqb3GQ0iIE3g0PIp9mbKx3IXeIKusDXihvtlPy9/0E+fr1ei+01
	z1M4Tgeptm4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC9586A5D;
	Mon, 11 Jul 2011 17:24:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4AC436A5A; Mon, 11 Jul 2011
 17:24:28 -0400 (EDT)
In-Reply-To: <CAKPyHN3aef5MQh+rv4O07vrVbzziTj+==2H-hKM1XwUwCOqq6Q@mail.gmail.com> (Bert
 Wesarg's message of "Mon, 11 Jul 2011 20:23:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28A96CAC-AC04-11E0-8923-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176900>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> The question is: should the user be able to disable logging of the
> hard-coded values. With your examples that would be possible. But I
> think we should not allow that.

You have to justify that position. I do not see any reason to forbid
myself from declining reflog for refs/remotes/ while still logging the
updates to my refs/heads/.
