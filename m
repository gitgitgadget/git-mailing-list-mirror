From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: + wireless-fix-iwlwifi-unify-init-driver-flow.patch added to
	-mm tree
Date: Wed, 14 May 2008 08:34:32 -0400
Message-ID: <20080514123432.GB3349@tuxdriver.com>
References: <200805140405.m4E45oBc015343@imap1.linux-foundation.org> <20080513.213927.191790810.davem@davemloft.net> <20080513215737.fe1bdebd.akpm@linux-foundation.org> <20080513.221529.20855966.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	ron.rindjunsky@intel.com, sfr@canb.auug.org.au,
	tomas.winkler@intel.com, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Wed May 14 14:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwGSR-0002q5-Dk
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 14:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759358AbYENMux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 08:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758158AbYENMuw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 08:50:52 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:4185 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758015AbYENMuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 08:50:51 -0400
Received: from ra.tuxdriver.com (ra.tuxdriver.com [127.0.0.1])
	by ra.tuxdriver.com (8.14.0/8.14.0) with ESMTP id m4ECoMOk009020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 May 2008 08:50:32 -0400
Received: (from uucp@localhost)
	by ra.tuxdriver.com (8.14.0/8.14.0/Submit) with UUCP id m4ECjAl2008931;
	Wed, 14 May 2008 08:45:10 -0400
Received: from linville-t43.local (localhost.localdomain [127.0.0.1])
	by linville-t43.local (8.14.1/8.13.8) with ESMTP id m4ECYWM4004019;
	Wed, 14 May 2008 08:34:32 -0400
Received: (from linville@localhost)
	by linville-t43.local (8.14.1/8.14.1/Submit) id m4ECYWLC004018;
	Wed, 14 May 2008 08:34:32 -0400
Content-Disposition: inline
In-Reply-To: <20080513.221529.20855966.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-4.4 required=3.0 tests=ALL_TRUSTED,BAYES_00,
	SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.1.8-gr1
X-Spam-Checker-Version: SpamAssassin 3.1.8-gr1 (2007-02-13) on ra.tuxdriver.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82098>

On Tue, May 13, 2008 at 10:15:29PM -0700, David Miller wrote:

> I used to play this game, it's a lot of work and it sucks.  One
> "drib" can require fixing up 200 patches down the chain.  And
> I've had this happen to me all the time in the past when I was
> rebasing all the time.

I have to agree with Dave.

Moreover, I used to get regular complaints about the old "regular
rebase" process.  We switched to a "pull and merge" process for 2.6.25,
and in that period nearly all of the process-related complaints
disappeared for me.

To some degree this is a "pick your poison" issue, and for most people
rebasing seems like the deadlier poison.

John
-- 
John W. Linville
linville@tuxdriver.com
