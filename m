From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git cvsimport: new tags not imported on second cvsimport
Date: Sat, 04 Aug 2012 11:45:49 +0200
Message-ID: <m2lihvt2gi.fsf@linux-m68k.org>
References: <1123570348.20120804133108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 11:45:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxavk-0007qF-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 11:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab2HDJpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 05:45:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40613 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab2HDJpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 05:45:50 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Wq0cD72Yjz3hhXM;
	Sat,  4 Aug 2012 11:45:48 +0200 (CEST)
X-Auth-Info: rXFJni5+ws8bwLJb4aTDLPqFVqyC9BUyBOgHS4VAsrU=
Received: from linux.local (ppp-93-104-128-70.dynamic.mnet-online.de [93.104.128.70])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Wq0cD6gVgzbbfq;
	Sat,  4 Aug 2012 11:45:48 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 2B0011E5309; Sat,  4 Aug 2012 11:45:50 +0200 (CEST)
X-Yow: Yow!  I'm out of work...I could go into shock absorbers...or SCUBA
 GEAR!!
In-Reply-To: <1123570348.20120804133108@gmail.com> (Ilya Basin's message of
	"Sat, 4 Aug 2012 13:31:08 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202876>

Ilya Basin <basinilya@gmail.com> writes:

> I made the initial import:
>     git cvsimport -d :pserver:user@blackbird:10010/data/cvs/webgui -C SAP -r cvs -k SAP
>
> edited .git/config:
>     [cvsimport]
>             module = SAP
>             r = cvs
>             d = :pserver:user@blackbird:10010/data/cvs/webgui
>
> did some commits to CVS and created a new tag
>
> Then ran:
>     git cvsimport -ak
> To synchronize with CVS.
>
> The new commits were imported, but the new tag wasn't.

cvsimport never reconsiders changesets that were already imported, so if
the tag was added to such a changeset it won't be seen.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
