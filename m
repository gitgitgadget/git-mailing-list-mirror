From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/31] rebase -i: support --stat
Date: Tue, 28 Dec 2010 18:59:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1012281858300.1794@bonsai2>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-17-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 18:59:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXdq0-00007M-Js
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 18:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab0L1R7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 12:59:51 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:35409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754305Ab0L1R7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 12:59:51 -0500
Received: (qmail invoked by alias); 28 Dec 2010 17:59:47 -0000
Received: from ppp-88-217-111-31.dynamic.mnet-online.de (EHLO noname) [88.217.111.31]
  by mail.gmx.net (mp045) with SMTP; 28 Dec 2010 18:59:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/f1mxkzqzfNkJNtZFXrprhhna4qsepJ5SkRiLM2o
	BphcWoaCV9I4DQ
X-X-Sender: gene099@bonsai2
In-Reply-To: <1293528648-21873-17-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164281>

Hi,

On Tue, 28 Dec 2010, Martin von Zweigbergk wrote:

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 229e8d2..0fc580a 100755

Hmpf... After a rebasing merge to junio/next:

-- snip --
[...]
Applying: rebase -i: support --stat
fatal: sha1 information is lacking or useless (git-rebase.sh).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
[...]
-- snap --

Is this supposed to apply on top of junio/master, junio/next, junio/maint?

Ciao,
Dscho
