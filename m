From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH] git pull cannot find remote refs.
Date: Tue, 28 Feb 2006 17:19:29 +0100
Organization: -no organization-
Message-ID: <20060228161928.GA4829@scotty.home>
References: <20060227214936.GA7205@scotty.home> <7vlkvwuvyl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 17:20:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE7ZX-0002bJ-F7
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 17:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWB1QTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 11:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWB1QTb
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 11:19:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:65522 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751853AbWB1QTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 11:19:31 -0500
Received: from [84.134.41.130] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis),
	id 0MKwh2-1FE7ZR2rjK-0008Gu; Tue, 28 Feb 2006 17:19:30 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3) with ESMTP id k1SGJUHu007963;
	Tue, 28 Feb 2006 17:19:30 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id k1SGJUZC007960;
	Tue, 28 Feb 2006 17:19:30 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkvwuvyl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16942>

Also sprach Junio C Hamano am Mon, 27 Feb 2006 at 17:13:22 -0800:

> ls-remote shows "SHA1\tPATH".  The original says "hexadecimal
> followed by [either a single space or a single tab] followed by

> difference.  Puzzled...

Grmph... You are right.

> I've seen two servers DNS round-robin and one of them fail to
> respond.  The first "fetch" goes to the good one and the second
> ls-remote goes to the bad one, then you would see "Oops, we
> cannot peek tags".  But this patch does not have anything to do
> with that problem..

Trapped. I haven't seen this, but perhaps it was the problem. 
I'll watching for the next occurence.


Sorry for the noise.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
