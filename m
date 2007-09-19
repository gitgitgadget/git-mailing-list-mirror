From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Further strbuf re-engineering.
Date: Wed, 19 Sep 2007 01:05:55 -0700
Message-ID: <7vabrjqduk.fsf@gitster.siamese.dyndns.org>
References: <20070905085720.GD31750@artemis.corp>
	<11890199232110-git-send-email-madcoder@debian.org>
	<11890199232128-git-send-email-madcoder@debian.org>
	<11890199232646-git-send-email-madcoder@debian.org>
	<1189019923740-git-send-email-madcoder@debian.org>
	<11890199233357-git-send-email-madcoder@debian.org>
	<1189019923943-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuZX-0004Gg-Jt
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbXISIGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXISIGG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:06:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbXISIGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:06:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B4FA137DC0;
	Wed, 19 Sep 2007 04:06:21 -0400 (EDT)
In-Reply-To: <1189019923943-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 5 Sep 2007 21:18:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58685>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-apply.c       |   29 ++++++-----------------
>  builtin-blame.c       |   34 +++++++++-------------------
>  builtin-commit-tree.c |   59 ++++++++++--------------------------------------
>  diff.c                |   25 ++++++--------------
>  4 files changed, 40 insertions(+), 107 deletions(-)
> ...
> diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
> index ccbcbe3..ee74814 100644
> --- a/builtin-commit-tree.c
> +++ b/builtin-commit-tree.c
> @@ -8,42 +8,13 @@
> ...
>  /*
>   * FIXME! Share the code with "write-tree.c"
>   */

You fixed it.  Remove this comment.
