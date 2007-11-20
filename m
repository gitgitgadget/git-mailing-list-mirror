From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH] autoconf: Add tests for memmem, strtoumax and mkdtemp
	functions
Date: Tue, 20 Nov 2007 19:12:02 +0100
Organization: -no organization-
Message-ID: <20071120181202.GA12389@scotty.home>
References: <200711191947.05960.jnareb@gmail.com> <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXbZ-0004TW-OX
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXKTSN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbXKTSN1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:13:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:50195 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbXKTSN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:13:26 -0500
Received: from scotty.home (p548602B4.dip0.t-ipconnect.de [84.134.2.180])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1IuXa62DfX-0006Rl; Tue, 20 Nov 2007 19:12:19 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.8/8.13.8/Debian-3) with ESMTP id lAKIC2tZ013656;
	Tue, 20 Nov 2007 19:12:02 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.8/8.13.8/Submit) id lAKIC2pi013653;
	Tue, 20 Nov 2007 19:12:02 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
	F986 E4FC D563
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on scotty.home
X-Virus-Scanned: ClamAV 0.91.2/4855/Tue Nov 20 10:49:20 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/Ln8UJXugnyklKx4loLhY3/UZ9CptkoDWMgjT
 JpC6aPylH5anprqo3DZb1IHKNmY5yvN2Y0js93PYdt9yQGriz5
 mX2+rswNEPKGcAFYitSmw+4mgTxoPzp
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65555>

Also sprach Junio C Hamano am Tue, 20 Nov 2007 at 01:00:44 -0800:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > By the way, do you have idea how to test for the following
> > in configure.ac:
> >
> > * Define NO_PREAD if you have a problem with pread() system call (e.g.
> >   cygwin.dll before v1.5.22).
> >
> >   - what is the problem? how to detect it?
> 
> 6900679c2f6d937a5a6ef616869c8887690ad19d (Replacing the system
> call pread() with lseek()/xread()/lseek() sequence.)
> 

For me it happened when using git (e.g. git commit). Detecting perhaps
is possible with "cygcheck" command which shows the version of cygwin
system dlls.

Perhaps: cygcheck -p 'cygwin1.dll'
Shows name and version of found cygwin1.dll.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
