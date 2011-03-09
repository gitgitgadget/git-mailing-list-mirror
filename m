From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] A couple of tweaks in git-for-each-ref.txt
Date: Wed, 09 Mar 2011 11:54:33 -0800
Message-ID: <7vtyfc9iiu.fsf@alter.siamese.dyndns.org>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxPT4-0000ev-MA
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab1CITyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:54:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1CITyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:54:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64BA838B3;
	Wed,  9 Mar 2011 14:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MWAFqfMbzhT1qb6vEwkWa+Ce64A=; b=hwNNOc
	2Q/J6qBSWPgubecT+iREwkCuX3UD+4nsmC7A9AvfYEtGqO94s/KNSm3vMJc59gaY
	+QR7gUHhEseBG08WxKnyxFAd5KR3GyATVCCTUjAx2ZKsd7OpmmPHgm1nELiG0m0a
	UC1185xWpklUA+XV/fA1vIj45DLuQWI0dOL4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mEIw+YXhp/mefJOi0caBG9NULGewTDbO
	OizW86WBY6ILk0dd5eIfQlSbtai8BlnF4IheSREXZxAOLLxChRuDBrpPY9NWD2x4
	g5RY4i2FBkbQd+Xgp31VJqtoQZ6KmJ3lT67KxLBJ26XkTXXzqYU8KNyuCMOOoX07
	xIRs4eHahDI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E11838B1;
	Wed,  9 Mar 2011 14:56:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C98438B0; Wed,  9 Mar 2011
 14:56:03 -0500 (EST)
In-Reply-To: <1299590170-30799-1-git-send-email-alcosholik@gmail.com> (Alexei
 Sholik's message of "Tue, 8 Mar 2011 15:16:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 451D4374-4A87-11E0-9445-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168750>

Alexei Sholik <alcosholik@gmail.com> writes:

> I was reading the man page on git-for-each-ref and noticed a few bugs
> and missing Authors and Documentation sections.

I actually wanted to propose dropping the "authors" and "documentation by"
sections from all the pages a few years ago, but didn't push it very far.
Your patch moves things the other direction, but the result becomes more
consistent, so it is a good change nevertheless.

Thanks.
