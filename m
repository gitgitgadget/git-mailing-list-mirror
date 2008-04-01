From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Documentation/hooks: add pre-auto-gc hook
Date: Mon, 31 Mar 2008 22:02:37 -0700
Message-ID: <7v8wzyjhg2.fsf@gitster.siamese.dyndns.org>
References: <0a4fb03744d2a8c3e38030a29098e25823aed6bc.1206929014.git.vmiklos
 @frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 07:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYem-0007oL-Ll
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 07:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbYDAFCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 01:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYDAFCy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 01:02:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbYDAFCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 01:02:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C52DF2603;
	Tue,  1 Apr 2008 01:02:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 11E0525F6; Tue,  1 Apr 2008 01:02:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78629>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +The default 'pre-auto-gc' hook, when enabled, defers auto repacking when
> +you are on battery.

I'd prefer not to have the Linux specific one in templates/hooks--*; it
would be a good addition to contrib/hooks/ though, if you use on_ac_power
as suggested.

In any case, we ship all hooks in templates _disabled_, and they should be
called "example hook", not "default hook".
