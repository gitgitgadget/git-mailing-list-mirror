From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Three dot notion used inconsitent?
Date: Wed, 18 Nov 2015 18:49:01 +0100
Message-ID: <87lh9vp59u.fsf@igel.home>
References: <1CDF2D38-B73A-4C49-BC10-1F3BA1873733@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 18:49:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz6r1-0000n4-7w
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 18:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbbKRRtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 12:49:06 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45724 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbKRRtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 12:49:05 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3p1BTV6p1fz3hj7x;
	Wed, 18 Nov 2015 18:49:02 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3p1BTV6GVmzvh1v;
	Wed, 18 Nov 2015 18:49:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id i1mr_L1t58DX; Wed, 18 Nov 2015 18:49:02 +0100 (CET)
X-Auth-Info: SU0IFXrdXF2zc4znR10YoVyOK/ru1qM5fWuNgM0/d/xj9uQq//0vzvAyf+h+CFRg
Received: from igel.home (ppp-88-217-12-211.dynamic.mnet-online.de [88.217.12.211])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 18 Nov 2015 18:49:01 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 85F932C5423; Wed, 18 Nov 2015 18:49:01 +0100 (CET)
X-Yow: My forehead feels like a PACKAGE of moist CRANBERRIES in a remote
 FRENCH OUTPOST!!
In-Reply-To: <1CDF2D38-B73A-4C49-BC10-1F3BA1873733@gmail.com> (Lars
	Schneider's message of "Wed, 18 Nov 2015 11:31:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281454>

Lars Schneider <larsxschneider@gmail.com> writes:

> git diff branchA...branchB
> --> gives me the diff between (the common ancestor of A and B) and B. That means I never see changes on branchA.
>
> git log branchA...branchB
> --> gives me the commits reachable from A and B. That includes changes from branchA.
>
> Is this because of a design decision that I do not (yet) understand or is this inconsistent for historical reasons?

git diff operates on two revisions.  That is inherently incompatible
with the usual meaning of A...B and A..B, which are set operations on
the revision history.  That git diff accepts this syntax is only for
convenience.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
