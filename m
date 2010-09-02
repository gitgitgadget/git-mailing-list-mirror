From: lists@haller-berlin.de (Stefan Haller)
Subject: How to "revert hunk" in git gui?
Date: Thu, 2 Sep 2010 20:59:01 +0200
Message-ID: <1jo7lrb.1oy1vn4mdqeedM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 20:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrF0E-0004uW-4l
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 20:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab0IBS7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 14:59:07 -0400
Received: from mail.ableton.net ([62.96.12.115]:41751 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab0IBS7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 14:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:To; bh=j9Gg/0BRtwRyJFighXOppiOsRHLIkN6OQvcCXKQjlvQ=;
	b=i/uxas5YToBjmasfZGctfbiJq2NfTnZanQvzfAgijqkD++Rk7Ionkws/dXDmOfImXcJECLUHLUVnUxoY2RWt0soEu41wXGH38GTA+8Jx+JMRy7/H9DPIi6w7rSJH5GGMVSv+5l39E94Uu0O0ALQQxmYua92/3+2ou9o19869taM=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OrF01-0003Qc-Kl
	for git@vger.kernel.org; Thu, 02 Sep 2010 20:59:01 +0200
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155157>

I always use git gui to make commits, and I like the way you can stage
and unstage hunks easily.

Often, when looking at the unstaged changes I come across some piece of
debug code that I forgot to delete, and I can't seem to find an easy way
to revert this hunk.  As a workaround, I can stage the entire file,
unstage the hunk I want to revert, and then choose "Revert changes" from
the Commit menu (which reverts just the unstaged hunks); but that's a
bit inconvenient.

I feel that this is such a common operation that I must be missing
something.

Thanks,
   Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
