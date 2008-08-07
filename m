From: David Miller <davem@davemloft.net>
Subject: Re: [ANNOUNCE] GIT 1.6.0-rc2
Date: Thu, 07 Aug 2008 05:26:48 -0700 (PDT)
Message-ID: <20080807.052648.239243998.davem@davemloft.net>
References: <7vskthll6t.fsf@gitster.siamese.dyndns.org>
	<1218099517.8625.3.camel@twins>
	<7v3alhjgau.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 07 14:28:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4bG-00074H-Cc
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbYHGM0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYHGM0t
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:26:49 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56013
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755906AbYHGM0r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Aug 2008 08:26:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 34263C8CA8E;
	Thu,  7 Aug 2008 05:26:48 -0700 (PDT)
In-Reply-To: <7v3alhjgau.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91573>

From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 07 Aug 2008 03:00:25 -0700

> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Quick question - where does one go to find out the cool new features
> > that make it 1.6 and should convince me to upgrade and try this whicked
> > new release?
> 
> Draft release notes for 1.6.0 was posted to the list some time ago
> already, but as always:
> 
>     http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.6.0.txt

Just FYI, I have some issue with 1.6.x git when pulling remotely from
it on sparc64.  I suspect it is the usual unaligned access issue and I
will debug it further soon.
