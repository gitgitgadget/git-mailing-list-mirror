From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention 'cpio' dependency in INSTALL
Date: Tue, 02 Oct 2007 17:14:25 -0700
Message-ID: <7v1wcdjbq6.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
	<200710012342.37352.johan@herland.net>
	<3f4fd2640710021409q104a4204r522391912d5b5c8c@mail.gmail.com>
	<200710030142.30062.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reece Dunn <msclrhd@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 02:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icrsu-0005aI-W4
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 02:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbXJCAOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 20:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbXJCAOc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 20:14:32 -0400
Received: from rune.pobox.com ([208.210.124.79]:59704 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbXJCAOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 20:14:32 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 58CF013F7FA;
	Tue,  2 Oct 2007 20:14:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AC06813F7CD;
	Tue,  2 Oct 2007 20:14:49 -0400 (EDT)
In-Reply-To: <200710030142.30062.johan@herland.net> (Johan Herland's message
	of "Wed, 03 Oct 2007 01:42:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59759>

Johan Herland <johan@herland.net> writes:

> reveals that cpio is not mentioned anywhere in the documentation,
> nor in the requirements section of the INSTALL file.

Thanks.

We use many other tools that are typically found in bog-standard
UNIX environments, like sed, echo, cat, sort, etc. and we do not
list them in the INSTALL file (nor we would want to).  cpio used
to be in the "bog standard" category but perhaps Linux distros
do not install it by default, so it is worth listing it there.

Are there other commands we rely on that may not be universally
installed?  I myself consider "cut" to be in the category, but
other than that I do not think of anything offhand.
