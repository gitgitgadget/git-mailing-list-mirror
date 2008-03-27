From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] builtin-prune: protect objects listed on the command
 line
Date: Thu, 27 Mar 2008 09:32:35 -0700
Message-ID: <7vve389lgc.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
 <7vtzivmgpg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jev2l-0001br-CK
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 17:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbYC0Qcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 12:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757560AbYC0Qcx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 12:32:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538AbYC0Qcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 12:32:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E8B5529F;
	Thu, 27 Mar 2008 12:32:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AE4F0529A; Thu, 27 Mar 2008 12:32:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78354>

Junio C Hamano <junio@pobox.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 24 Mar 2008 23:20:51 -0700
>
> Finally, this resurrects the documented behaviour to protect other
> objects listed on the command line from getting pruned.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This is done deliberately differently from what you did.  Because we do
>    not want to accept "we allow losing what's reachable from master" with
>    "git prune master..next", setup_revisions() is not the right thing to
>    use for this command.

Ping?
