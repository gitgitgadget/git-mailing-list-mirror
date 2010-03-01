From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/12] add --ff option to cherry-pick
Date: Mon, 1 Mar 2010 08:00:13 +0100
Message-ID: <201003010800.13996.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org> <7v3a0kg0qv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 08:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlzcG-0005mZ-Eb
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 08:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab0CAHA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 02:00:28 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38186 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab0CAHA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 02:00:27 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E82898180BE;
	Mon,  1 Mar 2010 08:00:17 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C145D818079;
	Mon,  1 Mar 2010 08:00:14 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7v3a0kg0qv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141301>

On Monday 01 March 2010 04:49:12 Junio C Hamano wrote:
> Thanks, but this seems to conflict with too many things in flight (it
> applies cleanly on top of 'pu' but not on top of 'next').
> 
> Given that "rebase--interactive", which is the sole in-tree user of
> cherry-pick, has its own fast-forwarding logic to skip call to it, it
> seems to take too much time out of me to deal with the code churn for
> dubious benefit---the series does not seem to solve any real problem.
> 
> After other topics have either graduated to 'master' or dropped out of
> 'pu', things might look differently, though.
 
Ok I will wait for something like a week, and then rebase on top of next and 
resend.

Thanks,
Christian.
