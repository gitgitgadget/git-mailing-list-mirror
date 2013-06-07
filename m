From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] build: generate test scripts
Date: Fri, 07 Jun 2013 16:12:17 -0700
Message-ID: <7vobbhqzvy.fsf@alter.siamese.dyndns.org>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
	<1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
	<7v1u8dsghd.fsf@alter.siamese.dyndns.org>
	<CAMP44s2N7AjpyK325FK5zWMnO4oausF3xiNmcfoqvNtxJ7DUEg@mail.gmail.com>
	<7vtxl9r1df.fsf@alter.siamese.dyndns.org>
	<CAMP44s3doQe2PTGSbZ7Afi9DNDGstN4VJAompeLxUjn4Cg=g2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 01:12:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5pd-0007dK-Bj
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 01:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab3FGXMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 19:12:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197Ab3FGXMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 19:12:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA6AA26F47;
	Fri,  7 Jun 2013 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YPnCb+7DnsQXVaeXWqxn5Twp398=; b=QjeNXN
	pX7KNhPc5lzk/pnXbcvlXf9/CY4r2OSRaW8RmEBnR/vZ9hie5XXWFl/BrVEPzXJg
	x74uUJCKAYDSsYKnyGbTLkqIjoCzCPMCeZQoelqa98oH+ZpEUWWxjbMDdg+MdWzM
	YPLRxiP3GWeMJT3tnrhBoPmDd07HTj6A1H06c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pQ81+wy9ka1Kq0C9Duqn3qVamCgXSQLJ
	U6Z13OP3VRqTuz4lxpdjkY+tuGhWdNBeEs7a/1UKtbsLQ6sDUOqP/Wa9sL2N+99t
	Rlqry9o5LLAKG/kFivjQmozebK78IuRSOuP1QMoT7Xhr3M1PJucb1FY1vmPK3Yh2
	n7CLtjyw5Fo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A23F926F46;
	Fri,  7 Jun 2013 23:12:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B4C626F45;
	Fri,  7 Jun 2013 23:12:19 +0000 (UTC)
In-Reply-To: <CAMP44s3doQe2PTGSbZ7Afi9DNDGstN4VJAompeLxUjn4Cg=g2Q@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 7 Jun 2013 17:43:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B38601D0-CFC7-11E2-88DC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226764>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It is generated, in next. If it's not generated, there's no need to
> add it to NO_INSTALL.

OK, that makes sense.
Thanks.
