From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 05/10] pack-objects: Teach new option --max-commit-count,
 limiting #commits in pack
Date: Tue, 24 May 2011 02:18:21 +0200
Message-ID: <201105240218.22030.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-6-git-send-email-johan@herland.net>
 <7v4o4lt3bh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 02:18:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfKU-0002uD-CM
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873Ab1EXASZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:18:25 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43732 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757865Ab1EXASY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:18:24 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00BWJBIN3160@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 02:18:23 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A7991179973F_DDAF94FB	for <git@vger.kernel.org>; Tue,
 24 May 2011 00:18:23 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 14D491796B13_DDAF94FF	for <git@vger.kernel.org>; Tue,
 24 May 2011 00:18:23 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00KSRBIMF910@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 02:18:23 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7v4o4lt3bh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174300>

On Tuesday 24 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > The new --max-commit-count option behaves similarly to
> > --max-object-count,
> 
> Hmm?
> 
> Do we have --max-object-count at this point in the series, or am I
> missing a patch?

No, I dropped --max-object-count. Will update this commit message in the 
next iteration.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
