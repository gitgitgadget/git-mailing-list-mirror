From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 15:33:27 -0700
Message-ID: <20080814223327.GV3782@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <48A3D1D7.5030805@op5.se> <200808141204.07530.trast@student.ethz.ch> <48A405A6.7000405@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, Nicolas Pitre <nico@cam.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:34:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlOp-0005VJ-Ff
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbYHNWd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYHNWd2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:33:28 -0400
Received: from george.spearce.org ([209.20.77.23]:44210 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYHNWd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:33:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7E32038375; Thu, 14 Aug 2008 22:33:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48A405A6.7000405@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92424>

Andreas Ericsson <ae@op5.se> wrote:
> How does one go about getting the object sizes? rev-list appears
> to have no option for it.

With great pain.  You can use the output of verify-pack -v to
tell you the size of the inflated portion of the object, but for
a delta this is the inflated size of the delta, not of the fully
unpacked object.

-- 
Shawn.
