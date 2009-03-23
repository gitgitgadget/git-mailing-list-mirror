From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP 0/2] Documentation clean-up: git commands
Date: Mon, 23 Mar 2009 09:22:33 -0700
Message-ID: <7vwsag5hva.fsf@gitster.siamese.dyndns.org>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:24:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llmwq-0006Qd-A9
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbZCWQWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbZCWQWl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:22:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbZCWQWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:22:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 54013A4836;
	Mon, 23 Mar 2009 12:22:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 569CEA4835; Mon,
 23 Mar 2009 12:22:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D3458724-17C6-11DE-93C0-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114329>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> - Do we want it this way (`git command`)?

That's my personal preference but other people may differ; wasn't there an
issue with "man" backend losing the typesetting information?

> - How to prepare: 1 patch per file/per 5 files/per 50 changes?
> - How to submit: single patch once ready or whole series at end (5 years
>   from now)?
> - How to send: Bother the list or send pull requests only?

How about a fork of git.git on repo.or.cz that branches from 1.6.2 and that:

 - does not pull from git.git/master unless absoletely necessary; and
 - contains only these clean-up changes and nothing else?

A bonus point would be for a publically reachable pages rendered out of
the tip of this "documentation updates" repository, so that people can
view it, compare it with www.kernel.org/pub/software/git/docs/.

I would love to have a separate "documentation maintainer" in the longer
run, and it would be great if your tree becomes it.  I can start pulling
from you, forwarding any documentation patches your way.

Thanks.
