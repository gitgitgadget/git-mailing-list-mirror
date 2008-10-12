From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: git status options feature suggestion
Date: Sat, 11 Oct 2008 23:41:18 -0700
Message-ID: <7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
 <20081009061136.GA24288@coredump.intra.peff.net>
 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <48EE1F58.2060707@drmicha.warpmail.net>
 <20081012044900.GA27845@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 08:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kouga-0007ga-W6
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 08:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYJLGle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 02:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbYJLGle
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 02:41:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYJLGld (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 02:41:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 323F46DA38;
	Sun, 12 Oct 2008 02:41:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43AC26DA37; Sun, 12 Oct 2008 02:41:21 -0400 (EDT)
In-Reply-To: <20081012044900.GA27845@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 12 Oct 2008 00:49:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD4F2B5E-9828-11DD-B87C-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98004>

Jeff King <peff@peff.net> writes:

> So I think it is probably reasonable to think about a new command (which
> would not be called status) that shows this information.

I was going to suggest the same.  "git st" for people who come from "svn st"
so that "git status" can be kept as traditional "preview of 'git commit'".

And just make it mimic whatever folks accustomed to "svn st" would expect,
modulo we would need two status letters to signal difference between
(HEAD, index), and (index, worktree).  Perhaps three if you want to show
difference between (HEAD, worktree) while at it.

And no, I have not seen any argument good enough to change ls-files nor
diff-$lowlevel output and break people's existing scripts.
