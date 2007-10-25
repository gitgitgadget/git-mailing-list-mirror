From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 2/7] s/pattern/prefix/ in help's list_commands
Date: Wed, 24 Oct 2007 21:53:50 -0700
Message-ID: <20071025045349.GF759@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net> <1193283437-1706-2-git-send-email-srp@srparish.net> <7v640v3ix1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkujK-0002W5-Qo
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 06:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXJYExv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 00:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbXJYExv
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 00:53:51 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:33488 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXJYExu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 00:53:50 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1Ikuj7-0003Nf-H0; Wed, 24 Oct 2007 23:53:50 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Wed, 24 Oct 2007 21:53:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v640v3ix1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62273>

On Wed, Oct 24, 2007 at 09:41:30PM -0700, Junio C Hamano wrote:

> Scott R Parish <srp@srparish.net> writes:
> 
> > list_commands() currently accepts and ignores a "pattern" argument,
> > and then hard codes a prefix as well as some magic numbers.
> 
> Correct observation.
> 
> Personally, I find this static function should not pretend to be
> as flexible --- it is to list git subcommands anyway (and it
> even knows about ".exe"), so rather than renaming the pattern
> and using it, it might be simpler and cleaner to just drop the
> parameter and be done with it.

Nice, i like that even better

sRp

-- 
Scott Parish
http://srparish.net/
