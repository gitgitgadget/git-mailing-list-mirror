From: =?ISO-8859-1?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] Utilize config variable pager.stash in stash list command
Date: Tue, 16 Aug 2011 13:24:58 +0200
Message-ID: <4e4a58c2.33fdbc51.bm000@wupperonline.de>
References: <4e4a4743.4e230d8a.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 13:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtI9k-0007gk-9G
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 13:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab1HPLt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 07:49:56 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:44164 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab1HPLt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 07:49:56 -0400
Received: from point.localnet (mue-88-130-93-036.dsl.tropolys.de [88.130.93.36])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 8D68E11E365E
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 13:49:53 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QtI9Y-6Cz-00 for <git@vger.kernel.org>; Tue, 16 Aug 2011 13:49:52 +0200
In-Reply-To: <4e4a4743.4e230d8a.bm000@wupperonline.de>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179438>

I wrote on Tue, 16 Aug 2011 12:10:45 +0200:

> Actually, I only wanted to change the stash list behavior (but better
> should have used $(git config --get pager.stash.list) for that).
> Unfortunately, it is impossible then to force the pager with --paginate
> again.

Actually, it *is* possible to force the pager with --paginate again, so this
is exactly what I was trying to achieve (only using pager.stash.list now).

Ingo
