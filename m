From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Wed, 4 May 2016 08:18:52 +0000
Message-ID: <20160504081852.GA24252@dcvr.yhbt.net>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
 <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
 <1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
 <xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
 <6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com>
 <xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
 <32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:19:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axs1L-0006aD-LD
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbcEDISy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:18:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57502 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757369AbcEDISx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:18:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7741D633830;
	Wed,  4 May 2016 08:18:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293514>

Lars Schneider <larsxschneider@gmail.com> wrote:
> OK. I am not that experienced with shell scripting and therefore it
> is hard for me to distinguish between the different shell features.
> Do you know/can you recommend the most basic shell to test/work 
> with? A quick Google search told me that "dash" from Ubuntu seems
> to be a good baseline as it aims to support pretty much only POSIX [1].

Yes, I recommend dash as your /bin/sh if you're using a
Debian-based system ("Debian Almquist shell") such as Ubuntu.

Also, the Debian "devscripts" package has a tool called
"checkbashisms" which I have also found very useful.

Maybe ksh(93) or posh could be good, too, but it's been a
while...

I also rely on checking the manpages-posix and manpages-posix-dev
in the "non-free" section of Debian ("multiverse" in Ubuntu?)
