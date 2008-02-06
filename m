From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write failures
Date: Wed, 06 Feb 2008 02:02:20 -0800
Message-ID: <7vve52z9lf.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nico@cam.org, Johannes.Schindelin@gmx.de
To: David Steven Tweed <d.s.tweed@reading.ac.uk>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMh7P-0004kY-Vi
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760460AbYBFKCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759491AbYBFKCb
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:02:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759335AbYBFKCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:02:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F10C1901;
	Wed,  6 Feb 2008 05:02:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DCC718FF;
	Wed,  6 Feb 2008 05:02:23 -0500 (EST)
In-Reply-To: <Pine.GSO.4.63.0802051844220.15867@suma3> (David Steven Tweed's
	message of "Tue, 5 Feb 2008 18:49:31 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72787>

David Steven Tweed <d.s.tweed@reading.ac.uk> writes:

> Write errors when repacking (eg, due to out-of-space conditions)
> can leave temporary packs (and possibly other files beginning
> with "tmp_") lying around which no existing
> codepath removes and which aren't obvious to the casual user.
> These can also be multi-megabyte files wasting noticeable space.
> Unfortunately there's no way to definitely tell in builtin-prune
> that a tmp_ file is not being used by a concurrent process.
> However, it is documented that pruning should only be done
> on a quiet repository. The names of removed files are printed.
>
> Signed-off-by: David Tweed (david.tweed@gmail.com)
> ---
>
> Per discussion of previous version, this now unconditionally
> removes any tmp_ file existing when prune is run.

Sorry, can't apply

	Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
