From: Andreas Mohr <andi@lisas.de>
Subject: Wishlist: git help bisect should mention "stop" keyword
Date: Sat, 9 Feb 2013 09:44:03 +0100
Message-ID: <20130209084403.GA14356@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 09:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4636-0007uj-2P
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 09:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab3BIIoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 03:44:07 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:44509 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab3BIIoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 03:44:06 -0500
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id B6110A2C52; Sat,  9 Feb 2013 09:44:03 +0100 (CET)
Content-Disposition: inline
X-Priority: none
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215856>

Hi,

the man page (git version 1.7.10.4) is a bit non-symmetric
since git bisect has the start param, but when searching for "stop"
(nothing more obvious than that, right?),
one comes up empty --> usability issue.

The appropriate action complementary to start appears to be
git bisect reset, thus its description definitely ought to include a "stop"
keyword.

Description as of 1.7.10.4 is

       After a bisect session, to clean up the bisection state and
return to
       the original HEAD, issue the following command:

           $ git bisect reset

which could be changed into

       After a bisect session, to clean up the bisection state and
return to
       the original HEAD (in other words, to "stop" bisect),
       issue the following command:

           $ git bisect reset

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.
