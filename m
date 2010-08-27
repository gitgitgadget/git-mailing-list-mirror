From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/8] Make rev-list --objects work with pathspecs; minor
 optimizations
Date: Fri, 27 Aug 2010 10:28:24 -0700
Message-ID: <7vr5hkhsnb.fsf@alter.siamese.dyndns.org>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 19:28:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2jN-0001AX-R1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab0H0R2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 13:28:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab0H0R2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 13:28:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC0AD0181;
	Fri, 27 Aug 2010 13:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iMYURt9uhXzWkr9ZRDQMP83UXYg=; b=yIaCAQ2x95DUXun+Mw6i2WT
	YHa1aSiDUkH7h2u1Ok1cwaUeDPlR/ceLpmr+/v2AIVYR+BWRzblVxdUJVdhnvGJP
	gJixG6aBfuHBxcP/nvrJfwYmfa5Q+tdhg3ZCKh/yFp/mjmeuLSUKwWKIsGpvUbvA
	PExhrw1f/89eCWp2aevc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hZV+2hgGEil57f5xtRReY3HycEfKw1nd7Yqi53/AXYu4C0x8M
	lHAOWTgneX2eJRLTHQEid0JSK0gqdx49W3SZ4S5iiqPEX7uR8ZAVNDP4GwLnWDC1
	Ks1u/pMbLJpB00Y0HSsoBZy1ERjIOFaiaRiPsw0WG4LXDnM5w11rrByW8g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C42FD017F;
	Fri, 27 Aug 2010 13:28:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50133D017A; Fri, 27 Aug
 2010 13:28:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 824D0B14-B200-11DF-9F54-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154606>

Elijah Newren <newren@gmail.com> writes:

> This series enables rev-list to produce a list of objects that is path
> limited, when the user requests it.  It also provides a few small code
> cleanups and some small optimizations.

A cursory look didn't spot anything glaringly wrong ;-)

I'd split 3-6 into a separate "tree-walk-optim" topic and keep the first
two as "object-list-with-pathspec" topic.  They really look independent.

Thanks.
