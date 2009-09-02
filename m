From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 13:48:32 +0100
Message-ID: <20090902124832.GC4012@sirena.org.uk>
References: <20090901145213.GB4194@debian.b2j> <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org> <200909012325.45739.j6t@kdbg.org> <7vtyzmxkpr.fsf@alter.siamese.dyndns.org> <20090902011513.GA3874@coredump.intra.peff.net> <7vmy5egefh.fsf@alter.siamese.dyndns.org> <20090902051248.GB12046@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 14:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MipGc-0001XA-33
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 14:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZIBMsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 08:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZIBMsk
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 08:48:40 -0400
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52393 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZIBMsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 08:48:39 -0400
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1MipGK-0005IP-Mu; Wed, 02 Sep 2009 13:48:32 +0100
Content-Disposition: inline
In-Reply-To: <20090902051248.GB12046@coredump.intra.peff.net>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127606>

On Wed, Sep 02, 2009 at 01:12:48AM -0400, Jeff King wrote:
> On Tue, Sep 01, 2009 at 09:26:26PM -0700, Junio C Hamano wrote:

> > [1] It might even make sense to omit other sections and show only
> > "updated" and "unmerged" in this order when the index is unmerged, but
> > that is a lot more drastic change for 1.7.0.

> I think that is a really bad idea. The mental model of "git status"
> (versus individual diff or ls-files commands) is to see _everything_
> going on in the repo. Showing a subset breaks that model and gives a
> false sense of what is actually happening.

It would be nice to be able to explicitly ask to suppress some of the
output for cases where there's a lot of it and only a small part is
interesting (like when resolving a large merge as mentioned earlier) - I
often end up doing this by hand in those situations.  I do agree that
doing this by default would be surprising.
