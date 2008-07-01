From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/14] git-commit-tree: make it usable from other builtins
Date: Mon, 30 Jun 2008 22:50:49 -0700
Message-ID: <7vbq1irw3q.fsf@gitster.siamese.dyndns.org>
References: <20080701021317.GS4729@genesis.frugalware.org>
 <666ec9b342a0c3254ae8f917d5bd2dea36314f08.1214878711.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 07:52:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDYmf-0001qK-O5
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 07:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbYGAFvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 01:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbYGAFvB
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 01:51:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbYGAFvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 01:51:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A00DF1B27B;
	Tue,  1 Jul 2008 01:50:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 001C41B27A; Tue,  1 Jul 2008 01:50:52 -0400 (EDT)
In-Reply-To: <666ec9b342a0c3254ae8f917d5bd2dea36314f08.1214878711.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Tue, 1 Jul 2008 04:22:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD3D5234-4731-11DD-BA8D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87003>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This patch is against master, you need to pull from me or first rebase
> mv/merge-in-c against current master.

That's a bad practice.  It makes it much harder to review the incremental
changes from the previous round.

I'll cope, though.
