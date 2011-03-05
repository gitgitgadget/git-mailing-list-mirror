From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Sat, 05 Mar 2011 13:57:45 +0100
Message-ID: <m2zkp9wwqe.fsf@igel.home>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
	<AANLkTimp8B5Lv15qhGOwOzh+kqOS0g3Xwvgib8vyk+m+@mail.gmail.com>
	<AANLkTinwHMULqPZSguYtJztuA4Oy6-s6Ah3_tcVVO7D9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Ruben Laguna <ruben.laguna@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 13:57:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvr3U-0002Po-CG
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 13:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab1CEM5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 07:57:50 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:49775 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1CEM5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 07:57:50 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 29AA9188A191;
	Sat,  5 Mar 2011 13:57:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 8CBD71C000A2;
	Sat,  5 Mar 2011 13:57:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id TNu63NhYO29p; Sat,  5 Mar 2011 13:57:46 +0100 (CET)
Received: from igel.home (ppp-88-217-99-207.dynamic.mnet-online.de [88.217.99.207])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  5 Mar 2011 13:57:45 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id A4DD0CA2A0; Sat,  5 Mar 2011 13:57:45 +0100 (CET)
X-Yow: So this is what it feels like to be potato salad
In-Reply-To: <AANLkTinwHMULqPZSguYtJztuA4Oy6-s6Ah3_tcVVO7D9@mail.gmail.com>
	(Ruben Laguna's message of "Sat, 5 Mar 2011 12:41:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168492>

Ruben Laguna <ruben.laguna@gmail.com> writes:

> also cloning the repo doesn't change a thing
>
> $ git clone en4j en4j_xx
> Cloning into en4j_xx...
> done.
> $ cd en4j_xx
> $ du -sh .git
>  87M    .git
>
> any other idea?

Please use file://$PWD/en4j as URL, otherwise git clone just hard links
everything.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
