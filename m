From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Is it possible to list unpushed tags without accessing remote?
Date: Fri, 27 Jun 2014 09:41:58 +0200
Message-ID: <87pphu23zt.fsf@igel.home>
References: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com>
	<CAJo=hJvdMURuaEZA3XEWE_Uuq8QRZ+mt8K2H8XrbTuZsVX9gKQ@mail.gmail.com>
	<874mz76281.fsf@igel.home>
	<xmqqlhsj4hmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 09:42:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0QnR-0006bS-4g
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 09:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbaF0HmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 03:42:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44451 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbaF0HmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 03:42:03 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3h095z6JgXz3hhhW;
	Fri, 27 Jun 2014 09:41:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3h095z2n9Pz7S6Qw;
	Fri, 27 Jun 2014 09:41:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id RxEwODAYlaGa; Fri, 27 Jun 2014 09:41:58 +0200 (CEST)
X-Auth-Info: o2LjGuU0gMFBppQR0x9cfSznK9QtBLTtPnlVWhryig4=
Received: from igel.home (host-188-174-210-37.customer.m-online.net [188.174.210.37])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 27 Jun 2014 09:41:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 2E9F32C0597; Fri, 27 Jun 2014 09:41:58 +0200 (CEST)
X-Yow: ..The TENSION mounts as I MASSAGE your RIGHT ANKLE according to
 ancient Tibetan ACCOUNTING PROCEDURES..are you NEUROTIC yet??
In-Reply-To: <xmqqlhsj4hmq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Jun 2014 12:04:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252536>

Junio C Hamano <gitster@pobox.com> writes:

> But then in order to learn what tags the remote has, you need to
> talk to the remote and it won't be "complately a local" operation
> anymore, no?

Just like for every other remote ref.  If you need to know the
ultimative truth the only way is to ask the remote.  Your local copy is
just a cache that may be outdated any time.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
