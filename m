From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How can I automatically create a GIT branch that represents a sequence of tags?
Date: Sun, 11 Aug 2013 11:36:50 +0200
Message-ID: <m2k3jssh59.fsf@linux-m68k.org>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Kristian Freed <kristian.freed@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 11:37:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8S59-0002tg-DQ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 11:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab3HKJg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 05:36:58 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33432 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab3HKJg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 05:36:57 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cCZpG5m8Tz4KK2D;
	Sun, 11 Aug 2013 11:36:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cCZpG5dqjzbbhD;
	Sun, 11 Aug 2013 11:36:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id FSYrezztZjbx; Sun, 11 Aug 2013 11:36:53 +0200 (CEST)
X-Auth-Info: SOlLw7+QRQC6dacldsNilGw69uHxuFdO5uKTJ9etUvI=
Received: from linux.local (ppp-93-104-130-204.dynamic.mnet-online.de [93.104.130.204])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 11 Aug 2013 11:36:53 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 5F1751E57D6; Sun, 11 Aug 2013 11:36:50 +0200 (CEST)
X-Yow: I'm a GENIUS!  I want to dispute sentence structure with SUSAN SONTAG!!
In-Reply-To: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
	(Kristian Freed's message of "Sat, 10 Aug 2013 23:29:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232130>

Kristian Freed <kristian.freed@gmail.com> writes:

> To help with this process further, it would be useful to be able to
> use git bisect, but as these are just a sequence of tags, not commits
> on a branch, git bisect will not work as is.

git bisect takes arbitrary revisions, there is no restriction on using
tags as bounds.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
