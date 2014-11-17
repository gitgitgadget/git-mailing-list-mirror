From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Doing a git add '' will add more files then expected
Date: Mon, 17 Nov 2014 19:15:33 +0100
Message-ID: <87lhn91ynu.fsf@igel.home>
References: <CAMDzUtyhNKdzHQK2zLEutJRcRUibhO-U6Zh0yJhrx-YxBqP5cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 19:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqQpz-0004jf-1P
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 19:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbaKQSPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 13:15:39 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55533 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaKQSPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 13:15:38 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jhJP26Fv5z3hj6T;
	Mon, 17 Nov 2014 19:15:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jhJP25pk1zvh23;
	Mon, 17 Nov 2014 19:15:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id Zmq0sQR4QGK7; Mon, 17 Nov 2014 19:15:34 +0100 (CET)
X-Auth-Info: smJMmTGcQ7T2mPgq7SHpPPC2rGGXUm82crZRMoFKCSKQ4jWd8ROmVm8P6nXrypVK
Received: from igel.home (ppp-188-174-153-115.dynamic.mnet-online.de [188.174.153.115])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 17 Nov 2014 19:15:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id ED78B2C37A9; Mon, 17 Nov 2014 19:15:33 +0100 (CET)
X-Yow: YOW!!  Now I understand advanced MICROBIOLOGY
 and th' new TAX REFORM laws!!
In-Reply-To: <CAMDzUtyhNKdzHQK2zLEutJRcRUibhO-U6Zh0yJhrx-YxBqP5cQ@mail.gmail.com>
	(Guilherme's message of "Mon, 17 Nov 2014 17:25:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guilherme <guibufolo@gmail.com> writes:

> Steps to reproduce:
> In bash (not sure this is bash specific) do:
> git add ''
> (that's to apostrophes, an empty argument)
>
> Results
> same as doing git add .
>
> Expected
> no files added or error about not finding file ''

The argument to git add is a pathspec, and the empty pathspec matches
all files.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
