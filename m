From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] transport-helper: fix typo in error message when --signed is not supported
Date: Thu, 12 Feb 2015 12:34:51 -0800
Message-ID: <xmqqh9uqrhqs.fsf@gitster.dls.corp.google.com>
References: <1423735801-11108-1-git-send-email-mh@glandium.org>
	<1423735801-11108-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:35:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0Td-0004D5-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbBLUez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:34:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752086AbbBLUey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:34:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81763374C2;
	Thu, 12 Feb 2015 15:34:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p4MCNlGR8sL4rL8ROu6P9E3EXw4=; b=oPVtKY
	JRTO1F+KGha/TT8wjdzscRpBjK36rGiG4m7FLU8BwL4jS7V6S0JGGcwTjoE1/ryJ
	xisWxSDYTse1pYmtdh3n7lSSw7Zs+1DtVpRQRCUbKqcDDF+9YdG/yPVhu/yn3XG2
	tqxhuCg7hVNkHYZlbm1I9DMff68XiMcftEuMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tpoA8ntwT0S522DFzbnKvJUBDsMLD5jY
	l8jhkVMuW6ETS1tg3rL/Mhncb4v95vB+YHAlU3t5vKJ1RY1c/B75ipoKO9AvUZQb
	O8AHTWG3WaUY9aJj6Vws8FzVw8/PGRhVxkVYrYtlYkmdod7MkBcBP8yMOUX6hnAB
	S0GIQrY5zTA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7974E374C1;
	Thu, 12 Feb 2015 15:34:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D517D374BF;
	Thu, 12 Feb 2015 15:34:52 -0500 (EST)
In-Reply-To: <1423735801-11108-3-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Thu, 12 Feb 2015 19:10:01 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99223278-B2F6-11E4-A4A2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263767>

Good eyes.

This one is a straight-forward bugfix for 0ea47f9d (signed push:
teach smart-HTTP to pass "git push --signed" around, 2014-09-15);
will queue directly to jc/push-cert branch and will merge to
maintenance tracks independent from the other two.

Thanks.
