From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] parse-opt: migrate builtin-merge-file.
Date: Wed, 1 Oct 2008 08:01:59 -0700
Message-ID: <20081001150159.GY21310@spearce.org>
References: <20080930224623.GQ21310@spearce.org> <1222841106-26148-1-git-send-email-madcoder@debian.org> <1222841106-26148-2-git-send-email-madcoder@debian.org> <1222841106-26148-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:03:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3EQ-0000HS-9f
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYJAPCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbYJAPCA
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:02:00 -0400
Received: from george.spearce.org ([209.20.77.23]:59604 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYJAPCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:02:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 74CFE3835F; Wed,  1 Oct 2008 15:01:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222841106-26148-3-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97229>

Pierre Habouzit <madcoder@debian.org> wrote:
> diff --git a/builtin-merge-file.c b/builtin-merge-file.c
> index 45c9853..7736fe8 100644
> --- a/builtin-merge-file.c
> +++ b/builtin-merge-file.c
> @@ -2,21 +2,44 @@
...
> +static int label_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	static int label_count = 0;
> +	const char **names = (const char **)opt->value;
> +
> +	if (label_count >= 3)
> +		return error("too many labels on the command like");

Typo on "command line".

-- 
Shawn.
