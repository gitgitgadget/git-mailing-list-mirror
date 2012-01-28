From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Bisecting through the middle of a big merge?
Date: Sat, 28 Jan 2012 09:55:28 +0100
Message-ID: <m239b0fbpb.fsf@igel.home>
References: <jfve09$ih5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:38:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCEB-0000o9-PX
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab2A1Izd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 03:55:33 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47691 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2A1Izc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 03:55:32 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 2BC651C01A21;
	Sat, 28 Jan 2012 09:55:29 +0100 (CET)
X-Auth-Info: 3QauQzE38oJfRGukuAr97d/hJ7bQwT6q4RbacXx97lM=
Received: from igel.home (ppp-88-217-122-153.dynamic.mnet-online.de [88.217.122.153])
	by mail.mnet-online.de (Postfix) with ESMTPA id 210801C0007F;
	Sat, 28 Jan 2012 09:55:29 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C3E6ECA299; Sat, 28 Jan 2012 09:55:28 +0100 (CET)
X-Yow: The LOGARITHM of an ISOSCELES TRIANGLE is TUESDAY WELD!!
In-Reply-To: <jfve09$ih5$1@dough.gmane.org> (walt's message of "Fri, 27 Jan
	2012 16:03:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189253>

walt <w41ter@gmail.com> writes:

> There are many individual commits from Tejun Heo et al included
> in that one big commit from Linus.  Unfortunately for me, some of
> those commits cause other problems that I'm not trying to bisect;
> other problems that evidently get fixed by other commits in the
> same big merge.
>
> So I do 'git bisect skip' six or eight times until the 'false' bug
> goes away, and that leaves me at the end of the bisect without finding
> the individual commit that's causing my 'real' bug.
>
> How do you experts handle this kind of problem?

If you can identify the commit that fixes the unrelated problem you can
try to cherry-pick it during the bisect.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
