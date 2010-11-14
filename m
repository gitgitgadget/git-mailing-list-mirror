From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv6 06/23] notes.h/c: Propagate combine_notes_fn return value
 to add_note() and beyond
Date: Mon, 15 Nov 2010 00:50:26 +0100
Message-ID: <201011150050.27131.johan@herland.net>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
 <AANLkTinQhkXvfa0BS0dFK6-mXFpU+uQ=rKRJ1QaXXA1S@mail.gmail.com>
 <20101114212243.GC10150@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 00:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHmLD-0002tB-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 00:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab0KNXub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 18:50:31 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61758 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab0KNXub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 18:50:31 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBW00H75FK5L600@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 15 Nov 2010 00:50:29 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 0AB161799A91_CE075C5B	for <git@vger.kernel.org>; Sun,
 14 Nov 2010 23:50:29 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id F05141796535_CE075C4F	for <git@vger.kernel.org>; Sun,
 14 Nov 2010 23:50:28 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBW002ZBFK4XS20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 15 Nov 2010 00:50:28 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.3; x86_64; ; )
In-reply-to: <20101114212243.GC10150@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161463>

On Sunday 14 November 2010, Jonathan Nieder wrote:
> Thiago Farina wrote:
> > On Tue, Nov 9, 2010 at 7:49 PM, Johan Herland <johan@herland.net> wrote:
> >>               die("confused: combine_notes_overwrite failed");
> > 
> > This message looks like more a debug information. Could it be
> > rewritten to be more user friendly / more informative?
> 
> Sverre mentioned the same thing.  The intent is the same as the existing
> 
> 		die("should not happen, someone must be hit on the forehead");
> 
> --- i.e., to provoke bug reports if it happens, without the appearance
> of begging. :)
> 
> So how about:
> 
> 		die("BUG: combine_notes_overwrite failed");
> 
> Something involving assert() could also work, but that tends to be
> a bit ugly.

Agreed. I've rewritten the die() messages in the following v6.1 patches.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
