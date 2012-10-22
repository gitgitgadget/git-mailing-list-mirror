From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: tag storage format
Date: Tue, 23 Oct 2012 00:46:01 +0200
Message-ID: <m2vce2xh06.fsf@igel.home>
References: <CAMJd5ATiAx09eAEo1=6+=hPv=5c6qtOiLRG5jrQn5dfCKUrvMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 00:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQQlH-00064z-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 00:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab2JVWqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 18:46:07 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57161 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab2JVWqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 18:46:06 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XltB22mnvz3hhfM;
	Tue, 23 Oct 2012 00:46:01 +0200 (CEST)
X-Auth-Info: TpL0V644WuWmVk2BdYuSn4rUDTDgmxqxa62yGzSGpE4=
Received: from igel.home (ppp-93-104-136-111.dynamic.mnet-online.de [93.104.136.111])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XltB15hydzbbcl;
	Tue, 23 Oct 2012 00:46:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 57C74112961; Tue, 23 Oct 2012 00:46:01 +0200 (CEST)
X-Yow: I'm losing my hair..did it go to ATLANTIC CITY??
In-Reply-To: <CAMJd5ATiAx09eAEo1=6+=hPv=5c6qtOiLRG5jrQn5dfCKUrvMQ@mail.gmail.com>
	(Uri Moszkowicz's message of "Mon, 22 Oct 2012 17:23:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208206>

Uri Moszkowicz <uri@4refs.com> writes:

> Perhaps Git should switch to a single-file block text or binary format
> once a large number of tags becomes present in a repository.

This is what git pack-refs (called by git gc) does (by putting the refs
in .git/packed-refs).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
