From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] commit: match explicit-ident semantics for summary and template
Date: Sun, 17 Jan 2010 21:53:44 +0100
Message-ID: <201001172153.44413.j6t@kdbg.org>
References: <20100117193401.GA28448@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 21:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWc94-0003UI-A5
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 21:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab0AQUyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 15:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214Ab0AQUyq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 15:54:46 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:16657 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751506Ab0AQUyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 15:54:45 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2BE62A7EB2;
	Sun, 17 Jan 2010 21:54:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 788A219F60D;
	Sun, 17 Jan 2010 21:53:44 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20100117193401.GA28448@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137320>

On Sonntag, 17. Januar 2010, Jeff King wrote:
> -	if (!user_ident_explicitly_given) {
> +	if (user_ident_explicitly_given != IDENT_ALL_GIVEN) {
>  		strbuf_addstr(&format, "\n Committer: ");

Sorry for chiming in so late, but this new condition worries me a bit. On all 
of my machines I have the GECOS field filled in with "Johannes Sixt", i.e., I 
do not need user.name. But of course the automatically derived email address 
is nonsense, so I've set up only user.email. Now I would always this hint, 
wouldn't I? Do most others fill in GECOS in ways that are inappropriate for 
git?

-- Hannes
