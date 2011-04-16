From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sat, 16 Apr 2011 21:12:00 +0400
Organization: '
Message-ID: <20110416171200.GB8201@external.screwed.box>
References: <201102142039.59416.jnareb@gmail.com>
 <201104141154.55078.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 19:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB9Ch-0007yJ-2Y
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 19:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab1DPRWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 13:22:35 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:64112 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab1DPRWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 13:22:33 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Apr 2011 13:22:33 EDT
Received: from localhost (raidz.torservers.net [46.19.138.242])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 250285B11;
	Sat, 16 Apr 2011 20:48:10 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201104141154.55078.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171685>

Any time of year you can find me here Jakub.
2011/04/14 11:54:53 +0200 Jakub Narebski <jnareb@gmail.com> => To git@vger.kernel.org :
JN> So what are your ideas and comments on the issue of JavaScript code
JN> and JavaScript libraries / frameworks in gitweb?

I'd like to note here that js use intensification may be need to be kept
separated from extending of the http functions of the regular git use which I
believe is currnt;y implemented by mean of gitweb.
E. g., I think one day we shall be able to git-push, etc. to http(s) git
repository via http(s) the same way we can already git-fetch today. This is
another, less explicit way the gitweb is and will be being used, right?  Having
that in mind I suppose some parts of gitweb development, e. g. code and/or docs
may need to be separated like it is done now for cli interface, the porcelain
versus plumbing, as both cli and the web can be considered to be the interfaces

One day it will be obvious for the non-interactive web clients like git to have
the js capabilities embedded. This will mean we perhaps will have technology
other than js for such a separation. But I believe gitweb will have js for ui
somewhat earlier.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
