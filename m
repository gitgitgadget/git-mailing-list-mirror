From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: flatten-merge history
Date: Sun, 26 Oct 2014 16:19:03 +0100
Message-ID: <8761f65060.fsf@igel.home>
References: <544B9839.7000302@gmx.de>
	<CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>
	<544D0702.1050907@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 26 16:19:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiPbB-0006fr-U8
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 16:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaJZPTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 11:19:09 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38054 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaJZPTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 11:19:08 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jQjWY2S9xz3hjF3;
	Sun, 26 Oct 2014 16:19:05 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jQjWX5fHRzvh1v;
	Sun, 26 Oct 2014 16:19:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id g_QjAqHgcpt3; Sun, 26 Oct 2014 16:19:04 +0100 (CET)
X-Auth-Info: 5qoD6Ve/hToXef1a0R6qAJzQnkOoPq/JInX1VdmjSQrIwwKgzdXT6qFa/+1CUR5b
Received: from igel.home (ppp-93-104-158-8.dynamic.mnet-online.de [93.104.158.8])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 26 Oct 2014 16:19:03 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id A70DF2C1D58; Sun, 26 Oct 2014 16:19:03 +0100 (CET)
X-Yow: ...Get me a GIN and TONIC!!...make it HAIR TONIC!!
In-Reply-To: <544D0702.1050907@gmx.de> (Henning Moll's message of "Sun, 26 Oct
	2014 15:36:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Moll <newsScott@gmx.de> writes:

> 1. For P, A is the nearest prior commit on 'master'
> 2. on master: git rebase -i A^
> 3. change A from pick to edit. save. quit
> 4. git merge P
> 5. git rebase --continue
>
> From the perspective of 'master' this worked. But as all of the commits
> have been rewritten, the branches b1 and b2 no longer refer to
> 'master'. Branch b2, for example, still branches off at B and not B'.

You only rebased master, so b1 and b2 were unchanged.  If you want to
change b1 and b2 you have to rebase them as well.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
