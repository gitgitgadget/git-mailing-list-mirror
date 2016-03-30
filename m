From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git show -m with a parent number
Date: Wed, 30 Mar 2016 18:55:21 +0200
Message-ID: <871t6rx5vq.fsf@linux-m68k.org>
References: <nd9gq6$412$1@ger.gmane.org>
	<20160328191608.GA22602@sigill.intra.peff.net>
	<ndggug$c87$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Anatoly Borodin <anatoly.borodin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 18:55:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJP6-0006cb-Da
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 18:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbcC3Qza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 12:55:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40458 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbcC3Qz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 12:55:26 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qZv0C5hNYz3hjd6;
	Wed, 30 Mar 2016 18:55:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qZv0C5Dvjzvh24;
	Wed, 30 Mar 2016 18:55:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id pAZ-C3CWnlKA; Wed, 30 Mar 2016 18:55:21 +0200 (CEST)
X-Auth-Info: s2YxpkkQi2X75AM0waVmOyoNKGWqvrYzTuDUVo2A2XUyG1yMeXeAfe37yY1guVYA
Received: from igel.home (ppp-88-217-14-4.dynamic.mnet-online.de [88.217.14.4])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 30 Mar 2016 18:55:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 84AE72C2CE4; Wed, 30 Mar 2016 18:55:21 +0200 (CEST)
X-Yow: I HAVE a towel.
In-Reply-To: <ndggug$c87$1@ger.gmane.org> (Anatoly Borodin's message of "Wed,
	30 Mar 2016 12:31:16 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290312>

Anatoly Borodin <anatoly.borodin@gmail.com> writes:

> It's not like `git diff X^2 X` is a big problem, but too much of a
> copypaste.

Brace expansion helps a bit: git diff X{^2,}

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
