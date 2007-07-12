From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 21:39:06 +0530
Message-ID: <20070712160906.GP23840@always.joy.eth.net>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com> <20070712140304.GB28310@diana.vm.bytemark.co.uk> <m3ir8pu133.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91S6-0007IC-Lg
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbXGLQXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758853AbXGLQXe
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:23:34 -0400
Received: from gretel.pobox.com ([208.58.1.197]:45723 "EHLO gretel.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757805AbXGLQXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 12:23:34 -0400
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by gretel.pobox.com (Postfix) with ESMTP id CA6D366655E8
	for <git@vger.kernel.org>; Thu, 12 Jul 2007 12:10:05 -0400 (EDT)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 461282EF;
	Thu, 12 Jul 2007 12:08:04 -0400 (EDT)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 809C463E6A;
	Thu, 12 Jul 2007 12:08:01 -0400 (EDT)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Thu, 12 Jul 2007 21:39:06 +0530
Content-Disposition: inline
In-Reply-To: <m3ir8pu133.fsf@pc7.dolda2000.com>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52301>

On Thu, Jul 12, 2007 at 04:51:44PM +0200, Fredrik Tolf wrote:
> git-rebase is one of those tools I haven't been looking at so far (I'm
> still rather new to Git), so I should probably read through its
> manpage.

I was in your shoes but I recently learned rebase. If you want to edit a 
commit then find the SHA-1 in git log. Then assuming you are on master:

1. git checkout -b tmp SHA-1
2. git commit --amend
3. git checkout master
4. git rebase --onto tmp SHA-1

Both times, use the same SHA-1.
