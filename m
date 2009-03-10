From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 09:46:15 +0100
Message-ID: <20090310084615.GA11448@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgxcp-0000Nl-Gk
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbZCJIqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 04:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZCJIqS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 04:46:18 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:49451 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbZCJIqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 04:46:17 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LgxbL-0003MQ-8T; Tue, 10 Mar 2009 09:46:15 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112794>

On Tue, Mar 10, 2009 at 12:35:12AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 9 Mar 2009, Finn Arne Gangstad wrote:
> 
> > git push default change:
> > 
> > git push will by default push "nothing" instead of "matching".
> 
> Hasn't this been shot down already?  I do not want that change.  I think 
> it is harmful.
> 
> At least without a proper way to prepare existing users for the end of the 
> world.

That is pretty much what patches 4 and 5 are about - add nice
warnings, but do not change behavior. 6 introduces the changed default.

- Finn Arne
