From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7/6] gitweb: Empty patch for merge means trivial merge, not no differences
Date: Wed, 16 May 2007 15:08:24 -0700
Message-ID: <7v646se813.fsf@assigned-by-dhcp.cox.net>
References: <11784930091585-git-send-email-jnareb@gmail.com>
	<11793531552023-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 00:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoRfc-0006y5-Et
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbXEPWI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbXEPWI0
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:08:26 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37783 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbXEPWIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:08:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516220825.UGGN22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 18:08:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zy8Q1W0011kojtg0000000; Wed, 16 May 2007 18:08:24 -0400
In-Reply-To: <11793531552023-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 17 May 2007 00:05:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47463>

Jakub Narebski <jnareb@gmail.com> writes:

> Earlier commit 4280cde95fa4e3fb012eb6d0c239a7777baaf60c made gitweb
> show "No differences found" message for empty diff, for the HTML
> output. But for merge commits, either -c format we use or --cc format,
> empty diff doesn't mean no differences, but trivial merge.
>
> Show "Trivial merge" message instead of "No differences found" for
> merges.

Sounds good.  Some people might want to treat "-s ours" merge
specially (in real life, when two branches fix the same bug
differently the result of the hand-resolution may end up being
the same as "-s ours" merge), although I do not think it is such
a big deal.
