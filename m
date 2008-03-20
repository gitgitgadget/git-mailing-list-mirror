From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Thu, 20 Mar 2008 00:53:01 -0700
Message-ID: <7vlk4dygpu.fsf@gitster.siamese.dyndns.org>
References: <20080312191041.GF3198@ins.uni-bonn.de>
 <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de>
 <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
 <47E10D0D.2080702@viscovery.net> <7vhcf24j3e.fsf@gitster.siamese.dyndns.org>
 <47E21510.6020009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFb8-0005uD-6V
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbYCTHxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 03:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYCTHxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:53:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbYCTHxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 03:53:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E65D01CAF;
	Thu, 20 Mar 2008 03:53:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3D3D31CAC; Thu, 20 Mar 2008 03:53:08 -0400 (EDT)
In-Reply-To: <47E21510.6020009@viscovery.net> (Johannes Sixt's message of
 "Thu, 20 Mar 2008 08:41:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77641>

Johannes Sixt <j.sixt@viscovery.net> writes:

> But given how intrusive the patch is ("just to remove an unnecessary
> checkout"), I'd say this is post-1.5.5 material. Also, the fact that you
> had to post a fix-up is an indication that there are probably a number of
> corner cases that need an extended testing period.

The fixup came from a real-world corner case.  I actually do fairly
esoteric varieties of rebases all the time, starting with my HEAD
detached, rebasing --onto a non-branch, explicitly stating where the
bottom is, etc, etc.

Although I am comfortable enough with the patch itself to queue it in
'next' for my daily use, I do not intend it for 1.5.5 at all.  The merge
window is a discipline, a line must be drawn somewhere, and when the line
is drawn, it must be honoured.
