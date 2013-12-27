From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 15:12:07 +0100
Message-ID: <87mwjm4c3s.fsf@igel.home>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwY9D-00075F-II
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3L0OMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:12:15 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:49668 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab3L0OMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:12:14 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3drVN84vzFz3hjjm;
	Fri, 27 Dec 2013 15:12:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3drVN84lsqzbbbs;
	Fri, 27 Dec 2013 15:12:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id h390848UR7QY; Fri, 27 Dec 2013 15:12:07 +0100 (CET)
X-Auth-Info: FS4kWiB/YvqcM0BWZJiyBICZYZFGrVXLIr8Ftg3rTvk=
Received: from igel.home (ppp-46-244-233-18.dynamic.mnet-online.de [46.244.233.18])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 27 Dec 2013 15:12:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 518F32C1ED4; Fri, 27 Dec 2013 15:12:07 +0100 (CET)
X-Yow: An air of FRENCH FRIES permeates my nostrils!!
In-Reply-To: <CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	(Sergey Sharybin's message of "Fri, 27 Dec 2013 19:58:19 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239730>

Sergey Sharybin <sergey.vfx@gmail.com> writes:

> So guess we just need to recommend using https:// protocol instead of
> git:// for our users?

Given how easy it is to verify the integrity of a git repository out of
band there isn't really much of added security by using TLS for
transport.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
