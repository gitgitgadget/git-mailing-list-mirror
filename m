From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Fri, 21 Sep 2007 08:11:22 +0200
Message-ID: <20070921061122.GI11204@kiste.smurf.noris.de>
References: <200709161857.06065.danda@osc.co.cr> <7vlkb4wdzq.fsf@gitster.siamese.dyndns.org> <20070918092909.GU31176@kiste.smurf.noris.de> <200709201340.17023.danda@osc.co.cr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dan Libby <danda@osc.co.cr>
X-From: git-owner@vger.kernel.org Fri Sep 21 08:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYbkY-0007K7-V5
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 08:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXIUGMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 02:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbXIUGMU
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 02:12:20 -0400
Received: from smurf.noris.de ([192.109.102.42]:37757 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbXIUGMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 02:12:19 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35])
	by smurf.noris.de with smtp (Exim 4.63)
	(envelope-from <smurf@smurf.noris.de>)
	id 1IYbje-0004cj-8Q; Fri, 21 Sep 2007 08:11:31 +0200
Received: (nullmailer pid 6960 invoked by uid 501);
	Fri, 21 Sep 2007 06:11:22 -0000
Content-Disposition: inline
In-Reply-To: <200709201340.17023.danda@osc.co.cr>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58826>

Hi,

Dan Libby:
> we do not like 'Cristian new code' as a tag name.

Duh? That's a perfectly valid tag name.
I have no idea why git croaked on this one.

Please run 

    strace -f -s300 -eexecve git-svnimport ... 2>&1 | \
		grep check-ref-format | grep -v ENOENT

and mail me the output, replacing the "..." with your normal arguments
of course.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Taken as a whole, the universe is absurd.
					-- Walter Savage Landor
