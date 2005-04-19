From: Christian Meder <chris@absolutegiganten.org>
Subject: wit - a git web interface
Date: Tue, 19 Apr 2005 16:04:03 +0200
Message-ID: <1113919443.3192.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 16:05:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNtGs-0006Y5-Az
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 16:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVDSOEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 10:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVDSOEP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 10:04:15 -0400
Received: from shadow.prohost.de ([216.71.84.228]:5470 "EHLO shadow.prohost.de")
	by vger.kernel.org with ESMTP id S261531AbVDSOEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 10:04:09 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3JE48618560
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 16:04:08 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I uploaded a first draft of wit to
http://www.absolutegiganten.org/wit

Right now it's a minimal web interface on top of git. Unpack it, make
sure you've got at least Python 2.3, optionally install c2html, adjust
config.py and start from the root with
$ PYTHONPATH=. python git/web/wit.py
Point your browser to http://localhost:8090

I append my random notes about this thing:

* wit was built with git 075930771b68528ae13630375df2fe634e9ac610 which
is 2-3 days old, it's untested with newer gits, it's functional for me

* philosophy: provide a git repository browser and show the basic types
of git under appropriate URIs like
/commit/head, /commit/<sha1>, /tree/head, /tree/<sha1>, /blob/<sha1>
and encode operations in URIs like /tree/<sha1>/tarball

* the html is probably invalid and looks like crap

* it's just sitting on top of git because that's the least moving part
of git right now (hah), no usage of git-pasky yet

* it's done with quixote 2.0 which is included

* don't use it on a kernel tree or you will experience slowness beyond
your wildest dreams

* it doesn't use revision.h or other lighning fast C goodies until the
dust settles down

* it'll probably eat your dog and falls apart when blowing at it

* I happen to think that it's a nice start

Any and all feedback is greatly appreciated.

Greetings,



				Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

