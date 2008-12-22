From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Mon, 22 Dec 2008 00:30:44 -0800
Message-ID: <7vfxkgk3wr.fsf@gitster.siamese.dyndns.org>
References: <20081216005658.GB3679@coredump.intra.peff.net>
 <8763lixyps.fsf_-_@jidanni.org> <buo3aggyjmy.fsf@dhapc248.dev.necel.com>
 <494F47E1.8070105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 22 09:39:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEgJX-0003oE-Ti
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 09:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYLVIbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 03:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbYLVIbD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 03:31:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYLVIbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 03:31:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D01271AD76;
	Mon, 22 Dec 2008 03:30:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DAE511AD5B; Mon,
 22 Dec 2008 03:30:52 -0500 (EST)
In-Reply-To: <494F47E1.8070105@viscovery.net> (Johannes Sixt's message of
 "Mon, 22 Dec 2008 08:55:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC78C182-D002-11DD-8264-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103748>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Miles Bader schrieb:
>> Just (setenv "PAGER" "cat") in .emacs.
>> 
>> [I actually have it set to /bin/cat, not sure if that's meaningful or not.]
>
> No, really, you should set it to plain "cat": As a special case git
> recognizes this token and does not run any pager. If you set it to
> "/bin/cat" it does run a pager, namely /bin/cat.

But that would not hurt ;-).

On the other hand, using PAGER=cat or PAGER=/bin/cat is the right thing to
do in compilation and shell modes in Emacs, regardless of your use of git.
