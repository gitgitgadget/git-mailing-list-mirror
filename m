From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git pull --rebase and losing commits
Date: Tue, 3 Nov 2009 11:12:22 +0100
Message-ID: <200911031112.25064.trast@student.ethz.ch>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se> <20091102151022.GA3995@atjola.homenet> <alpine.DEB.2.00.0911030757400.15633@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-15?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5GOG-00006p-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 11:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbZKCKNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 05:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbZKCKNH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 05:13:07 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:53800 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468AbZKCKNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 05:13:07 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 3 Nov
 2009 11:13:09 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 3 Nov
 2009 11:13:08 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.0911030757400.15633@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131961>

Peter Krefting wrote:
> Thomas Rast:
> 
> > Not very surprising if you use the 'ours' strategy, which doesn't merge at 
> > all but instead takes the 'ours' side (IIRC that's the upstream for a 
> > rebase, but I always have these mixed up).
> 
> Sounds like it should be called "theirs", then. Or the documentation should 
> be clarify.

The problem isn't that ours and theirs are swapped, it's that in a
rebase, the 'ours' side is the upstream and 'theirs' is the commit you
are currently rebasing.  This makes sort of sense, because you are
rebuilding your commit on top of the upstream (or actually, the so-far
rebuilt commits, starting with the upstream), so the merge happens
"on" the upstream.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
