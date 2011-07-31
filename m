From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/4] git-p4 test cleanup, commit time change
Date: Sun, 31 Jul 2011 09:42:37 -0400
Message-ID: <20110731134237.GA6564@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
 <4E352535.4060804@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:42:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWI3-0004f8-Vc
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312Ab1GaNmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 09:42:42 -0400
Received: from honk.padd.com ([74.3.171.149]:53409 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1GaNml (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 09:42:41 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 5989B330B;
	Sun, 31 Jul 2011 06:42:40 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 493E63149A; Sun, 31 Jul 2011 09:42:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E352535.4060804@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178250>

luke@diamand.org wrote on Sun, 31 Jul 2011 10:49 +0100:
> One thing though - are you sure the p4d demo license only allows 2
> users? I've only ever used the demo p4d for testing and it seems to
> work fine (just tried again with version
> P4D/LINUX26X86_64/2010.2/322263).

You are so right.  I was using an older p4d (2009.1/222893) at
home, and didn't even think about checking for updates.

There was one line in patch 3 that should survive, just to add a
"&&".  I've added your acks for the rest and will repost to show
the current changes.

Thanks,

		-- Pete
