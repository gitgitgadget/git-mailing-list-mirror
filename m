From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: unpack-trees: avoid substituting only a verb in sentences
Date: Thu, 12 May 2016 16:30:50 -0700
Message-ID: <xmqqk2iyc0r9.fsf@gitster.mtv.corp.google.com>
References: <xmqqy47ec2n2.fsf@gitster.mtv.corp.google.com>
	<1463094986-7344-1-git-send-email-vascomalmeida@sapo.pt>
	<xmqqoa8ac0v1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 13 01:31:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b104I-0004Pw-7f
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 01:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcELXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 19:30:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbcELXay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 19:30:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D0FBD1B9D7;
	Thu, 12 May 2016 19:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zzExGlKn/Xq7gmzrQXKIrH0yFO0=; b=BAJxs7
	hI8coFUJDeP+oCgF+t+O1xCS4St4QJAzx/GDHArd0BWCgLk6P7HalDn2enmg6GGq
	yz20Pp7Jx0A1DKMFrdlHNHkilCth86uhTJi/Q0ejPRiK8390AAgyU32fLqJx2/Wp
	kjijXDa7fQ82uh9QDeTuZ4Eeduhdlpq4NEA44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a5AM0KHOoWuWLspkbQPG6CtRPPxqI37v
	ManT9VtTTaqA0NSzISbe1Hn5YaqI1FtL4D3RjJDSwLFd7PbWcsuPypk6lXfXFEwQ
	UFNPf4Pl1Xxt24Y5gQUvwYNPr+s4hNdAzUvIyXPoB9C83TOuGs038frfTExNwZTU
	bSC+HMC9gcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C6D3C1B9D6;
	Thu, 12 May 2016 19:30:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 399B51B9D5;
	Thu, 12 May 2016 19:30:52 -0400 (EDT)
In-Reply-To: <xmqqoa8ac0v1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 May 2016 16:28:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90F63B30-1899-11E6-8B9B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294491>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  I think we should squash the following in, as all these
> messages are now i18ned and without being marked with test_i18ncmp,
> GETTEXT_POISON build would fail to pass these tests.

... this was not a request for you to re-send your patch with the
update to the test.  I'll just squash it in.

Thanks for the i18n updates.
