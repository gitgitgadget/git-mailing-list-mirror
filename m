From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Unable to delete remote branch with a strange name
Date: Tue, 28 Dec 2010 09:40:22 +0100
Message-ID: <m2hbdy9top.fsf@whitebox.home>
References: <loom.20101228T080344-503@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jingzhao Ou <jingzhao.ou@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 09:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXV6f-0006l1-GX
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 09:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab0L1Ik1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 03:40:27 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51687 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0L1Ik1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 03:40:27 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 8C8251853B9F;
	Tue, 28 Dec 2010 09:40:25 +0100 (CET)
X-Auth-Info: Aq1lxQzsDUp/RVLu3CcHXZsCI6pEA9ufj7kC3Q09HVA=
Received: from linux.local (p508B188D.dip.t-dialin.net [80.139.24.141])
	by mail.mnet-online.de (Postfix) with ESMTPA id 9FBC91C001A1;
	Tue, 28 Dec 2010 09:40:25 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 75ACB1E52EC; Tue, 28 Dec 2010 09:40:23 +0100 (CET)
X-Yow: Hello...  IRON CURTAIN?  Send over a SAUSAGE PIZZA!
 World War III?  No thanks!
In-Reply-To: <loom.20101228T080344-503@post.gmane.org> (Jingzhao Ou's message
	of "Tue, 28 Dec 2010 07:06:10 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164233>

Jingzhao Ou <jingzhao.ou@gmail.com> writes:

> I guess somehow, git is confused by "origin/dev/main" and 
> "origin/remotes/origin/dev/main". Especially, it cannot identify the latter
> properly.

Try fully qualifying the remote branch (beginning with refs/heads/).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
