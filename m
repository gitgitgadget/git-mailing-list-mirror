From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 09 Feb 2012 17:30:21 +0100
Message-ID: <m2aa4synoi.fsf@igel.home>
References: <20120209095415.GA19230@glitch>
	<CAPBPrntqaFk7YNf7Rz5aVNOMQVTAFaQcJoPFtsOn6rk8n2Q_sg@mail.gmail.com>
	<20120209160419.GA28718@glitch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 17:30:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvWtC-0001dq-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 17:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab2BIQa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 11:30:26 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38792 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2BIQaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 11:30:25 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3755B18000CC;
	Thu,  9 Feb 2012 17:30:22 +0100 (CET)
X-Auth-Info: J8MTJXV8nRjTJ/CGoNZLBYSXA1p/1fYGuREk7BvgnV4=
Received: from igel.home (ppp-88-217-114-208.dynamic.mnet-online.de [88.217.114.208])
	by mail.mnet-online.de (Postfix) with ESMTPA id 7FADF1C000BE;
	Thu,  9 Feb 2012 17:30:22 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C550FCA299; Thu,  9 Feb 2012 17:30:21 +0100 (CET)
X-Yow: It's the land of DONNY AND MARIE as promised in TV GUIDE!
In-Reply-To: <20120209160419.GA28718@glitch> (Domenico Andreoli's message of
	"Thu, 9 Feb 2012 17:04:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190297>

Domenico Andreoli <cavokz@gmail.com> writes:

> This is Debian unstable, out-of-the-box git package 1.7.9-1.
>
> $ git reset --hard v3.3-rc2
> HEAD is now at 62aa2b5 Linux 3.3-rc2
> $ git merge --ff-only v3.3-rc3
> fatal: Not possible to fast-forward, aborting.
> $ 

Workaround:

$ git merge v3.3-rc3^{}
Updating 62aa2b5..d65b4e9
Fast-forward

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
