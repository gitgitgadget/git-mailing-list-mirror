From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Tue, 25 May 2010 16:03:15 +0200
Message-ID: <4BFBD8A3.8040203@drmicha.warpmail.net>
References: <AANLkTinNYcuiyRpgMGpQAEaStj2MDg9UooozooLPwv_0@mail.gmail.com> <284d7af64fec2dc0cabdb5cf29ab3fd34fad79f0.1274794889.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Daniel Knittl-Frank <knittl89+git@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 25 16:03:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGujJ-0003NA-Gm
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 16:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab0EYODb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 10:03:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40803 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756630Ab0EYODa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 10:03:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5742FF77C9;
	Tue, 25 May 2010 10:03:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 25 May 2010 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=YC+WHs2gTDU9eShlpvU6EH2PapE=; b=O/DsMyQtcaHHCbWX0bb1/zMSsGKrDgbRKt/T6lOaqtqCibUd5j+vs7vsyaaLawjZlrswmwkPtUHOqKoxn3xdgsGmITp0nOFmj+YWaRJhzh9b+uvdwKfDtix2qp69dwTrfbYBqYUx3u3FyTiGVbj5xY6ydLrUfLGwmOmcVG6yFvE=
X-Sasl-enc: zbAWi9LRevrqJnHqd9ez/ud7Nl8N/5AOXKEOraGjxeWN 1274796210
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E1AF4903B;
	Tue, 25 May 2010 10:03:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100525 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <284d7af64fec2dc0cabdb5cf29ab3fd34fad79f0.1274794889.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147711>

> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> 
> This patch adds a first line in the output of `git status -s` when given
> the option `-b` or `--branch`, showing which branch the user is
> currently on, and in case of tracking branches the number of commits on
> each branch.
> 
> Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> ---
> Sent by the not-so-atomatic mob-robot...

...with the not so automagic spell-checker...

> I noticed some white space issue but assume Junio fixes that automatically
> when applying.
> 
>  builtin/commit.c |    8 ++++-
>  wt-status.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  wt-status.h      |    6 +++-
>  3 files changed, 76 insertions(+), 6 deletions(-)

I tried it and I like it! [Ordinary status could use the same colors for
tracking info, they're helpful.]

I also like the fact that --porcelain -b does what it should (unchanged
by the patch).

I'm wondering what "git status -b" should do. Currently, "-b" is ignored
silently. One may argue it's okay since ordinary status shows tracking
info anyways.

Michael
