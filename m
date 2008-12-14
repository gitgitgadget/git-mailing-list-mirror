From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added EXIT STATUS section in git-status documentation
Date: Sun, 14 Dec 2008 15:29:30 -0800
Message-ID: <7vljui1gkl.fsf@gitster.siamese.dyndns.org>
References: <200812150012.14071.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: nadim khemir <nadim@khemir.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 00:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0QI-00005m-Nj
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYLNX3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYLNX3g
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:29:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYLNX3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:29:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A16787497;
	Sun, 14 Dec 2008 18:29:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB40387496; Sun,
 14 Dec 2008 18:29:31 -0500 (EST)
In-Reply-To: <200812150012.14071.nadim@khemir.net> (nadim khemir's message of
 "Mon, 15 Dec 2008 00:12:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10D7253A-CA37-11DD-A5AE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103106>

nadim khemir <nadim@khemir.net> writes:

> +EXIT STATUS
> +-----------
> +The command exits with status 0 if there is a different between the index
> +and HEAD. IE, running `git commit`, with the same arguments as your
> +'git status' command, would create a new commit.
> +

Wording: s/different/difference/

But more importantly, even if there is no difference between the index and
HEAD, "git status -a" would say "Ok, you will commit something" if you
have modifications to (or removals of) tracked paths.  The description in
the original you removed was Ok only because it does not talk anything
about giving parameters to "git status", but now you are mentioning that
case as well, you would need to adjust the description.
