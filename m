From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 18:29:32 +0900
Message-ID: <buozlxfeu0z.fsf@dhapc248.dev.necel.com>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
	<7voddv6fxz.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 10:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isb3O-0004Ic-JI
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbXKOJaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbXKOJaN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:30:13 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:48667 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbXKOJaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:30:12 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAF9TWd2011102;
	Thu, 15 Nov 2007 18:29:33 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Thu, 15 Nov 2007 18:29:33 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Thu, 15 Nov 2007 18:29:32 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 8847743B; Thu, 15 Nov 2007 18:29:33 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <7voddv6fxz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 15 Nov 2007 01\:00\:56 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65098>

Junio C Hamano <gitster@pobox.com> writes:
> We do not need to pipe "echo" to "sed" only to strip refs/heads/
> from the beginning.  We are assuming not-so-ancient shells these
> days.

What's wrong with sed?

-Miles

-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that
            will  make every christian in the world foamm at the mouth?
[iddt]      nurg, that's the goal
