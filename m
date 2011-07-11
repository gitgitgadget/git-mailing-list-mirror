From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git remote show origin (URL)
Date: Mon, 11 Jul 2011 19:26:38 +0200
Message-ID: <m239ic3f01.fsf@igel.home>
References: <1310400505376-6571492.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: frankkany <frankkany@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKFq-0007jm-Q7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233Ab1GKR0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:26:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34443 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007Ab1GKR0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:26:41 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id AE2971C01CC0;
	Mon, 11 Jul 2011 19:26:39 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A8B451C0009A;
	Mon, 11 Jul 2011 19:26:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id SfrcwbkfxzEq; Mon, 11 Jul 2011 19:26:39 +0200 (CEST)
Received: from igel.home (ppp-93-104-147-117.dynamic.mnet-online.de [93.104.147.117])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 11 Jul 2011 19:26:39 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C0644CA293; Mon, 11 Jul 2011 19:26:38 +0200 (CEST)
X-Yow: Go on, EMOTE!  I was RAISED on thought balloons!!
In-Reply-To: <1310400505376-6571492.post@n2.nabble.com> (frankkany@gmail.com's
	message of "Mon, 11 Jul 2011 09:08:25 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176876>

frankkany <frankkany@gmail.com> writes:

> On box (B), when using "git remote show origin" on an unfamiliar project,
> the FETCH/PUSH URL is: "hidden-repos:repositories/mysteryproject.git".
>
> How can I find where the actual url/directory where "hidden-repos" is
> pointing?

That should be the actual repository address, where hidden-repos should
be the host name, implicitly using git+ssh as the transport.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
