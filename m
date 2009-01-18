From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: put the cursor on the editable file for Vim
Date: Sat, 17 Jan 2009 17:35:22 -0800
Message-ID: <7v7i4t4crp.fsf@gitster.siamese.dyndns.org>
References: <200901172228.45450.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Jan 18 02:37:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMas-0000zO-6K
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbZARBf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 20:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbZARBf2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:35:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbZARBf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 20:35:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAD0491497;
	Sat, 17 Jan 2009 20:35:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0A79691496; Sat,
 17 Jan 2009 20:35:23 -0500 (EST)
In-Reply-To: <200901172228.45450.markus.heidelberg@web.de> (Markus
 Heidelberg's message of "Sat, 17 Jan 2009 22:28:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 484E374A-E500-11DD-93B4-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106128>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> When resolving conflicts, you only need to edit the $MERGED file. Put
> the cursor automatically into its window for vimdiff and gvimdiff to
> avoid doing <C-w>l every time.

I think this is sensible.

I do not use vim, and I do not know if the patch does what it claims to
do, though.
