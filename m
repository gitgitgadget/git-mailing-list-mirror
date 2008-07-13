From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Improve responsiveness of git-log
 completion
Date: Sun, 13 Jul 2008 14:38:29 -0700
Message-ID: <7vy745piqy.fsf@gitster.siamese.dyndns.org>
References: <20080713023742.GA31760@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Ingo Molnar <mingo@elte.hu>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9I9-0004Cf-0j
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbYGMVij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbYGMVij
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:38:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbYGMVii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:38:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C07172AB09;
	Sun, 13 Jul 2008 17:38:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 274A12AB07; Sun, 13 Jul 2008 17:38:31 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D7708F6-5124-11DD-84A1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88344>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio noticed the bash completion has been taking a long time lately....

The credit actually goes to Ingo.

> Petr Baudis tracked it down to 72e5e989b ("bash: Add space after
> unique command name is completed.").  Tracing the code showed
> we spent significant time inside of this loop within __gitcomp,
> due to the string copying overhead....
> ...
>  Does this make things better?  Or worse?  I'm not seeing a huge
>  difference on my own system.  Maybe its too fast these days...

Ingo, I understand you have stopped using the completion long time ago due
to this latency issue.  Together with d773c63 (bash: offer only paths
after '--', 2008-07-08) that already is in 'maint' and 'master', this
hopefully would make the completion usable for you again?
