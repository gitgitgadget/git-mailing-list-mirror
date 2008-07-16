From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 15 Jul 2008 20:05:18 -0700
Message-ID: <7vlk02wmtt.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
 <alpine.LFD.1.10.0807151851090.2835@woody.linux-foundation.org>
 <alpine.DEB.1.00.0807160428590.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 05:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIxLe-00038n-Cn
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 05:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbYGPDFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 23:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757295AbYGPDFd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 23:05:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757080AbYGPDFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 23:05:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8D102D457;
	Tue, 15 Jul 2008 23:05:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D71CA2D453; Tue, 15 Jul 2008 23:05:20 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807160428590.2841@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 16 Jul 2008 04:30:16 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D290F04-52E4-11DD-99C8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88633>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Well, the original thing was not rebasing, it was patch application. You 
>> could _perhaps_ call that "rebasing" from another tree, but that's a 
>> stretch.
>
> Hey, I do not insist on that name.  I just explained why I thought it was 
> okay even for am.  If you know a better name, just tell me, and I'll adapt 
> the patch in no time (at least as long as I am awake).

I obviously do not care too much about the name, as long as you volunteer
to squelch any newbie questions here and #git "Why is it called rebase
when I asked for am???".

Anyway, it's all in 'master' now, and you will see a huge "What's in" and
much leaner "What's cooking" shortly.
