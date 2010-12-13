From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Git SVN non-standard branch/tag/trunk layout
Date: Mon, 13 Dec 2010 01:25:19 +0100
Message-ID: <m2fwu2ecy8.fsf@igel.home>
References: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Albert Krawczyk" <pro-logic@optusnet.com.au>
X-From: git-owner@vger.kernel.org Mon Dec 13 01:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwEp-0000In-IQ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab0LMAZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 19:25:24 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:54858 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab0LMAZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 19:25:22 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 505B4186DECC;
	Mon, 13 Dec 2010 01:25:19 +0100 (CET)
Received: from igel.home (ppp-88-217-112-56.dynamic.mnet-online.de [88.217.112.56])
	by mail.mnet-online.de (Postfix) with ESMTP id A37DA1C000EE;
	Mon, 13 Dec 2010 01:25:19 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 6E0D6CA2A0; Mon, 13 Dec 2010 01:25:19 +0100 (CET)
X-Yow: I invented skydiving in 1989!
In-Reply-To: <006c01cb9a44$8407d2f0$8c1778d0$@optusnet.com.au> (Albert
	Krawczyk's message of "Mon, 13 Dec 2010 08:35:34 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163497>

"Albert Krawczyk" <pro-logic@optusnet.com.au> writes:

> Essentially instead of having one project per repo, there are multiple
> projects in the repo. So the repo looks like this
>
> ---SVN Root --- Folder(Proj1) ---- Files
> 	\
> 	 ---- Folder(Proj2) --- Trunk - Files
> 	|	       \
> 	|		- Branch - Files
> 	|		|
> 	|		- Tag - ...
> 	|
> 	|- Proj3 - Files
> 	|- Proj4 - Trunk
> 		 |-Branch
> 		 | - Tag
>
> The question is, is there a way I can get Git SVN to understand and
> replicate this layout in a git repo? I don't mind if I have to import the
> entire repo again into git. 

If they are multiple projects then you'll probably be better off
importing each project into its own git repository.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
