From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 23:53:13 +0200
Message-ID: <87tze7qbsm.fsf@cup.kalibalik.dk>
References: <20080730051059.GA4497@sigill.intra.peff.net>
	<1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
	<E2809CE9-1DEB-48DA-8E42-8BEAB376FED2@silverinsanity.com>
	<32541b130807301409t2f1f3a80n44c62447c628f03a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brian Gernhardt" <benji@silverinsanity.com>, git@vger.kernel.org,
	gitster@pobox.com, peff@peff.net
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJcl-0007TL-3J
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbYG3VxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758358AbYG3VxS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:53:18 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:46946 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757854AbYG3VxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:53:18 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id EEFEC14062;
	Wed, 30 Jul 2008 23:53:14 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 2CAD31405A;
	Wed, 30 Jul 2008 23:53:12 +0200 (CEST)
In-Reply-To: <32541b130807301409t2f1f3a80n44c62447c628f03a@mail.gmail.com> (Avery Pennarun's message of "Wed\, 30 Jul 2008 17\:09\:13 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90862>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> The patch uses a non-zero exit code, which is an error status. But
> as that's the case, I'm not sure why it's described in the changelog
> as treating it "not as an error."

A matter of terminology, I guess. Apologies if I used the wrong word.

I figured that a non-zero return value was not necessarily an error,
but could also be an unusual exit. Like when calling "git" for help.

However, printing out "fatal:" and a lowercase note is definitely an
error situation.


Cheers,
Anders.
