From: Johan Herland <johan@herland.net>
Subject: Re: [WIP/RFC 12/13] git notes merge: Add automatic conflict resolvers
 (ours, theirs, union)
Date: Sun, 25 Jul 2010 20:58:02 +0200
Message-ID: <201007252058.02964.johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
 <1279880104-29796-13-git-send-email-johan@herland.net>
 <4C4AA1C3.8030907@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 20:58:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od6Oy-0003oG-E0
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 20:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab0GYS6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 14:58:15 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41732 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab0GYS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 14:58:15 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6400ARSND0WAA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 20:58:12 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 945951EA5540_C4C8944B	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 18:58:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4CB801EA4004_C4C893BF	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 18:58:03 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6400E90NCRQT10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 20:58:03 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <4C4AA1C3.8030907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151778>

On Saturday 24 July 2010, Stephen Boyd wrote:
>   On 07/23/2010 03:15 AM, Johan Herland wrote:
> > +
> > +# Set up a notes merge scenario with all kinds of potential conflicts
> > +test_expect_success 'setup commits' '
> > +	# Create 15 commits with tags ("1st" through "15th")
> > [...]
> 
> Can you use test_commit here?

Yes, indeed. Thanks for noticing. I've rewritten the tests using
test_commit (and using variables to store commit SHA1s, so that the
tests are more robust against those changing)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
