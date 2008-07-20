From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach 'git merge' that 'recur' merge strategy no longer
 exists
Date: Sun, 20 Jul 2008 11:33:24 -0700
Message-ID: <7vmykc76dn.fsf@gitster.siamese.dyndns.org>
References: <1216555968-31406-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdjr-0002XO-Ls
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYGTSdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbYGTSdd
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:33:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYGTSdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:33:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 979D6346AD;
	Sun, 20 Jul 2008 14:33:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 298E2346AC; Sun, 20 Jul 2008 14:33:26 -0400 (EDT)
In-Reply-To: <1216555968-31406-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sun, 20 Jul 2008 14:12:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A93F80E-568A-11DD-8FF8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89212>

Miklos Vajna <vmiklos@frugalware.org> writes:

> It co-existed with 'recursive' when rewriting it in C, but it no longer
> available.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sun, Jul 20, 2008 at 07:21:25PM +0900, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> -     { "stupid",     0 },
>
> If we are at it, recur is also something unnecessary here.

Good eyes, both of you.  Will roll a die and commit one squashed,
creditting one of you at random ;-)
