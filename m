From: Junio C Hamano <junkio@cox.net>
Subject: Re: Scripts to use "bundles" for moving data between repositories
Date: Wed, 14 Feb 2007 09:11:15 -0800
Message-ID: <7vlkj0r7f0.fsf@assigned-by-dhcp.cox.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNfb-0005Au-MD
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbXBNRLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbXBNRLQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:11:16 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62229 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbXBNRLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:11:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214171115.NHBZ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:11:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PVBF1W00Q1kojtg0000000; Wed, 14 Feb 2007 12:11:15 -0500
In-Reply-To: <11714622292110-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Wed, 14 Feb 2007 09:10:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39691>

I think something like this is a good addition but I do not want
us to require zip/unzip to use git.  I think saner alternative
would be to use tar.
