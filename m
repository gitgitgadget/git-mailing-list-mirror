From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix naming scheme for configure cache variables.
Date: Mon, 19 Jan 2009 22:30:27 -0800
Message-ID: <7vljt6mqv0.fsf@gitster.siamese.dyndns.org>
References: <20090119203436.GB3539@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 07:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPA9W-00024f-Ps
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 07:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbZATGag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 01:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZATGaf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:30:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZATGae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:30:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DBDD1CD85;
	Tue, 20 Jan 2009 01:30:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C79E1CD84; Tue,
 20 Jan 2009 01:30:29 -0500 (EST)
In-Reply-To: <20090119203436.GB3539@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Mon, 19 Jan 2009 21:34:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D6FBD92C-E6BB-11DD-9F04-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106442>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> In order to be cached, configure variables need to contain the
> string '_cv_', and they should begin with a package-specific
> prefix in order to avoid interfering with third-party macros.
> Rename ld_dashr, ld_wl_rpath, ld_rpath to git_cv_ld_dashr etc.
> ---
>
> This avoids a warning with newer autoconf versions about the naming of
> the cache variables, and makes the caching work for them.

Thanks.

We require every patch we accept to be accompanied with a sign-off.

Can you certify that ... [see Documentation/SubmittingPatches and look for
(4) Sign your work] ... please?
