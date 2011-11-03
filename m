From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How to make "git push/pull" work in non-clone repo?
Date: Thu, 03 Nov 2011 18:00:35 +0100
Message-ID: <m2fwi5nnt8.fsf@igel.home>
References: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
	<F802D297-95A0-4B1E-894D-9681E0EEF3AD@jetbrains.com>
	<CANiMyiF=C_uBXf3kV8ix=CY9Mi=cxHU-J3dn5UyJ87gu3Sm0dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Hong-Ming Su <halleyinvent@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 18:00:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM0ej-0007xN-AC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 18:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934132Ab1KCRAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 13:00:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40008 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934085Ab1KCRAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 13:00:40 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id BAE3F1C0242A;
	Thu,  3 Nov 2011 18:00:37 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id B65C71C00087;
	Thu,  3 Nov 2011 18:00:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id xnm8Glf9+Fxt; Thu,  3 Nov 2011 18:00:37 +0100 (CET)
Received: from igel.home (ppp-88-217-126-198.dynamic.mnet-online.de [88.217.126.198])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  3 Nov 2011 18:00:36 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 2715CCA29C; Thu,  3 Nov 2011 18:00:36 +0100 (CET)
X-Yow: Is this my STOP??
In-Reply-To: <CANiMyiF=C_uBXf3kV8ix=CY9Mi=cxHU-J3dn5UyJ87gu3Sm0dg@mail.gmail.com>
	(Hong-Ming Su's message of "Fri, 4 Nov 2011 00:10:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184729>

Hong-Ming Su <halleyinvent@gmail.com> writes:

> /d/workspace/git/work1 (master)
> $ git remote add origin ../depot

$ git branch --set-upstream master origin/master

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
