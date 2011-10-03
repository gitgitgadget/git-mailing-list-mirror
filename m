From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Unable to remove a file
Date: Mon, 03 Oct 2011 18:04:59 +0200
Message-ID: <m262k6jc2c.fsf@igel.home>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 18:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAl0v-00061t-9t
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 18:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab1JCQFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 12:05:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35983 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1JCQFD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 12:05:03 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 23EEB1853B92;
	Mon,  3 Oct 2011 18:05:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 835FE1C00079;
	Mon,  3 Oct 2011 18:05:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 8J842vOz7W4Y; Mon,  3 Oct 2011 18:05:00 +0200 (CEST)
Received: from igel.home (ppp-88-217-109-123.dynamic.mnet-online.de [88.217.109.123])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  3 Oct 2011 18:05:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BCF38CA29C; Mon,  3 Oct 2011 18:04:59 +0200 (CEST)
X-Yow: Yow!  Are you the self-frying president?
In-Reply-To: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>
	(robert mena's message of "Mon, 3 Oct 2011 10:21:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182667>

robert mena <robert.mena@gmail.com> writes:

> I found the command filter but it is not working.
>
> git filter-branch --index-filter 'git rm --cached scripts/\\' HEAD

$ git filter-branch --index-filter 'git rm -q --ignore-unmatch --cached scripts/\\' HEAD

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
