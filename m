From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: dry-run and verbose options for prune
Date: Sat, 15 May 2010 01:38:16 +0200
Message-ID: <201005150138.16618.johan@herland.net>
References: <ecbe317d2f12d83185f3c3242c0350051e3b4bfa.1273873273.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 15 01:40:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD4Ul-0007kz-6y
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 01:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759954Ab0ENXkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 19:40:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39310 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab0ENXkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 19:40:32 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L2F000VTOBT8FD0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 15 May 2010 01:38:17 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 805091EA5549_BEDDEE9B	for <git@vger.kernel.org>; Fri,
 14 May 2010 23:38:17 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 4574D1EA50A7_BEDDEE9F	for <git@vger.kernel.org>; Fri,
 14 May 2010 23:38:17 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L2F00BUYOBT6V10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 15 May 2010 01:38:17 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.3; x86_64; ; )
In-reply-to: <ecbe317d2f12d83185f3c3242c0350051e3b4bfa.1273873273.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147126>

On Friday 14 May 2010, Michael J Gruber wrote:
> Introduce -n and -v options for "git notes prune" in complete analogy to
> "git prune" so that one can check for dangling notes easily.
> 
> The output is a list of names of objects whose notes would be resp.
> are removed so that one can check the object ("git show sha1") as well as
> the note ("git notes show sha1").
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Love it! :)

Acked-by: Johan Herland <johan@herland.net>


Thanks!

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
