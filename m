From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Mon, 05 Apr 2010 14:10:58 +0900
Message-ID: <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
	<1270392557-26538-1-git-send-email-avarab@gmail.com>
	<20100404224324.GB12655@gmail.com>
	<y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
	<7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 07:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyeb9-0000V9-LB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 07:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab0DEFLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 01:11:35 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:35420 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab0DEFLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 01:11:33 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o355AxNp022381;
	Mon, 5 Apr 2010 14:10:59 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.40] [10.29.19.40]) by relay11.aps.necel.com with ESMTP; Mon, 5 Apr 2010 14:10:59 +0900
Received: from dhlpc061 ([10.114.112.73] [10.114.112.73]) by relay21.aps.necel.com with ESMTP; Mon, 5 Apr 2010 14:10:59 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6F95152E1FD; Mon,  5 Apr 2010 14:10:59 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7vy6h2wsvg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 04 Apr 2010 19:11:31 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143968>

Junio C Hamano <gitster@pobox.com> writes:
> As a Porcelain, "git commit" has some leeway to enforce sensible policy on
> the users, and "forbid commit that does not explain anything" is one such
> policy.  It is not generally a good idea to expose the full capabilities
> of plumbing to Porcelain if it leads to bad user behaviour, and such
> "artificial" limitations are safety features we do not want to remove.

Isn't the requirement of using a longish option like
"--allow-empty-message" enough of a warning to users though?

Although it seems reasonable for git _discourage_ bad practices, I think
that should generally also be moderated with "... but if you _reallllly_
want to, you can do this somewhat annoying thing....".  Forcing someone
to use commit-tree, though, seems a bit much to me; an annoyingly long
option seems about right.

-Miles

-- 
Love is the difficult realization that something other than oneself is real.
[Iris Murdoch]
