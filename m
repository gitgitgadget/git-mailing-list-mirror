From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: obstack fails to compile on OS X 10.7
Date: Sat, 27 Aug 2011 23:57:20 -0400
Message-ID: <D1DD3049-6ADC-45AC-A8B2-BCE95124E6E7@gernhardtsoftware.com>
References: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com> <20110827101418.GA8074@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Fredrik Kuivinen <frekui@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 06:05:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxWcT-00038H-4z
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 06:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1H1D52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 23:57:28 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38987 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab1H1D50 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2011 23:57:26 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 657CD1FFC166; Sun, 28 Aug 2011 03:57:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 465071FFC0EE;
	Sun, 28 Aug 2011 03:57:14 +0000 (UTC)
In-Reply-To: <20110827101418.GA8074@gmail.com>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180253>


On Aug 27, 2011, at 6:14 AM, David Aguilar wrote:

> This fixes it for me, but we might want to rearrange the
> #includes a bit.  I think this needs more work.. including
> compat/obstack.h from kwset.c seems wrong.
> Should we just include obstack.h in git-compat-util instead?

If obstack.h is only used in kwset, I don't see a problem with it.

> -- 8< --
> Subject: [RFC PATCH] obstack: Fix portability issues

This patch does solve my compile problem.  Now to track down test failures (unrelated to this issue, I'm very sure).

~~ B