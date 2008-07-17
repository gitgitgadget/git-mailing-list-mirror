From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 23:53:55 -0700
Message-ID: <7vej5tknlo.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807170100320.4318@eeepc-johanness>
 <7vk5flo0si.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807170152190.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 08:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJNOJ-0005Sk-84
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 08:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbYGQGyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 02:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYGQGyD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 02:54:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbYGQGyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 02:54:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D4AE269DD;
	Thu, 17 Jul 2008 02:54:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B49EB269DB; Thu, 17 Jul 2008 02:53:57 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807170152190.4318@eeepc-johanness> (Johannes
 Schindelin's message of "Thu, 17 Jul 2008 02:02:04 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22879D2C-53CD-11DD-81B9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88808>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > However, my point was about telling users, especially new ones.
>> 
>> Perhaps you did not read my first paragraph?
>
> Well, I did.

Then perhaps I wasn't being clear, and I think we are saying the same
thing.

> Sure, advanced usage is nice, and often involves plumbing, especially for 
> scripting.

That is not what I am saying.  What I am saying actually is that these
usage that _need_ to involve plumbing is not "advanced", but merely
showing weakness of the current Porcelain.  Fixing that would allow us
move further away from having to resort to plumbing in our daily
workflow.

Perhaps our Porcelains already passed that point, in which case you do not
have to touch the plumbing commands 99% of time during the day and you do
not have to teach new people plumbing at all.  I am agreeing that it would
be a worthy goal to aim for -- I do not however think we are there yet.
