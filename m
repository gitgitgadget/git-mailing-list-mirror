From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: basics... when reading docs doesn't help
Date: Thu, 29 Mar 2007 17:16:16 -0400
Message-ID: <20070329211616.GH6143@fieldses.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX1yn-0003G3-DK
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030734AbXC2VQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbXC2VQS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:16:18 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56161 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030734AbXC2VQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:16:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HX1yi-00079e-Fk; Thu, 29 Mar 2007 17:16:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43473>

On Thu, Mar 29, 2007 at 10:50:51PM +0200, Guennadi Liakhovetski wrote:
> Now, my copy of Linus' tree was ATM 1.5GiB big...  Slowly it's getting
> scary.

On my laptop:

[bfields@pad linux]$ du -hs .
1.5G    .
[bfields@pad linux]$ du -hs .git
334M    .git

So it's mostly the checked out working directory and build
stuff.

If you really need a ton of build trees then you might just want to do
cp -al or something.

--b.
