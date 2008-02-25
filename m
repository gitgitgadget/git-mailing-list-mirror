From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 14:02:01 -0600
Message-ID: <slrnfs67lp.lsg.jgoerzen@katherina.lan.complete.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225183413.GA15131@sigill.intra.peff.net> <vpqoda43lva.fsf@bauges.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 21:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTjdE-000336-32
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756352AbYBYUIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbYBYUIU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:08:20 -0500
Received: from main.gmane.org ([80.91.229.2]:51020 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837AbYBYUIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:08:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JTjcV-00015y-8T
	for git@vger.kernel.org; Mon, 25 Feb 2008 20:08:15 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 20:08:15 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 20:08:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75058>

On 2008-02-25, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> You can have a maintainer A advertizing for A@domain.com, and a
> "sub-maintainer" B advertizing for B@domain.com. If A merges from B,
> he doesn't want his advertized adress to become the one of B.

Right.  That's why this would be a per-repo setting.  It wouldn't be
pulled or cloned, just looked up when needed.

I imagine that in gitese, this would mean that by default this would
be looked up in the repo that origin points to.
