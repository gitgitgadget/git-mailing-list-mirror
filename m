From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH 3/5] Replace $((...)) with expr invocations.
Date: Tue, 6 Nov 2007 21:26:00 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106202600.GH6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de> <20071106201809.GD6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpV09-0004vt-LR
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbXKFU0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbXKFU0F
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:26:05 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:45575 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbXKFU0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:26:04 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 0F16840002B7A
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:26:02 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106201809.GD6361@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63721>

* Ralf Wildenhues wrote on Tue, Nov 06, 2007 at 09:18:09PM CET:
> ---
>  git-filter-branch.sh       |    4 ++--
>  git-rebase--interactive.sh |    8 ++++----
>  git-rebase.sh              |    8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)

Hmm, maybe this one is overkill.  $((...)) is POSIX, I temporarily
forgot (thanks Beno=EEt!).

I'm unsure whether git targets non-POSIX Bourne shells like Solaris
/bin/sh.  That would however mean replacing stuff like $(cmd) with
`cmd` as well, and from grepping the source it looks like you'd rather
avoid that.

Cheers,
Ralf
