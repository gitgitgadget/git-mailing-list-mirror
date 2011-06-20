From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with NO_NORETURN
Date: Tue, 21 Jun 2011 00:37:05 +0200
Message-ID: <20110620223705.GG32765@one.firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org> <1308445625-30667-2-git-send-email-andi@firstfloor.org> <7vsjr4b3tf.fsf@alter.siamese.dyndns.org> <20110620213001.GB32765@one.firstfloor.org> <7vfwn4b1vb.fsf@alter.siamese.dyndns.org> <20110620220347.GE32765@one.firstfloor.org> <20110620223156.GA695@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:37:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYn5j-0007FK-IT
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab1FTWhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:37:06 -0400
Received: from one.firstfloor.org ([213.235.205.2]:56325 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1FTWhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:37:06 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 355151A980FA; Tue, 21 Jun 2011 00:37:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110620223156.GA695@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176104>

> Please remember to think for yourself. ;-)  Junio generally gives good
> advice, but if you don't see the wisdom in it, that's the time to ask
> questions, not blindly do a wrong thing.

To be honest it's still not clear to me what was wrong with patch (2).

> 
> In this case, since the NO_NORETURN knob is to work around a gcc bug,
> wouldn't it make sense to add a -Wno-something-or-other option to
> BASIC_CFLAGS or COMPAT_CFLAGS when it is set?

The problem is that only relatively new gccs have options to do
fine grained control on all warnings. So this would add more complications
in the Makefile to check the compiler version

(I haven't checked if that's true for this particular warning,
but I have run into this several times in the past for others)

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
