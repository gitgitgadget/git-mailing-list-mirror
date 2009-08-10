From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: A tiny documentation patch
Date: Mon, 10 Aug 2009 16:59:27 +0200
Message-ID: <200908101659.28291.trast@student.ethz.ch>
References: <20090810144419.GB24183@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:00:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWME-00035T-BD
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbZHJPAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 11:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbZHJPAG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:00:06 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:8314 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbZHJPAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 11:00:05 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 10 Aug
 2009 17:00:03 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 10 Aug
 2009 16:59:41 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090810144419.GB24183@headley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125454>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
> here's the patch.

Please read Documentation/SubmittingPatches.  In particular, you
should send your patch inline (git-send-email can help) and add a
Signed-off-by.

> I noticed a few typos in the git-remote manpage
[...]
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.=
txt
[...]
> -In mirror mode, enabled with `\--mirror`, the refs will not be store=
d
> +In mirror mode, enabled with `--mirror`, the refs will not be stored
[...]
> -mode, furthermore, `git push` will always behave as if `\--mirror`
> +mode, furthermore, `git push` will always behave as if `--mirror`

While I'm not sure how far back you'd have to go to find an asciidoc
that does need this escaping, it's definitely *not* a typo.  In some
instances, -- turns into em dashes.

If you are seeing stray backslashes in the output (I don't), I suspect
you are either running asciidoc 8.x but forgot to set ASCIIDOC8, or
8.4.1+ and are missing the patch 71c020c (Disable asciidoc 8.4.1+
semantics for `{plus}` and friends, 2009-07-25).

> -With `--dry-run` option, report what branches will be pruned, but do=
 no
> +With `--dry-run` option, report what branches will be pruned, but do=
 not
>  actually prune them.

Ok.

>  remotes.<group>.  If a named group is not specified on the command l=
ine,
> -the configuration parameter remotes.default will get used; if
> +the configuration parameter remotes.default will be used; if

Ok.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
