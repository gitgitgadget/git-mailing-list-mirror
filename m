From: Johan Herland <johan@herland.net>
Subject: Re: [WIP/RFC 00/13] git notes merge
Date: Sun, 25 Jul 2010 18:44:32 +0200
Message-ID: <201007251844.32542.johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
 <1280054725.2196.40.camel@arcturus>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 18:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od4Jd-0001w3-JX
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 18:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab0GYQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 12:44:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33633 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab0GYQog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 12:44:36 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6400A5KH69WA30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 18:44:33 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 0FA981EA53B0_C4C69F1B	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 16:44:33 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id EA8AB1EA2A9D_C4C69F0F	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 16:44:32 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6400MAHH682910@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 18:44:32 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <1280054725.2196.40.camel@arcturus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151759>

On Sunday 25 July 2010, Sam Vilain wrote:
> On Fri, 2010-07-23 at 12:14 +0200, Johan Herland wrote:
> > Hi,
> > 
> > Here are some rough patches implementing most of the 'git notes merge'
> > functionality. There are still missing pieces in the area of manual
> > conflict resolution, but what's here should be enough to start
> > experimenting with automatic notes merge resolution.
> 
> Having implemented this before as a client-level solution I can applaud
> the goal of tackling this.
> 
> There is also the issue of making the notes track automatically on 'git
> clone' or something like that, don't know if anyone's looked at it yet
> but that's another annoyance I've had..

Agreed, although I see the solving the merge problem as a prerequisite to 
dealing with exchanging notes between repos. One thing at a time...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
