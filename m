From: Thomas Lord <lord@emf.net>
Subject: arch 2.0 first source available (git related)
Date: Fri, 08 Jul 2005 17:12:27 -0700
Message-ID: <1120867947.5882.2.camel@dev1.seyza.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 09 02:16:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr30U-00011h-RX
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 02:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVGIANJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 20:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVGIANI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 20:13:08 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:30873 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S263016AbVGIAMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 20:12:10 -0400
Received: (qmail 45183 invoked from network); 9 Jul 2005 00:12:06 -0000
Received: from unknown (HELO adsl-69-236-65-185.dsl.pltn13.pacbell.net) (tom.lord@sbcglobal.net@69.236.65.185 with plain)
  by smtp112.sbc.mail.mud.yahoo.com with SMTP; 9 Jul 2005 00:12:06 -0000
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The first source release and some very early documentation for Arch 2.0
("revc") is now ready!

        Web page: <http://www.seyza.com/>

        Source: <http://www.seyza.com/releases/revc-0.0x0.tar.gz>

        Source (tar bundle) SHA1:
		9c279f78e57a99d517ccf5b983960620ff6f2cf7

        Source (tar bundle) size: 1732018

Some highlights:  revc has only 10 core commands;  there are about 165
functions; the source code is literally about 14K lines and is closer to
10K lines if you subtract out non-code boilerplate.

User complaints about tla 1.x being addressed in revc:

inventory is too complicated -- but is drastically simplified (almost
  eliminated) in 2.0

we hate the funny filenames -- 2.0 requires only a single .revc
  directory and you aren't expected to edit any files there.  No more
  {arch}, {arch}/=tagging-method, or deeply nested project-tree logs

the namespace blows -- 2.0 allows just about any revision name that
  doesn't contain a slash character.  There is a moderate limit on the
  length of a revision name.

all this stuff about registering archives and making mirrors is hard to
learn -- and, in 2.0, it's all gone.  You can use rsync to mirror stuff,
  for starters.  And all archives are anonymous -- there's no longer any
  such thing as an archive name.

too much is too slow -- although the 2.0 code isn't especially optimized
  yet, it seems to be hella snappy.

2.0 is very much git influenced but it brings some (imo significant)
  improvements to the table.

-t
