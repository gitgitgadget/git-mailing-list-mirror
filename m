From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Pass --upload-pack and --receive-pack through
 submodules.
Date: Thu, 01 Jan 2009 13:00:50 -0800
Message-ID: <7vy6xuhhbx.fsf@gitster.siamese.dyndns.org>
References: <1230605055-30723-1-git-send-email-jason@acm.org>
 <1230649782-14710-1-git-send-email-jason@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Riedy <jason@acm.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 22:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIUgN-0005jH-5O
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZAAVA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbZAAVA5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:00:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbZAAVA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:00:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84AA71B8D4;
	Thu,  1 Jan 2009 16:00:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 85F971B8D5; Thu, 
 1 Jan 2009 16:00:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 481FE00E-D847-11DD-9B07-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104325>

Jason Riedy <jason@acm.org> writes:

> While I no longer have to worry about a zillion ancient OS versions,
> I now have to worry about a remote site where I cannot control the
> path for non-interactive shells.  Thus, submodules need to handle
> explicitly specified git-upload-pack and git-receive-pack programs.

Do we (and can we) assume that the remote repositories submodules fetch
from all reside on the same host and can share the same values for these
parameters?  Shouldn't these instead be specified in the configuration
files for the submodules, if they need to be nonstandard values?
