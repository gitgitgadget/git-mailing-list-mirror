From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: 'git --grep' doesn't grep notes?
Date: Mon, 27 Aug 2012 21:09:07 +0200
Message-ID: <m2harob19o.fsf@igel.home>
References: <CAPRhCbvnRqUpKcw_E383ekG_M0O2a+cTTixUQtU-0mtj3V=7uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 21:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T64ge-0005NS-89
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 21:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab2H0TJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 15:09:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42748 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab2H0TJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 15:09:10 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X5N1c33hKz4KK2Z;
	Mon, 27 Aug 2012 21:09:08 +0200 (CEST)
X-Auth-Info: 78vi7SpMQbyPawM7dRu3oKBo5jYkI3yF7eAw7csYh1w=
Received: from igel.home (ppp-88-217-118-73.dynamic.mnet-online.de [88.217.118.73])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X5N1c1wk0zbbgp;
	Mon, 27 Aug 2012 21:09:08 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id D8001CA2A3; Mon, 27 Aug 2012 21:09:07 +0200 (CEST)
X-Yow: My Aunt MAUREEN was a military advisor to IKE & TINA TURNER!!
In-Reply-To: <CAPRhCbvnRqUpKcw_E383ekG_M0O2a+cTTixUQtU-0mtj3V=7uw@mail.gmail.com>
	(Todd A. Jacobs's message of "Mon, 27 Aug 2012 14:18:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204367>

"Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:

> What is the right way to include notes in log searches, especially if
> the end goal is to find the related commit ID?

You can git grep on refs/notes/commits and s,/,,g on the file name
found.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
