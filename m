From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/(3/4)] test: does pre-commit-hook learn authorship?
Date: Sun, 11 Mar 2012 21:30:08 +0100
Message-ID: <4F5D0B50.20803@kdbg.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com> <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org> <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org> <7v1uozz97f.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:30:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6pPJ-00010Z-8P
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 21:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab2CKUaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 16:30:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:22755 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751394Ab2CKUaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 16:30:15 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 63ADA13004D;
	Sun, 11 Mar 2012 21:30:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5A7B819F68B;
	Sun, 11 Mar 2012 21:30:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v1uozz97f.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192826>

Am 11.03.2012 12:08, schrieb Junio C Hamano:
> +test_expect_failure 'check the author in hook' '
> +	cat >"$HOOK" <<-\EOF &&
> +	test "$GIT_AUTHOR_NAME" = "New Author" &&
> +	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
> +	EOF

Please insert #!/bin/sh as the first line of the script. We'll need it
on Windows.

-- Hannes
