From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/6] revisions: split the pure option parsing out from
 parse_revisions.
Date: Tue, 08 Jul 2008 12:51:13 +0200
Message-ID: <487346A1.4040006@viscovery.net>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org> <1215510964-16664-2-git-send-email-madcoder@debian.org> <1215510964-16664-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 12:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGAo0-0006s7-9K
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 12:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbYGHKvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 06:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbYGHKvU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:51:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19053 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130AbYGHKvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:51:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KGAmv-0003c5-FN; Tue, 08 Jul 2008 12:51:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1603F4FB; Tue,  8 Jul 2008 12:51:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1215510964-16664-3-git-send-email-madcoder@debian.org>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87745>

Pierre Habouzit schrieb:
> +int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
> +			int *unkc, const char **unkv)
> +{
> +	const char *arg = argv[0];
> +
> +	/* pseudo revision arguments */
> +	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
> +	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
> +	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
> +	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
> +	{
> +		unkv[*unkc++] = arg;

+		unkv[(*unkc)++] = arg;

Hm?

-- Hannes
