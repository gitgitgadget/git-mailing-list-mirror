From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] Make git config fail on variables with no section, as documented
Date: Sun, 26 Jul 2009 15:32:45 -0400
Message-ID: <1248636518-sup-7499@utwig>
References: <1248474081-sup-2762@utwig> <1248625102-472-1-git-send-email-alex@chmrr.net> <alpine.DEB.1.00.0907261849110.8306@pacific.mpi-cbg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 26 21:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV9Sl-00021u-0N
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 21:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZGZTcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbZGZTcq
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 15:32:46 -0400
Received: from chmrr.net ([209.67.253.66]:42694 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbZGZTcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 15:32:45 -0400
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1MV9Sf-0005qr-KJ; Sun, 26 Jul 2009 15:32:45 -0400
In-reply-to: <alpine.DEB.1.00.0907261849110.8306@pacific.mpi-cbg.de>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124135>

At Sun Jul 26 12:49:28 -0400 2009, Johannes Schindelin wrote:
> Is there any downside in allowing this?

Not explicitly.  However, there are no legal current uses of it, and
allowing it might encourage extensions to use the top-level config
namespace.  It also has the odd property that it _must_ be at the top
of a configuration file -- unlike all other configuration options, you
can never return to the section to add more variable definitions
later.
 - Alex
-- 
Networking -- only one letter away from not working
