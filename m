From: Miles Bader <miles.bader@necel.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 16:29:19 +0900
Message-ID: <buo1w8gnc4w.fsf@dhapc248.dev.necel.com>
References: <478E1FED.5010801@web.de>
	<alpine.LSU.1.00.0801161531030.17650@racer.site>
	<427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 08:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFPCY-00065n-JN
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 08:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbYAQH3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 02:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbYAQH3p
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 02:29:45 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:35735 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYAQH3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 02:29:44 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m0H7TK85008653;
	Thu, 17 Jan 2008 16:29:20 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay31.aps.necel.com with ESMTP; Thu, 17 Jan 2008 16:29:20 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Thu, 17 Jan 2008 16:29:20 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id D48F73A4; Thu, 17 Jan 2008 16:29:19 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org> (Kevin Ballard's
	message of "Wed, 16 Jan 2008 10:43:24 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70836>

Kevin Ballard <kevin@sb.org> writes:
> More like, Mac OS X has standardized on Unicode and the rest of the
> world hasn't caught up yet. Git is the only tool I've ever heard of
> that has a problem with OS X using Unicode.

Apple's decision[*] to use _decomposed_ unicode causes all sorts of
little problems because other tools aren't expecting to see strings
changed behind their backs.

I know little about the gritty details, but I see the bug reports...

-Miles

-- 
Any man who is a triangle, has thee right, when in Cartesian Space, to
have angles, which when summed, come to know more, nor no less, than
nine score degrees, should he so wish.  [TEMPLE OV THEE LEMUR]
.
