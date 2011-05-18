From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] Add log.abbrevCommit config variable
Date: Wed, 18 May 2011 11:52:55 -0700
Message-ID: <7v39kbdens.fsf@alter.siamese.dyndns.org>
References: <1305741364-28286-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 20:53:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMlrq-0003UT-VF
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 20:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933549Ab1ERSxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 14:53:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933538Ab1ERSxC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 14:53:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FD075CCC;
	Wed, 18 May 2011 14:55:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=80b3M/hw5EDDPUam6vtoyZS1Qis=; b=Yr/C4x
	daLSGWfw+z6CsSgPRR7I8hF2tUHaYs9n/XbsJLIgsORIIjou1BH97Wr72PTg6FZ8
	/YGwJWskEAF6w+y9lVmYciv6XKaXpsn8rM/CqHzq4GNsSZyyoV0mIIO9beniZ4jN
	duXhAwcTZ8JzUZjgyqt3magnRkDebGRBeBoHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZq4RKAYx5tGcOZR/X47z1z8mtdERvZe
	JZsY/jnOuHJ95TsccqWgeHSPvvsPL+Rz5X3FHvQk0VmP2gNOeL+cGW1RcXEz658v
	GEbGVGO6FdRCRcQ+BT+NXY49hIc4HDiWLgt6wv+nhIbXhL3qVvEhU6W4XHaFYd3Z
	dx7+CZAHIaQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BBBA5CC6;
	Wed, 18 May 2011 14:55:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 521D25CC5; Wed, 18 May 2011
 14:55:03 -0400 (EDT)
In-Reply-To: <1305741364-28286-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Wed, 18 May 2011 13:56:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 589130F2-8180-11E0-B5B7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173895>

Jay Soffian <jaysoffian@gmail.com> writes:

> +test_expect_success 'log.abbrevCommit configuration' '
> +	test_when_finished "git config --unset log.abbrevCommit" &&
> + ...
> +	test_cmp expect.whatchanged.full actual
>  '

This one now very nicely groups the commands, and far easier to see.
Will queue; thanks.
