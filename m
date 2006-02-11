From: Craig Schlenter <craig@codefountain.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 09:35:07 +0200
Message-ID: <5C03F8F8-656F-48B0-825C-DE55C837F996@codefountain.com>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 08:37:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7pJn-0002v0-QC
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 08:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWBKHhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 02:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWBKHhH
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 02:37:07 -0500
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:13500 "EHLO
	jnb-mailfw01.wbs.co.za") by vger.kernel.org with ESMTP
	id S932256AbWBKHhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 02:37:05 -0500
Received: from mail-02.jhb.wbs.co.za ([196.30.31.197])
  by jnb-mailfw01.wbs.co.za with ESMTP; 11 Feb 2006 09:36:44 +0200
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,104,1139176800"; 
   d="scan'208"; a="702548:sNHT21356951"
Received: from wbs-196-2-113-249.wbs.co.za ([196.2.113.249] helo=[172.17.17.2])
	by mail-02.jhb.wbs.co.za with esmtp (Exim 4.50)
	id 1F7pJC-0005hE-8z; Sat, 11 Feb 2006 09:36:43 +0200
In-Reply-To: <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.746.2)
X-Original-Subject: Re: Make "git clone" less of a deathly quiet experience
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15932>

On 11 Feb 2006, at 7:48 AM, Junio C Hamano wrote:
[snip]
> The real improvement, independent of this client-side patch,
> would be to reuse recently generated packs, but that needs
> writable cache directory on the server side.

Speaking of improvements, I've noticed that my attempts to track
the 2.6 kernel via the git protocol result in inefficiencies from time
to time when the connection hangs or is terminated when my
flakey wireless link goes down. When I restart the pull, the data
that has already been downloaded is lost and things start from
scratch which is painful if it's a big update.

It would be nice if the "partial pack" or whatever that has been
downloaded at the time of the breakage could be re-used and
things could start "from that point onwards" or the bits that were
already received could be unpacked. Comments?

Thank you,

--Craig
