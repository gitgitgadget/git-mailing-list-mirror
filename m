From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 20:40:54 +0200
Message-ID: <m2hasprt1l.fsf@igel.home>
References: <jv5tln$96e$1@dough.gmane.org>
	<alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
	<7vipd5s161.fsf@alter.siamese.dyndns.org>
	<CACPiFCKxYdF8G33myfjOXU31cDWrfrtedve8m89tH_tfOCZ4ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Badie <thomas.badie@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:41:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svuts-0005uL-Ca
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 20:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab2G3Sk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 14:40:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36684 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab2G3Sk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 14:40:58 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Wm8jz50gDz3hhcl;
	Mon, 30 Jul 2012 20:40:55 +0200 (CEST)
X-Auth-Info: uxSvMDIZTwarC33jPz+wKX2OqICdxhNU8cK3n8fDIRg=
Received: from igel.home (ppp-93-104-158-221.dynamic.mnet-online.de [93.104.158.221])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Wm8jz4ZHWzbbcY;
	Mon, 30 Jul 2012 20:40:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id D8E44CA2A4; Mon, 30 Jul 2012 20:40:54 +0200 (CEST)
X-Yow: I brought my BOWLING BALL - and some DRUGS!!
In-Reply-To: <CACPiFCKxYdF8G33myfjOXU31cDWrfrtedve8m89tH_tfOCZ4ng@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 30 Jul 2012 14:16:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202603>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> But any ref definition can be turned into a sha1 with this snippet:
>
>     git show --pretty=format:%H HEAD

      git rev-parse HEAD

> If you want to get the last 10 sha1s, use the same "pretty" with git log
>
>    git log --pretty=format:%H HEAD | head

     git rev-list -n 10 HEAD

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
