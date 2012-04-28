From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sat, 28 Apr 2012 09:47:24 +0200
Message-ID: <m2pqasb8mr.fsf@linux-m68k.org>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 09:48:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SO2Nv-00018s-Gx
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 09:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab2D1Hr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 03:47:28 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43562 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab2D1Hr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 03:47:27 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Vfkcs00Jjz3hhbK;
	Sat, 28 Apr 2012 09:47:24 +0200 (CEST)
Received: from linux.local (ppp-88-217-107-246.dynamic.mnet-online.de [88.217.107.246])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Vfkcs2Vs2z4KK48;
	Sat, 28 Apr 2012 09:47:25 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id AD5F91E5607; Sat, 28 Apr 2012 09:47:24 +0200 (CEST)
In-Reply-To: <20379.9312.943088.350379@winooski.ccs.neu.edu> (Eli Barzilay's
	message of "Fri, 27 Apr 2012 18:57:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
X-Yow: We just joined the civil hair patrol!
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196492>

Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org> writes:

> For a while now I had a problem when I try to do stash operations via
> magit -- for example, it shows this in the process buffer:
>
>   $ git --no-pager stash apply stash@{2012-04-27 08:53:30 -0400}
>   Too many revisions specified: stash@{2012-04-27 08:53:30 -0400}

FWIW, replacing the spaces by dots will avoid the bug.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
