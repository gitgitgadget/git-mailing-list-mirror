From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] mergetool--lib: simplify command expressions
Date: Tue, 29 Jan 2013 23:04:08 -0800
Message-ID: <7vobg7m9sn.fsf@alter.siamese.dyndns.org>
References: <7vip6foc9m.fsf@alter.siamese.dyndns.org>
 <1359526854-25132-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:04:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Rik-0001Kj-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab3A3HEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:04:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab3A3HEL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:04:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CB088E1;
	Wed, 30 Jan 2013 02:04:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xuz+9cnXyIadh97wInX8WcePloY=; b=dqUnao
	KyqrfAoetrpYtKMQj5HF0MOR1t4tQP0rzT5Bajeh0cvMZEl3YnLLpRDc5XmsoeEf
	6CmW10j9AAlOHvYg6eCSM6Mt3EYo/lgfsSEaBXwpLj4vNl3mqidCujmGjQmUuGan
	IXO5Yu6e3gxNiI4IoudMI1Zvrn5j9fNlS6UO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y7Vl6H5JWgN4c0awa37P1ecIz4GDUhPm
	W8pv/YXpoG3+Zga33cIKREddi2lwI8E8kAh6sEz6yysNgC92yOrmFTFUFZTqhkDu
	kzQvc52ZPxl4hXh/4d0hG6ntikSM1w5assGYJGvH6/7E/fwNXYVDZ+RRZZF1TJZ3
	zJ7cAlFGXoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19C3588E0;
	Wed, 30 Jan 2013 02:04:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CC2E88DE; Wed, 30 Jan 2013
 02:04:09 -0500 (EST)
In-Reply-To: <1359526854-25132-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Tue, 29 Jan 2013 22:20:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E8BFAF0-6AAB-11E2-9C62-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214997>

David Aguilar <davvid@gmail.com> writes:

> Update variable assignments to always use $(command "$arg")
> in their RHS instead of "$(command "$arg")" as the latter
> is harder to read.  Make get_merge_tool_cmd() simpler by
> avoiding "echo" and $(command) substitutions completely.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is a replacement patch for what's currently in pu to
> fix the empty "test -z" expression.

Thanks.

I think I already pushed out what I locally amended; will double
check.
