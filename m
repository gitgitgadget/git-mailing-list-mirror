From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use git-tag in git-cvsimport
Date: Sun, 03 Jun 2007 17:01:03 -0700
Message-ID: <7vabvgmvuo.fsf@assigned-by-dhcp.cox.net>
References: <11808537962798-git-send-email-el@prans.net>
	<20070603225354.GB16637@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elvis Pranskevichus <el@prans.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 02:01:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv00V-0003fF-Sr
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXFDABI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbXFDABI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:01:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47952 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbXFDABH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:01:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070604000104.ZHQR1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Jun 2007 20:01:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7C141X0091kojtg0000000; Sun, 03 Jun 2007 20:01:05 -0400
In-Reply-To: <20070603225354.GB16637@admingilde.org> (Martin Waitz's message
	of "Mon, 4 Jun 2007 00:53:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49051>

Martin Waitz <tali@admingilde.org> writes:

> hoi :)
>
> On Sun, Jun 03, 2007 at 02:56:36AM -0400, Elvis Pranskevichus wrote:
>> Fix this by calling git-tag instead. This also has a nice side effect of
>> not creating the tag object but only the lightweight tag as that's the only
>> thing CVS has anyways.
>
> but lightweight tags are not fetched by default.

Are you sure about that?
