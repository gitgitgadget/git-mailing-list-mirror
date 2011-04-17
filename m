From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 4/5] Documentation: publicize KMail hints for sending patches inline
Date: Sun, 17 Apr 2011 15:57:21 +0200
Message-ID: <201104171559.17683.barra_cuda@katamail.com>
References: <87d3kq6tz7.fsf@rho.meyering.net> <20110415021100.GA19829@elie> <20110415023255.GE19829@elie>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 16:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBScv-0001eW-Ul
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 16:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab1DQOG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 10:06:58 -0400
Received: from smtp229-pc.aruba.it ([62.149.157.229]:34622 "HELO
	smtp1-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750803Ab1DQOG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 10:06:56 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Apr 2011 10:06:55 EDT
Received: (qmail 12881 invoked by uid 89); 17 Apr 2011 14:00:11 -0000
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on smtp1-pc.ad.aruba.it
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=BAYES_50,FREEMAIL_FROM
	autolearn=no version=3.3.1
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.67.13)
  by smtp1-pc.ad.aruba.it with SMTP; 17 Apr 2011 14:00:10 -0000
User-Agent: KMail/1.13.6 (Linux/2.6.38.3-mike-1mike; KDE/4.5.5; i686; ; )
In-Reply-To: <20110415023255.GE19829@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171720>

On Friday 15 April 2011, Jonathan Nieder wrote:
> I'm not sure what gotchas these hints are meant to work around.
> They might be completely false.

These suggestion are there to warn and help about space/word wrap
mangling, and to send a patch in the mail body (as per SubmittingPatches).

> A quick search for "how to send patches with KMail" gave me the
> "external editor" trick.  Do these instructions work? ;-)

They do work, but maybe they are not so important, since they're
helpful only for the one-time-hack-patch and I-don't-want-to-setup-
git-send-email.

When there are more than 3 or 4 patches to send, 'git send-email'
(plus msmtp, if needed) is more comfortable.

There is however, an helpful hint in http://wiki.winehq.org/GitWine
(never tried it, and I'd tend to prefer 'git send-email' anyway, don't
know if this should be mentioned in git docs):


	Using local KMail folders, you can use the following approach:

git format-patch --stdout --keep-subject origin | formail -s procmail

	Assuming you don't already use procmail to sort your email, you can
	use the following .procmailrc

:0
/home/username/.maildir/

	Now, all you need to do is to set up a new receiving account in
	KMail that collects mail from /home/username/.maildir and filter
	emails coming in on that account to your drafts folder. 
