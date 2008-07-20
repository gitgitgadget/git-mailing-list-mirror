From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 19:49:43 +0200
Message-ID: <1216576183.3673.2.camel@pc7.dolda2000.com>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
	 <1216490252.10694.58.camel@koto.keithp.com>
	 <1216491512.3911.9.camel@pc7.dolda2000.com>
	 <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 19:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKd3i-00084X-UM
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 19:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbYGTRt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757803AbYGTRt6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 13:49:58 -0400
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:53830 "EHLO
	nerv.dolda2000.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbYGTRt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 13:49:57 -0400
Received: from [IPv6:2002:52b6:8514:200:21d:7dff:fea1:197] ([IPv6:2002:52b6:8514:200:21d:7dff:fea1:197])
	(authenticated bits=0)
	by nerv.dolda2000.com (8.13.8/8.13.8/Debian-3) with ESMTP id m6KHnhWR013912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jul 2008 19:49:43 +0200
In-Reply-To: <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness>
X-Mailer: Evolution 2.22.3.1 
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (nerv.dolda2000.com [IPv6:2002:52b6:8514:200::1]); Sun, 20 Jul 2008 19:49:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89203>

On Sun, 2008-07-20 at 12:27 +0200, Johannes Schindelin wrote:
> Well, this was to be expected, after what I wrote in response to 3. in
> http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=2598
> 
> Reality always catches up with you, and here again we see that plink and 
> other siblings of OpenSSH should be best handled with scripts, preferably 
> ones that strip out options they do not recognize.

Otherwise, an alternative may be to always install a script, say
`git-ssh', that would invoke the real SSH in a manner specific for the
platform. The exact script installed could even be parametrized by the
Makefile. For systems using OpenSSH, it would probably just consist of
`ssh -xT "$@"'.

What do you think?

Fredrik Tolf
