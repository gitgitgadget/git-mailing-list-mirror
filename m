From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 11:42:25 +0100
Message-ID: <1219920145.7107.273.camel@pmac.infradead.org>
References: <20080826164526.GM26610@one.firstfloor.org>
	 <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu>
	 <20080827195019.GA9962@sigill.intra.peff.net>
	 <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu>
	 <48B5BC5F.4070209@kernel.org>
	 <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com>
	 <7vd4jukphm.fsf@gitster.siamese.dyndns.org>
	 <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu>
	 <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu>
	 <20080828090421.GQ10360@machine.or.cz>
	 <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 12:47:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYf2S-0000Nq-Hq
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 12:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYH1Kqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 06:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYH1Kqf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 06:46:35 -0400
Received: from bombadil.infradead.org ([18.85.46.34]:41871 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYH1Kqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 06:46:35 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by bombadil.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1KYf0U-0007s0-T0; Thu, 28 Aug 2008 10:45:39 +0000
In-Reply-To: <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2008-08-28 at 03:33 -0700, Perry Wagle wrote:
> Are you suggesting that I break into machines that I don't have access
> to add a export PATH= line to copies of scripts that were written 6  
> months ago, and worked just fine until someone decided that "upward  
> compatibility" wasn't an important concept?

Not at all. But as long as you also refrain from breaking into those
same machines and upgrading them to git 1.6.0, you should be fine.

Or if you _do_ upgrade them to git 1.6.0, you should make sure you build
with gitexecdir=/usr/bin to prevent the breakage.

What distribution are you running on those machines? If they upgrade
their version of git from an earlier version to 1.6.0 in a stable
release without setting gitexecdir=/usr/bin to preserve compatibility,
then the packager needs to be taken out back and shot.

Perhaps you should file a bug in advance, to make sure they're aware of
the issue and make sure that if/when they update to 1.6.0, they set
gitexecdir properly.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
