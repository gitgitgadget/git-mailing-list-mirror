From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Has the git shell revert been done so master should work?
Date: Sun, 24 Aug 2008 17:27:47 -0700
Message-ID: <7vd4jyj5vg.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 02:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXPyE-00065y-3M
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 02:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYHYA1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 20:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYHYA1y
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 20:27:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYHYA1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 20:27:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ECD3266D73;
	Sun, 24 Aug 2008 20:27:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 226DA66D72; Sun, 24 Aug 2008 20:27:49 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com> (Boyd Lynn
 Gerber's message of "Sun, 24 Aug 2008 07:02:38 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7C9B974-723C-11DD-9385-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93578>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> I just did a clean clone of git git and, I am still seeing failures on all 
> platforms I made work.

I've been waiting to hear from you for a success/failure report since you
were suggested to try the workaround that was queued in 'next' for the
first time (I think it was Mike Ralphson on Thu 21st), before moving it to
'master', as platforms with sane linkers do not seem to need it.

I see Jeff again suggested you to try cherry-picking the workaround today.
Did it work for you?
