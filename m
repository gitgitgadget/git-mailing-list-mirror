From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: problem with git clone on cygwin
Date: Sun, 7 Jan 2007 12:21:07 +0100
Organization: -no organization-
Message-ID: <20070107112107.GD9909@scotty.home>
References: <20070106170330.GA8041@scotty.home> <17824.5988.344000.501073@lapjr.intranet.kiel.bmiag.de> <20070106215919.GB8041@scotty.home> <20070107093015.GA9909@scotty.home> <17824.53141.207000.935133@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 12:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3W5S-0002Ei-F3
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbXAGLVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbXAGLVM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:21:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:56976 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbXAGLVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:21:11 -0500
Received: from [84.134.15.225] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis),
	id 0ML25U-1H3W5N0wrG-0001Vz; Sun, 07 Jan 2007 12:21:09 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l07BL7rY015758;
	Sun, 7 Jan 2007 12:21:07 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l07BL7cC015755;
	Sun, 7 Jan 2007 12:21:07 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: Juergen Ruehle <j.ruehle@bmiag.de>
Content-Disposition: inline
In-Reply-To: <17824.53141.207000.935133@lapjr.intranet.kiel.bmiag.de>
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
X-Virus-Scanned: ClamAV 0.88.7/2418/Sun Jan  7 10:42:41 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36158>

Also sprach Juergen Ruehle am Sun, 07 Jan 2007 at 11:46:45 +0100:
> Stefan-W. Hahn writes:

> cygwin. But my question was meant more along the lines of 'could you
> give some examples of applications that do not work with 1.5.22 or
> later and prevent you from upgrading your installed cygwin version'.

Non, its just the above metioned incompatibility between the cygwin
versions.

> If there are serious showstoppers it would probably be a good idea to
> go the route Shawn outlined to retain compatibility with earlier
> cygwin releases. Otherwise we'll just keep recommending an upgrade:-)

I sent out a patch using mmap() instead of pread() if configured.

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
