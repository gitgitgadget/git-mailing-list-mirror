From: Chris Frey <cdfrey@foursquare.net>
Subject: git-status for submodules
Date: Wed, 19 Nov 2008 22:36:15 -0500
Message-ID: <20081120033615.GA21128@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 04:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L30Me-0004Nn-Ow
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 04:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYKTDge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 22:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYKTDgd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 22:36:33 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49090 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYKTDgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 22:36:33 -0500
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id mAK3aFoB021880
	for <git@vger.kernel.org>; Wed, 19 Nov 2008 22:36:15 -0500
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101386>

Hi,

I'm using git 1.6.0.4 and trying to make submodules work for me.  The
init/add/update steps are a bit tedious, but workable.  The problem I have
is when I make a change in a submodule, then git-status does not show
the change.

For example, assuming a directory structure like:  super and super/sub

	cd super
	vi newsuper
	vi existing_file
	cd sub
	vi newsub
	cd ..
	git status

This will show newsuper as needing to be added, and existing_file as changed,
but newsub will not appear.

Is there a way to accomplish this?

Thanks,
- Chris
