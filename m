From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: Recover broken git repository?
Date: Tue, 14 Jul 2009 19:52:45 +0200
Organization: -no organization-
Message-ID: <20090714175245.GD9919@scotty.home>
References: <1247577632053-3255106.post@n2.nabble.com> <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Florian Breitwieser <florian.bw@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 19:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQmC2-0004Nh-9r
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 19:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbZGNRws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 13:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbZGNRws
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 13:52:48 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:51726 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbZGNRwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 13:52:47 -0400
Received: from scotty.home (port-92-206-225-9.dynamic.qsc.de [92.206.225.9])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MKt2u-1MQmBK3EGM-000Adk; Tue, 14 Jul 2009 19:52:47 +0200
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id n6EHqj4C001754;
	Tue, 14 Jul 2009 19:52:45 +0200
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id n6EHqjFj001749;
	Tue, 14 Jul 2009 19:52:45 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907141019380.13838@localhost.localdomain>
X-Mailer: Mutt 1.5.18 http://www.mutt.org/
X-Editor: GNU Emacs 22.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
	F986 E4FC D563
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: ClamAV 0.94.2/9564/Tue Jul 14 18:22:26 2009 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/K+leEt2Q5Y5mPaepHsjrPYUojMw4dFdXHaVW
 E4yCZYWrR6BJXC5PBk/Sk0+T4bXSj9kpamCyduFI8j1F8hZGKK
 GD6yOYOvaXibNOSHX+Cgw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123262>

Also sprach Linus Torvalds am Tue, 14 Jul 2009 at 10:33:58 -0700:

Hi,

> > $ git commit -m "Some message"
> > error: invalid object 1086b1c606a04bcb78b92d1d411a299d20d18034
> > fatal: Error building trees

I've trapped in a similar problem few days ago on windows using
cygwin.

A simple "git status" told me an invalid object. Just doing
git status corrupted the index file and only this. The reason was a
wrong configured (unseen reconfigured from another script) mount via
cygwin using "textmode" not "binary mode".

After remounting with "binary mode" a simple "git read-tree HEAD"
repaired it. Just the index file had been corrupted.


Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

Please note that according to the German law on data retention,
information on every electronic information exchange with me is
retained for a period of six months.
Bundesgesetzblatt:
http://www.bgblportal.de/BGBL/bgbl1f/bgbl107s3198.pdf
