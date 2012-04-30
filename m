From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git log -z still outputting newlines?
Date: Mon, 30 Apr 2012 20:34:38 +0200
Message-ID: <m2pqaprrup.fsf@igel.home>
References: <86ty01qez7.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Mon Apr 30 20:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvQu-00056k-T3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 20:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab2D3Seo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 14:34:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38538 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab2D3Seo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 14:34:44 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VhDtm63lwz4Kh0b;
	Mon, 30 Apr 2012 20:34:39 +0200 (CEST)
Received: from igel.home (ppp-88-217-104-31.dynamic.mnet-online.de [88.217.104.31])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VhDtl42S0z4KLGk;
	Mon, 30 Apr 2012 20:34:39 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B5F5DCA2A9; Mon, 30 Apr 2012 20:34:38 +0200 (CEST)
X-Yow: I wonder if there's anything GOOD on tonight?
In-Reply-To: <86ty01qez7.fsf@red.stonehenge.com> (Randal L. Schwartz's message
	of "Mon, 30 Apr 2012 10:58:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196589>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> $ git log -z --format='%cE' -5 | od -c
> 0000000    g   i   t   s   t   e   r   @   p   o   b   o   x   .   c   o
> 0000020    m  \n   g   i   t   s   t   e   r   @   p   o   b   o   x   .
> 0000040    c   o   m  \n   g   i   t   s   t   e   r   @   p   o   b   o
> 0000060    x   .   c   o   m  \n   g   i   t   s   t   e   r   @   p   o
> 0000100    b   o   x   .   c   o   m  \n   g   i   t   s   t   e   r   @
> 0000120    p   o   b   o   x   .   c   o   m  \n                        
> 0000132
>
> Why are all those newlines in there?  Bug?  Misfeature?  Feature?  If
> feature, how do I ensure \0 in my output?  If I add %x00, I get both \0
> *and* \n in output. :(

--format=format:%cE respects the -z option.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
