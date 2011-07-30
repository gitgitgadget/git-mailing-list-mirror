From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] Break down no-lstat() condition checks in
 verify_uptodate()
Date: Sat, 30 Jul 2011 18:22:59 +0200
Message-ID: <20110730162258.GC7545@toss.lan>
References: <1311998105-6267-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 18:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCJh-0000qm-1X
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 18:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab1G3QXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 12:23:05 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:61534 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752249Ab1G3QXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 12:23:02 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 8360310018;
	Sat, 30 Jul 2011 18:22:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311998105-6267-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178210>

On Sat, Jul 30, 2011 at 10:55:05AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> +	/*
> +	 * CE_VALID and CE_SKIP_WORKTREE cheat, we better check again
> +	 * if this entry is truely uptodate because this file may be
> +	 * overwritten.
> +	 */

s/truely/truly

> +	if ((ce->ce_flags & CE_VALID) || ce_skip_worktree(ce))
> +		; /* keep checking */
> +	else if (o->reset || ce_uptodate(ce))
>  		return 0;

Nice! Acked-by: Clemens Buchacher <drizzd@aon.at>
