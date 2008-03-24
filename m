From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merging git repositories history for full history of linux
Date: Mon, 24 Mar 2008 12:51:24 -0700
Message-ID: <7v63vbvr2b.fsf@gitster.siamese.dyndns.org>
References: <87iqzcne7b.fsf@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yoann Padioleau <padator@wanadoo.fr>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdsic-0002bf-V5
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYCXTvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYCXTvc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:51:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbYCXTvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:51:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABA1E1FEE;
	Mon, 24 Mar 2008 15:51:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 181831FEC; Mon, 24 Mar 2008 15:51:26 -0400 (EDT)
In-Reply-To: <87iqzcne7b.fsf@wanadoo.fr> (Yoann Padioleau's message of "Mon,
 24 Mar 2008 13:56:24 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78086>

Yoann Padioleau <padator@wanadoo.fr> writes:

> I would like to merge the 3 git repositories of the history
> of linux, the one by Dave Jones from linux 0.01 to linux 2.4.0, 
> the one by tglx from 2.4.0 to 2.6.12 and the one from 2.6.12
> by torvalds until the last version of Linux.

I think you can install two grafts (one that says the root in tglx history
has one parent that is tip of Dave Jones history, another that says that
the 2.6.12-rc2 commit which is the root in Linus history has one parent
that is near the tip of tglx history), and if you want the result to use
locally then you are done.  Otherwise you can run filter-branch on the
result, but the future commits from Linus tree will all be different.
