From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Announcing git-reparent
Date: Mon, 14 Jan 2013 21:08:58 +0100
Message-ID: <m21udnzfvp.fsf@igel.home>
References: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
	<20130114071608.GL3125@elie.Belkin>
	<CAA01Csoh24ppo37fzptzZKvFrzGQyhz-0eDTQsP8tZiTRQ2YwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mark Lodato <lodatom@gmail.com>, git list <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 21:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuqLa-0003FE-30
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 21:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab3ANUJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 15:09:08 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:55658 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757102Ab3ANUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 15:09:06 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YlQk71QT3z3hhv5;
	Mon, 14 Jan 2013 21:09:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YlQk71GvTzbbfw;
	Mon, 14 Jan 2013 21:09:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 1__IE7tuhD1A; Mon, 14 Jan 2013 21:08:47 +0100 (CET)
X-Auth-Info: vMiXdjwh+/wsjdYVx/XveNyUkr1HwuiiJMIIwK7Fpyc=
Received: from igel.home (ppp-88-217-111-218.dynamic.mnet-online.de [88.217.111.218])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 14 Jan 2013 21:08:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id EE1D711200A; Mon, 14 Jan 2013 21:08:58 +0100 (CET)
X-Yow: Loni Anderson's hair should be LEGALIZED!!
In-Reply-To: <CAA01Csoh24ppo37fzptzZKvFrzGQyhz-0eDTQsP8tZiTRQ2YwA@mail.gmail.com>
	(Piotr Krukowiecki's message of "Mon, 14 Jan 2013 09:03:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213528>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Just wondering, is the result different than something like
>
> git checkout commit_to_reparent
> cp -r * ../snapshot/
> git reset --hard new_parent
> rm -r *
> cp -r ../snapshot/* .
> git add -A

I think you are looking for "git reset --soft new_parent", which keeps
both the index and the working tree intact.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
