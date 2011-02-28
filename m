From: Andres Freund <andres@anarazel.de>
Subject: Re: copying git repositories ...
Date: Mon, 28 Feb 2011 16:03:08 +0100
Message-ID: <201102281603.08375.andres@anarazel.de>
References: <1298388877.32648.171.camel@lenovo-w500> <201102252155.13466.andres@anarazel.de> <1298903102.14697.127.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org,
	kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Mon Feb 28 16:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu4d6-0008M7-HL
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 16:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab1B1PDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 10:03:14 -0500
Received: from mail.anarazel.de ([217.115.131.40]:39899 "EHLO mail.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab1B1PDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 10:03:14 -0500
Received: from alap2.localnet (p579FB51C.dip.t-dialin.net [87.159.181.28])
	by mail.anarazel.de (Postfix) with ESMTPSA id 3CABB448005;
	Mon, 28 Feb 2011 16:03:10 +0100 (CET)
User-Agent: KMail/1.13.6 (Linux/2.6.38-rc5-andres-00100-g0cc9d52; KDE/4.6.0; x86_64; ; )
In-Reply-To: <1298903102.14697.127.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168113>

Hi Michael,

On Monday, February 28, 2011 03:25:02 PM Michael Meeks wrote:
> Hi Andres & Brian,
> 	For #2 - I would use the verb 'clone' except of course the 'clone' I'm
> talking about would be one that is identical, the same, with no
> differences (not eg. missing a few limbs ;-)
> 
> 	Clearly cp -lR is bad & evil and all that; but it yields exactly what I
> need to effectively manage my local trees, multiple checkouts, and
> different builds without burning the entire disk.
> 
> 	Is there a blessed 'cp -lR' wrapper for git that is functionally
> identical ? [ and I'm happy of course for some slow divergence, and loss
> of efficiency as I pull more changes from time to time into each tree ].
What about git clone --reference=oldrepo ssh://upstream/ ?

Andres
