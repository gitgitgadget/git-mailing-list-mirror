From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 23:44:26 +0200
Message-ID: <201103292344.26249.johan@herland.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <7vwrjhrd53.fsf@alter.siamese.dyndns.org>
 <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 23:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4giO-0007VH-3x
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 23:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab1C2Vob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 17:44:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33388 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab1C2Voa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 17:44:30 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU006E39Q4Q410@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 29 Mar 2011 23:44:28 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DFF7F1EEFDBD_D9252BBB	for <git@vger.kernel.org>; Tue,
 29 Mar 2011 21:44:27 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id CFB041EEFD77_D9252BBF	for <git@vger.kernel.org>; Tue,
 29 Mar 2011 21:44:27 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIU008DR9Q2KV20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 29 Mar 2011 23:44:27 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170329>

On Tuesday 29 March 2011, Jeff King wrote:
> Here's the series I ended up with. Getting the refactoring just right
> turned out to be non-trivial, but between several attempts and some
> tests, I think the end result is correct. Hopefully the breakdown of the
> changes into small patches helps make it easy to review.
> 
>   [1/6]: notes: make expand_notes_ref globally accessible
>   [2/6]: revision.c: refactor notes ref expansion
>   [3/6]: notes: refactor display notes extra refs field
>   [4/6]: notes: refactor display notes default handling
>   [5/6]: revision.c: support --notes command-line option
>   [6/6]: revision.c: make --no-notes reset --notes list

Indeed, the whole series looks good to me.

Acked-by: Johan Herland <johan@herland.net>


Thanks! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
