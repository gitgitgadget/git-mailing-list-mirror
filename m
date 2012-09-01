From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Grafting Alternate History
Date: Sat, 01 Sep 2012 08:48:00 +0200
Message-ID: <m2harick7z.fsf@igel.home>
References: <nng7gse7hrl.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 08:48:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7hV9-00043M-23
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 08:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab2IAGsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 02:48:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40350 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2IAGsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 02:48:07 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X87LB0Xdbz3hhcn;
	Sat,  1 Sep 2012 08:48:01 +0200 (CEST)
X-Auth-Info: DqbjZbVzx8PWqCOtnV34XlRPmE0Gu90rLJ1ZsvBHeXs=
Received: from igel.home (ppp-88-217-112-52.dynamic.mnet-online.de [88.217.112.52])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X87L96Kx4zbbcm;
	Sat,  1 Sep 2012 08:48:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5632ACA2A5; Sat,  1 Sep 2012 08:48:01 +0200 (CEST)
X-Yow: I'm also against BODY-SURFING!!
In-Reply-To: <nng7gse7hrl.fsf@transit.us.cray.com> (dag@cray.com's message of
	"Fri, 31 Aug 2012 18:39:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204618>

<dag@cray.com> writes:

> For example, let's say we take a local copy of the private repository.
> I would like to somehow create an empty branch in that local copy and
> then populate it with the history of the public repository.  I would
> like to be able to specify a git diff-like command on the public graft
> branch to get some changes over a range of commits and apply those
> changes to one of the private branches (say master).

You can set up (the git mirror of) the public repository as a remote in
the private repository and git cherry-pick the commits you want to copy
over.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
