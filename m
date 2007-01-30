From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 14:38:17 -0600
Message-ID: <17855.44217.393543.893129@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<17855.36470.309129.391271@lisa.zopyra.com>
	<Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
	<200701301950.00195.jnareb@gmail.com>
	<Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
	<17855.39008.920685.62837@lisa.zopyra.com>
	<Pine.LNX.4.63.0701302013420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17855.40530.256749.539318@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 21:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBzkH-0002Z8-4f
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 21:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXA3UiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXA3UiV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 15:38:21 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60360 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXA3UiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 15:38:21 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UKcJV08674;
	Tue, 30 Jan 2007 14:38:19 -0600
In-Reply-To: <17855.40530.256749.539318@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38203>

Ok, in my own inimitable way, I think I have figured this out.  Please
let me know if this is dumb (output of commands below clipped):

% git --bare init-db --shared
% GIT_DIR=. git fetch git://source/public/project topic:topic
% cd there
% git clone /repos/git/project
% cd project
% git checkout topic
warning: You do not appear to currently be on a branch.
warning: Forcing checkout of topic^0.

If this is ok, this appears to give me the result I want ... I think.

Thanks to all for hand-holding the blind and if someone already mentioned
this option, apologies for missing it.


Bill

On Tuesday, January 30, 2007 at 13:36:50 (-0600) Bill Lear writes:
>On Tuesday, January 30, 2007 at 20:15:37 (+0100) Johannes Schindelin writes:
> ...
