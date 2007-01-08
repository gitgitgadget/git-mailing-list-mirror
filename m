From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH] Test for failing pread() on cygwin.
Date: Mon, 8 Jan 2007 18:09:04 +0100
Organization: -no organization-
Message-ID: <20070108170904.GA8086@scotty.home>
References: <stefan.hahn@s-hahn.de> <20070107111841.GC9909@scotty.home> <200701080019.l080JW10018679@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 18:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3xzx-0004KQ-2F
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 18:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbXAHRJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXAHRJW
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 12:09:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63260 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXAHRJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 12:09:21 -0500
Received: from [84.134.49.142] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis),
	id 0ML29c-1H3xza2ljf-0007sW; Mon, 08 Jan 2007 18:09:04 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l08H94nb010446;
	Mon, 8 Jan 2007 18:09:04 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l08H94XL010443;
	Mon, 8 Jan 2007 18:09:04 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200701080019.l080JW10018679@laptop13.inf.utfsm.cl>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-0.0 required=5.0 tests=ALL_TRUSTED,
	UNWANTED_LANGUAGE_BODY autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.7/2424/Mon Jan  8 17:46:49 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36272>

Also sprach Horst H. von Brand am Sun, 07 Jan 2007 at 21:19:32 -0300:

> > +GIT_AUTHOR_EMAIL=xxxxxxxx@yyyyyyyy.yyyyy.yyyyyyy.yyy
> 
> Why not the standard "Random J. User" <rju@example.com>? ;-)

Just, because the length of the strings plays a role. With the strings
defined in test_lib there were no errors.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
