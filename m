From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch.sh: Allow running in bare repositories
Date: Tue, 22 Jul 2008 17:09:51 -0700
Message-ID: <7v8wvtjwa8.fsf@gitster.siamese.dyndns.org>
References: <20080722223710.29084.61373.stgit@localhost>
 <alpine.DEB.1.00.0807230025050.8986@racer>
 <20080722233652.GT10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRwg-0004ZD-8x
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYGWAKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbYGWAKG
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:10:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbYGWAKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:10:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 104093AC7A;
	Tue, 22 Jul 2008 20:10:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8EDB13AC73; Tue, 22 Jul 2008 20:09:58 -0400 (EDT)
In-Reply-To: <20080722233652.GT10151@machine.or.cz> (Petr Baudis's message of
 "Wed, 23 Jul 2008 01:36:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B30985E0-584B-11DD-88FE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89572>

Petr Baudis <pasky@suse.cz> writes:

>   um, oops. I actually never got to know these by heart since I learnt
> to expliciply group the expressions early on. I guess my only excuse is
> that I've stumbled at 0bdf93cbf earlier and understood it the _wrong_
> way around since I'm getting really sleepy. ;-)
>
>   I still think my change improves the code readibility so it could be
> kept, but I'm fairly neutral on this.

I cannot be neutral when a patch introduces unnecessary fork.

The quality of shell scripts in git.git seems to have deteriorated over
time but I do not think we would want to spend too much maintainer time to
go back and fix all of them.  Please don't make things worse, at least.
