From: Craig Taylor <c@gryning.com>
Subject: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 17:05:51 +0100
Message-ID: <20090921160551.GD8173@gryning.com>
Reply-To: c@gryning.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 18:26:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mplit-0001yf-6N
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 18:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbZIUQ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 12:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbZIUQ0b
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 12:26:31 -0400
Received: from 87-194-167-47.bethere.co.uk ([87.194.167.47]:57828 "EHLO
	jolt.ukmail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbZIUQ0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 12:26:31 -0400
X-Greylist: delayed 1237 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2009 12:26:31 EDT
Received: from craigt by jolt.ukmail.org with local (Exim 4.63)
	(envelope-from <c@gryning.com>)
	id 1MplOh-0000NK-Cg
	for git@vger.kernel.org; Mon, 21 Sep 2009 17:05:51 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128895>

Hi all

I'm compiling/installing git in a Solaris environment without root.
Using 'make DESTDIR=<some path> install' to stage an install to an
alternate location.
The perl module component of 'make DESTDIR=<some path> install' installs
into the system perl lib path without prepending the forced install
destination or my '--prefix'.
This seems counter intuitive and I would consider a bug.

Regards
CraigT

-- 

c^ [c%5e]

The bamboo-shadows move over the stone steps
as if to sweep them, but no dust is stirred;
The moon is reflected deep in the pool, but the
water shows no trace of its penetration.
