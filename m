From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Thu, 11 Nov 2010 11:41:33 +0100
Message-ID: <201011111141.33623.trast@student.ethz.ch>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com> <AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com> <AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 11:41:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGUbA-00029P-1W
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 11:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab0KKKlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 05:41:39 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:45916 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab0KKKli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 05:41:38 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 11 Nov
 2010 11:41:36 +0100
Received: from pctrast.inf.ethz.ch (129.132.208.172) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 11 Nov
 2010 11:41:37 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
X-Originating-IP: [129.132.208.172]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161222>

Martin von Zweigbergk wrote:
> Btw, why is the default (if no strategy is specifed) for 'git rebase' to
> use 'recursive', while for 'git merge' "a built-in list of strategies is
> used instead (git merge-recursive when merging a single head, git
> merge-octopus otherwise)"?

Because rebase does a tree-level merge, so it never attempts to merge
than one branch, so octopus never enters the picture.

Sorry for the original breakage; while it has Mike Lundy assigned as
author, I resurrected and resubmitted his patch and should have
noticed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
