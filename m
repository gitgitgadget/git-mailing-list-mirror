From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag -s: TAG_EDITMSG should not be deleted upon failures
Date: Sat, 06 Dec 2008 15:00:30 -0800
Message-ID: <7vzlj8vrht.fsf@gitster.siamese.dyndns.org>
References: <4936AB74.3090901@jaeger.mine.nu>
 <20081206194034.GA18418@coredump.intra.peff.net>
 <7v8wqtvvql.fsf@gitster.siamese.dyndns.org>
 <20081206215400.GA29440@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 07 00:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L96B4-0002Yg-Oe
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 00:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbYLFXAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 18:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbYLFXAm
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 18:00:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYLFXAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 18:00:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 65F3E18437;
	Sat,  6 Dec 2008 18:00:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F38A18430; Sat, 
 6 Dec 2008 18:00:32 -0500 (EST)
In-Reply-To: <20081206215400.GA29440@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 6 Dec 2008 16:54:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B21D7092-C3E9-11DD-A5ED-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102482>

Jeff King <peff@peff.net> writes:

> Much better, though the message is a bit awkward. How about
>
>   "The tag message has been left in %s"
>
> ?
>
> Do you want me to resend, or do you want to fix up locally?

I'll squash these two plus your wording fix (with trailing LF) in to your
original patch.  Thanks.
