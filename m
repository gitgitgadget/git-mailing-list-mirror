From: Miles Bader <miles@gnu.org>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Thu, 03 Feb 2011 17:09:00 +0900
Message-ID: <buo39o535gj.fsf@dhlpc061.dev.necel.com>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 09:09:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkuFj-0000kX-CN
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 09:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab1BCIJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 03:09:14 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:53876 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab1BCIJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 03:09:13 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p13892iQ029688;
	Thu, 3 Feb 2011 17:09:02 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p13892L05926; Thu, 3 Feb 2011 17:09:02 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.54])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id p1388DL7000446;
	Thu, 3 Feb 2011 17:09:02 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Thu, 3 Feb 2011 17:09:01 +0900
Received: from dhlpc061 ([10.114.98.26] [10.114.98.26]) by relay41.aps.necel.com with ESMTP; Thu, 3 Feb 2011 17:09:01 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6ECD052E1D4; Thu,  3 Feb 2011 17:09:01 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <alpine.LFD.2.00.1102030036420.12104@xanadu.home> (Nicolas
	Pitre's message of "Thu, 03 Feb 2011 01:16:10 -0500 (EST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165964>

Nicolas Pitre <nico@fluxnic.net> writes:
>> But just moving the whole existing pile into a subdirectory "because
>> everyone else does it" is not a reason; that's superstition.
>
> There is no superstition here, simply basic elegance.

"basic elegance" is hardly well-defined, and although there are probably
issues on which there's general agreement, this doesn't appear to be one
of them.

>> Having to type "src/" a lot more often is definitely a downside.
>
> Come on.  This is a rather egocentric argument without much substance.

It certainly has more substance than hand-waving like "basic elegance"
though...

Some slightly more concrete arguments have been:

  Pro-src:  Big top-level dir scares newbs
  Anti-src: Extra typing is annoying

I'm not really against a "src/" subdir, but it seems mostly a matter of
taste, and I've seen plenty of projects where the src/ directory seemed
pretty pointless...

-Miles

-- 
Politics, n. A strife of interests masquerading as a contest of
principles. The conduct of public affairs for private advantage.
