From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 15:16:43 +0200
Message-ID: <20090406131643.GA16229@pvv.org>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com> <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302> <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com> <vpqprfq3ptb.fsf@bauges.imag.fr> <33f4f4d70904060606h4d014fbdibe195a83233d8899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqoik-0003Ic-Ub
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbZDFNQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755723AbZDFNQs
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:16:48 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:39285 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbZDFNQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:16:47 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lqogt-0006Pt-5G; Mon, 06 Apr 2009 15:16:43 +0200
Content-Disposition: inline
In-Reply-To: <33f4f4d70904060606h4d014fbdibe195a83233d8899@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115820>

On Mon, Apr 06, 2009 at 03:06:46PM +0200, Klas Lindberg wrote:
> On Mon, Apr 6, 2009 at 2:54 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> 
> > What Johannes pointed out is that someone could fetch from your repo
> > _after_ you correct the mistake (if you don't control garbage
> > collection).
> 
> Aha, ok. But how then does submodule update work? Git will only see
> SHA keys for each submodule in the cotntainer tree commit, so how does
> it perform fetching of those (unnamed) references?

git submodule update just does "git fetch" and hopes that the required
commit appears. In practice this means that you (may) need to invent a
tag or a branch for all the submodules, otherwise they are not
fetchable.

This bit us pretty hard when we tried to use submodules earlier, so we
gave up. Maybe some day...

- Finn Arne
