From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found  by the clang static analyzer
Date: Sat, 26 Sep 2009 20:46:45 +0200
Message-ID: <87ws3lczmy.fsf@master.homenet>
References: <87ab0hepcn.fsf@master.homenet>
	<alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	<871vltefdj.fsf@master.homenet>
	<fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 20:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrcJX-0000C6-Jz
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 20:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbZIZSrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 14:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZIZSrm
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 14:47:42 -0400
Received: from joe.mail.tiscali.it ([213.205.33.54]:35328 "EHLO
	joe.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZIZSrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 14:47:42 -0400
Received: from master.homenet (84.223.203.227) by joe.mail.tiscali.it (8.0.022)
        id 49EC55CD047B24DE; Sat, 26 Sep 2009 20:47:44 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1MrcIC-0002q4-5Z; Sat, 26 Sep 2009 20:46:48 +0200
In-Reply-To: <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	(Sverre Rabbelier's message of "Sat, 26 Sep 2009 20:34:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129166>

Hello,

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Then it would probably have been better to say so by at least marking
> your patch as RFC and including such a remark in the cover letter, no?
> Also, now that this has been pointed out, you shouldn't expect it to
> be included until someone either takes your patch and cleans it up (as
> in, checks all statements manually), or until you do so yourself.

I really had to include a RFC remark.  After what Johannes reported, I
think there is need only to restore assignments to argc while other ones
can be dropped without problems.  I'll post a cleaned patch later.

Cheers,
Giuseppe
