From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 22:35:47 +0200
Message-ID: <m2k3zivp0c.fsf@igel.home>
References: <4FD0D375.9060902@web.de>
	<1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<4FD0EB76.90501@web.de>
	<20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
	<4FD0FCAC.3070408@web.de>
	<20120607215512.Horde.RVmScHwdC4BP0QcggMBjKUA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 22:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScjQy-0005q8-2f
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab2FGUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 16:35:51 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41289 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab2FGUfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 16:35:50 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3W7dn051wyz4Kn8v;
	Thu,  7 Jun 2012 22:35:48 +0200 (CEST)
Received: from igel.home (ppp-88-217-110-237.dynamic.mnet-online.de [88.217.110.237])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3W7dn03VKyz4KK7X;
	Thu,  7 Jun 2012 22:35:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 210BACA2A2; Thu,  7 Jun 2012 22:35:48 +0200 (CEST)
X-Yow: Now, I think it would be GOOD to buy FIVE or SIX STUDEBAKERS
 and CRUISE for ARTIFICIAL FLAVORING!!
In-Reply-To: <20120607215512.Horde.RVmScHwdC4BP0QcggMBjKUA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Thu, 07 Jun 2012 21:55:12
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199447>

konglu@minatec.inpg.fr writes:

> As you pointed out, the problem seems to come from this line
> 	tmp=$(sed "/^pick .*/i\exec $i" "$1")
> I think that the dquote here doesn't work on MacOS, though i've
> never tried it. Anyway, even if it's not the problem, this kind
> of quoting is quite odd so it will be removed in the next patch
> (I do not see other reasons of the issue, as sed's i command should
> work on MacOS).

You need to put a newline after the backslash.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
