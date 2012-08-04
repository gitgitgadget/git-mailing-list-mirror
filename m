From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git cvsimport: new tags not imported on second cvsimport
Date: Sat, 04 Aug 2012 17:58:26 +0200
Message-ID: <m2pq76vecd.fsf@igel.home>
References: <1123570348.20120804133108@gmail.com>
	<m2lihvt2gi.fsf@linux-m68k.org> <9510482012.20120804170149@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxgkl-0006zK-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 17:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab2HDP6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 11:58:50 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53967 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2HDP6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 11:58:30 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Wq8tC4V6bz3hhZc;
	Sat,  4 Aug 2012 17:58:27 +0200 (CEST)
X-Auth-Info: GLTbSu6MPOaVzBnnYHtVxRWtpj3zHutMM7HYweNJtSE=
Received: from igel.home (ppp-93-104-128-70.dynamic.mnet-online.de [93.104.128.70])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Wq8tC47sBzbbfx;
	Sat,  4 Aug 2012 17:58:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C1C18CA2A3; Sat,  4 Aug 2012 17:58:26 +0200 (CEST)
X-Yow: Yow!  Am I JOGGING yet??
In-Reply-To: <9510482012.20120804170149@gmail.com> (Ilya Basin's message of
	"Sat, 4 Aug 2012 17:01:49 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202879>

Ilya Basin <basinilya@gmail.com> writes:

> AS> Ilya Basin <basinilya@gmail.com> writes:
>
>>> I made the initial import:
>>>     git cvsimport -d :pserver:user@blackbird:10010/data/cvs/webgui -C SAP -r cvs -k SAP
>>>
>>> edited .git/config:
>>>     [cvsimport]
>>>             module = SAP
>>>             r = cvs
>>>             d = :pserver:user@blackbird:10010/data/cvs/webgui
>>>
>>> did some commits to CVS and created a new tag
>>>
>>> Then ran:
>>>     git cvsimport -ak
>>> To synchronize with CVS.
>>>
>>> The new commits were imported, but the new tag wasn't.
>
> AS> cvsimport never reconsiders changesets that were already imported, so if
> AS> the tag was added to such a changeset it won't be seen.
>
> AS> Andreas.
>
>
> Do you mean, if I tag BEFORE cvsimport, it will be imported?

If you tag one of the new commits it will be imported.

> How to make the git repo "forget" the last cvsimport?

Reset the branch back to before the import.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
