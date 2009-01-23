From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gittutorial: remove misleading note
Date: Fri, 23 Jan 2009 11:00:18 -0800
Message-ID: <7vk58lvoe5.fsf@gitster.siamese.dyndns.org>
References: <1232733749-6120-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQRHp-0007He-Lj
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 20:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZAWTAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 14:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZAWTAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 14:00:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbZAWTAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 14:00:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CECC1D218;
	Fri, 23 Jan 2009 14:00:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3142F1D217; Fri,
 23 Jan 2009 14:00:20 -0500 (EST)
In-Reply-To: <1232733749-6120-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Fri, 23 Jan 2009 19:02:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 164FDA4E-E980-11DD-9704-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106903>

Miklos Vajna <vmiklos@frugalware.org> writes:

> In the tutorial Alice initializes the repository, and Bob clones it. So
> Bob can just do a 'git pull', but Alice will need 'git pull <url>
> <branch>'.
>
> The note suggested that the branch parameter is not necessary, which is
> no longer true these days.

So we have a usability regression here.  Perhaps we need to fix that
instead?
