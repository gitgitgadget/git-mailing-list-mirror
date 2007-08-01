From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: git-diff on touched files: bug or feature?
Date: Wed, 01 Aug 2007 21:02:18 +0200
Message-ID: <87vebzkrid.fsf@wine.dyndns.org>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJSm-0006oH-1e
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091AbXHATCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756465AbXHATCX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:02:23 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:44287 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbXHATCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 15:02:22 -0400
Received: from adsl-84-227-23-240.adslplus.ch ([84.227.23.240] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IGJSe-0003QU-8o; Wed, 01 Aug 2007 14:02:20 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 4560D1E7170; Wed,  1 Aug 2007 21:02:18 +0200 (CEST)
In-Reply-To: <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 10\:26\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54465>

Junio C Hamano <gitster@pobox.com> writes:

> Yes.  Very much so, intentionally, from very early days of git.
> This serves as a reminder to the user that he started editing
> but changed his mind to end up with the same contents as the
> original, until the next "update-index --refresh" (which is
> internally invoked from "status").

It would be nice to have a way to refresh a single file though. For
instance in vc-git.el the workfile-unchanged-p function currently has
to rehash the file every time to see if it really changed, because we
can't afford to refresh the whole project at that point.

-- 
Alexandre Julliard
julliard@winehq.org
