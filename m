From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH 0/3] Teach revert/cherry-pick the --no-verify option
Date: Mon, 8 Sep 2014 17:13:45 +0200
Message-ID: <CALKQrgewtPOFhqjH_zoY3q922DgzXxHfuUF=sS86on-r4SJYeA@mail.gmail.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<540A2598.8000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	=?UTF-8?Q?Lars_Gullik_Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:14:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR0dn-0006Dy-3v
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 17:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbaIHPN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 11:13:56 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:61732 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbaIHPNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 11:13:55 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XR0dc-000Drb-KQ
	for git@vger.kernel.org; Mon, 08 Sep 2014 17:13:52 +0200
Received: by mail-pa0-f45.google.com with SMTP id rd3so2629578pab.4
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 08:13:45 -0700 (PDT)
X-Received: by 10.70.102.231 with SMTP id fr7mr6461113pdb.148.1410189225417;
 Mon, 08 Sep 2014 08:13:45 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Mon, 8 Sep 2014 08:13:45 -0700 (PDT)
In-Reply-To: <540A2598.8000101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256651>

On Fri, Sep 5, 2014 at 11:05 PM, Fabian Ruch <bafain@gmail.com> wrote:
> neither git-cherry-pick nor git-revert execute the pre-commit or
> commit-msg hooks at the moment. The underlying rationale can be found in
> the log message of commit 9fa4db5 ("Do not verify
> reverted/cherry-picked/rebased patches."). Indeed, the sequencer uses
> git-commit internally which executes the two verify hooks by default.
> However, the particular command line being used implicitly specifies the
> --no-verify option. This behaviour is implemented in
> sequencer.c#run_git_commit as well, right before the configurable
> git-commit options are handled. I guess that's easily overlooked since
> the documentation doesn't mention it and the implementation uses the
> short version -n of --no-verify.

Damn. You're obviously correct, and my patch series is seriously
misguided. Please drop it, Junio, and I'm very sorry for the noise.
Hopefully, I will learn not to blindly follow my assumptions.

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
