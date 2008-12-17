From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Wed, 17 Dec 2008 14:02:33 -0800
Message-ID: <7viqpijw92.fsf@gitster.siamese.dyndns.org>
References: <20081216005658.GB3679@coredump.intra.peff.net>
 <8763lixyps.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Wed Dec 17 23:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4Up-0001Yo-6J
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbYLQWCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYLQWCk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:02:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYLQWCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:02:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3453B1A828;
	Wed, 17 Dec 2008 17:02:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 123771A807; Wed,
 17 Dec 2008 17:02:35 -0500 (EST)
In-Reply-To: <8763lixyps.fsf_-_@jidanni.org> (jidanni@jidanni.org's message
 of "Thu, 18 Dec 2008 05:45:35 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B7CFF04-CC86-11DD-B7CE-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103399>

jidanni@jidanni.org writes:

> I mean here I am in emacs, and
>
> -*- mode: compilation; default-directory: "...coreutils/" -*-
> Compilation started at Thu Dec 18 03:15:14
> git-diff
> WARNING: terminal is not fully functional^M
> ^M-  (press RETURN)

Any semi-good emacs users (let alone hackers) export PAGER=cat to be used
in compilation mode (and possibly shell mode), so this is not a problem in
practice.

I have something like this in my .emacs:

    (setenv "PAGER" "cat")

I suspect (I am just a user not a hacker) this will have bad interaction
with emacs terminal emulation mode, but I do not use the mode, so it is
enough for me.
