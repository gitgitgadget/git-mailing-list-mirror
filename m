From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: What changed in merge commit?
Date: Mon, 18 Jul 2011 22:39:15 +0200
Message-ID: <m24o2jfhn0.fsf@igel.home>
References: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:39:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiub5-0000H5-V0
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab1GRUjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 16:39:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35021 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab1GRUjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:39:17 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 604C91C1D9E1;
	Mon, 18 Jul 2011 22:39:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 5D0861C00089;
	Mon, 18 Jul 2011 22:39:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id U53fxCM+ZGLT; Mon, 18 Jul 2011 22:39:16 +0200 (CEST)
Received: from igel.home (ppp-88-217-110-34.dynamic.mnet-online.de [88.217.110.34])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 18 Jul 2011 22:39:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A3F82CA293; Mon, 18 Jul 2011 22:39:15 +0200 (CEST)
X-Yow: MERYL STREEP is my obstetrician!
In-Reply-To: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
	(Patrick Doyle's message of "Mon, 18 Jul 2011 12:44:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177406>

Patrick Doyle <wpdster@gmail.com> writes:

> How can I see what changed in a merge commit?

`git show -m' will show a diff for each parent. See "Diff Formatting" in
git-log(1).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
