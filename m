From: Francois Pepin <fpepin@cs.mcgill.ca>
Subject: Re: corrupted repository?
Date: Thu, 02 Oct 2008 14:03:05 -0400
Message-ID: <48E50CD9.9050907@cs.mcgill.ca>
References: <48E3EBC2.7090107@cs.mcgill.ca> <20081002142952.GP21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 20:04:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlSXa-0001By-Hh
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 20:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbYJBSDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYJBSDR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 14:03:17 -0400
Received: from torrent.CC.McGill.CA ([132.206.27.49]:38631 "EHLO
	torrent.cc.mcgill.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbYJBSDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 14:03:16 -0400
Received: from mailscan3.ncs.mcgill.ca (mailscan3.NCS.McGill.CA [132.216.77.250])
	by torrent.cc.mcgill.ca (8.12.11.20060308/8.12.3) with ESMTP id m92I3CwV030447;
	Thu, 2 Oct 2008 14:03:12 -0400
Received: from mailscan3.ncs.mcgill.ca (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 50C89346B;
	Thu,  2 Oct 2008 14:03:06 -0400 (EDT)
Received: from monch.mcb.mcgill.ca (monch.MCB.McGill.CA [132.206.211.134])
	by mailscan3.ncs.mcgill.ca (Postfix) with ESMTP id F3F0D6B9A;
	Thu,  2 Oct 2008 14:03:05 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20081002142952.GP21310@spearce.org>
X-PMX-Version: 5.4.2.338381, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.9.28.155531
X-McGill-WhereFrom: Internal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97363>

 > Your git-upload-pack cannot find git-pack-objects.  It sounds like
 > Git was incorrectly installed on your system.

You are correct. I had created some symlinks for the binaries because 
the changes for the environment variable didn't see to work for me, 
either from the installer package or editing the 
~/.MacOSX/environment.plist. I had a link to git-upload-pack in /usr/bin 
but none to git, thereby creating the issue.

I'm a bit confused as to how it happened, but's all been fixed and I'm a 
happy camper again.

Thanks for the help,

Francois
