From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 07 Feb 2007 13:22:26 -0800
Message-ID: <7vired64tp.fsf@assigned-by-dhcp.cox.net>
References: <7vabzp7lgs.fsf@assigned-by-dhcp.cox.net>
	<20070207211422.GH12140@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:22:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEuFe-00040F-2D
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbXBGVW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbXBGVW2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:22:28 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51559 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422789AbXBGVW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:22:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207212227.MUUS1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 16:22:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LlNS1W00v1kojtg0000000; Wed, 07 Feb 2007 16:22:27 -0500
In-Reply-To: <20070207211422.GH12140@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 7 Feb 2007 23:14:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38973>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> > git-show can not limit its output to just the part of patch
>> > that affects the list of files I give, the way git-diff can.
>> > Would such an extension be a good idea?
>> 
>> It is a good idea and I think it is implemented.
>> 
>> 	$ git-show <commit>... --- <paths>
>
> Yes, this works. But this seems undocumented. Right?

Somehow I think I saw Linus's answer to this exact topic a few
hours ago.

This manual page describes only the most frequently used options.
