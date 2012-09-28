From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override ~/.gitconfig
Date: Fri, 28 Sep 2012 12:35:31 +0530
Message-ID: <CALkWK0=CCLrfM2Jr_JNVP0VQnp1dvRAkDjRrTsogvpD8rGrumw@mail.gmail.com>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
 <1348757171-3223-1-git-send-email-artagnon@gmail.com> <20120927173532.GD1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 09:06:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THUeA-0007Yz-7K
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 09:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab2I1HFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 03:05:53 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52363 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2I1HFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 03:05:52 -0400
Received: by qchd3 with SMTP id d3so1701987qch.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FHNQMCf74XFsF6FOFQGZI00IN4h2tfVQaGlJdQh46UM=;
        b=UR6hdH7VGnVt29NmWT5LD7WGSBZGII2Rk4z1Caokp56LGdRrEGqe0sylf0wjy7N46f
         Cx0Ro0KwULkZKhZVzGSHz/EHo3QffFIttG78twiCgAictJbMIkex283c6yJgpyetQbCK
         nAVxga9abj/mEtP+eTJ5oVsgCBH0+UY9Hos3odLpDKcEGV/mozJNoy9jtjaGY4zE5P7b
         hJqBwrCwx8MHiaMqZ1lM5YZnasHN08m2EiEOd9/M4OJ7qELpxXoBi4qUUybRdKRKEuHA
         RR35a3Ew7dFn17E1W9pBD4ZDF1llcDpgfxJoTqA1E6TUEMKCv4e90CJXMHSiMKIipp6X
         zhoQ==
Received: by 10.229.136.17 with SMTP id p17mr4029304qct.86.1348815952215; Fri,
 28 Sep 2012 00:05:52 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 28 Sep 2012 00:05:31 -0700 (PDT)
In-Reply-To: <20120927173532.GD1547@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206542>

Jeff King wrote:
> Like the other reviews, I am not overly enthused. If we are going to add
> a new variable, I think $GIT_HOME makes a lot more sense. But it really
> sounds like using $XDG_CONFIG_HOME would be even simpler.
>
> Also, have you considered using a config include? Like:
>
>   $ echo '[include]path = ~/my-dotfiles/gitconfig' >~/.gitconfig

Sounds like this is the way to go.  Or I could pick up Junio's
suggestion to use a Makefile.  I'll discontinue working on the patch.

Thanks.

Ram
