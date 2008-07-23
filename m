From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/2] sort_in_topological_order(): avoid setting a
	commit  flag
Date: Wed, 23 Jul 2008 23:49:42 +0200
Message-ID: <20080723214942.GZ10151@machine.or.cz>
References: <alpine.DEB.1.00.0807230148130.8986@racer> <alpine.DEB.1.00.0807230150480.8986@racer> <7v7ibdifbp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmER-0007NC-2y
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbYGWVtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbYGWVtp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:49:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47906 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754863AbYGWVto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:49:44 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B8BA8393A36E; Wed, 23 Jul 2008 23:49:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7ibdifbp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89784>

On Tue, Jul 22, 2008 at 06:01:30PM -0700, Junio C Hamano wrote:
> Do people still actively use show-branch as a G/CUI, especially after that
> "log --graph" thing was introduced?

To me, show-branch is just more convenient to use; I can see more easily
which patches are with which branches, which is useful especially for my
new sick-twisted use of feature branches for individual patches, thus
having a lot of interdependencies.

> If that is the case, it might also make sense to stop using the object
> flags but allocate necessary number of bits (not restricted to 25 or so)
> pointed at by commit->util field to remove its limitation.
> 
> Hint, hint...

Maybe I will hit it soon... ;-)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
