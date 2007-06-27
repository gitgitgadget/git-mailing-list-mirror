From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] config: Change output of --get-regexp for valueless keys
Date: Tue, 26 Jun 2007 19:14:05 -0700
Message-ID: <7vzm2mrvo2.fsf@assigned-by-dhcp.pobox.com>
References: <200706220156.01175.jnareb@gmail.com>
	<11827802363555-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3N2v-000108-FG
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbXF0COJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754408AbXF0COI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:14:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43493 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbXF0COG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:14:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627021406.BBFQ3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:14:06 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSE51X00L1kojtg0000000; Tue, 26 Jun 2007 22:14:06 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51010>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Print no space after the name of a key without value.
> Otherwise keys without values are printed exactly the
> same as keys with empty values.

I think this can be defended as a bugfix even though it is a
change in the behaviour.  Thanks.
