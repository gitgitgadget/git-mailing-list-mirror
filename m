From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_DIR/--git-dir question
Date: Thu, 08 Nov 2007 14:00:32 -0800
Message-ID: <7vfxzg1jpb.fsf@gitster.siamese.dyndns.org>
References: <007c01c8223a$6af2e550$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:01:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFQp-0006dg-Kb
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 23:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648AbXKHWAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 17:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757942AbXKHWAk
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 17:00:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33078 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbXKHWAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 17:00:39 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 32C602F2;
	Thu,  8 Nov 2007 17:01:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C970993A12;
	Thu,  8 Nov 2007 17:00:58 -0500 (EST)
In-Reply-To: <007c01c8223a$6af2e550$5267a8c0@Jocke> (Joakim Tjernlund's
	message of "Thu, 8 Nov 2007 20:06:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64080>

"Joakim Tjernlund" <joakim.tjernlund@transmode.se> writes:

> I just started to look at having multiple work trees, each working on a separate branch,
> using the same git repo.

I suspect contrib/workdir is what you are looking for not
GIT_DIR.
