From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 23:57:45 +0200
Message-ID: <m2k3vn9gyu.fsf@igel.home>
References: <505CCA55.6030609@gmail.com>
	<1348260766-25287-1-git-send-email-artagnon@gmail.com>
	<20120921205834.GC22977@sigill.intra.peff.net>
	<CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
	<20120921211217.GA24134@sigill.intra.peff.net>
	<CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFBES-0002xR-9m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab2IUV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:57:47 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60402 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2IUV5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:57:47 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XNpZd54DVz4KKCL;
	Fri, 21 Sep 2012 23:57:45 +0200 (CEST)
X-Auth-Info: Ee21oSTtJToxiakw0HhnVP0Zt2yZNIRAeJ7r6N7zZx4=
Received: from igel.home (ppp-88-217-127-217.dynamic.mnet-online.de [88.217.127.217])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XNpZd4lQyzbbkf;
	Fri, 21 Sep 2012 23:57:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 2FBE0CA2A5; Fri, 21 Sep 2012 23:57:45 +0200 (CEST)
X-Yow: My pants just went to high school in the Carlsbad Caverns!!!
In-Reply-To: <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 22 Sep 2012 03:04:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206173>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> My SHELL_PATH is not set, and I can see SHELL_PATH ?= $(SHELL) in the
> Makefile.  Which shell is it supposed to point to?

Inside a makefile the variable SHELL is special in that it is never
imported from the environment.  If not set it defaults to /bin/sh.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
