From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2] sort_in_topological_order(): avoid setting a commit
 flag
Date: Wed, 23 Jul 2008 10:39:55 -0500
Message-ID: <488750CB.1040400@freescale.com>
References: <alpine.DEB.1.00.0807230148130.8986@racer> <alpine.DEB.1.00.0807230150480.8986@racer> <7v7ibdifbp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, pasky@suse.cz,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 17:42:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgTz-0008Bv-LN
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYGWPl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYGWPl2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:41:28 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:36479 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbYGWPl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:41:27 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m6NFdvL1014340;
	Wed, 23 Jul 2008 08:39:58 -0700 (MST)
Received: from [10.214.72.50] (mvp-10-214-72-50.am.freescale.net [10.214.72.50])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6NFduTa010778;
	Wed, 23 Jul 2008 10:39:56 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v7ibdifbp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89687>

Junio C Hamano wrote:
> 
> Do people still actively use show-branch as a G/CUI, especially after that
> "log --graph" thing was introduced?

At the risk of sounding Old School, yes.

While the "log --graph" thing is Really Slick, it has
grumbly-factors, IMO.  First, I have to set up an alias
all the time, as "git log --graph --pretty=oneline" is
grumpy typing.  Second, I always have to widen my screen
to accommodate reasonable looking output or colrm it.
(Having it self-colrm to window-width would be nice.)
(Sure, --abbrev-commit too, but see "First," above. :-))
Finally, I frequently like seeing a self-limited history
when all the branches reach their common ancestor.

HTH,
jdl
