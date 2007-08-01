From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Wed, 01 Aug 2007 16:12:41 -0700
Message-ID: <7v3az24zo6.fsf@assigned-by-dhcp.cox.net>
References: <1185880790812-git-send-email-jnareb@gmail.com>
	<11858807944170-git-send-email-jnareb@gmail.com>
	<7vd4y8fcjw.fsf@assigned-by-dhcp.cox.net>
	<200708011505.02078.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:12:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGNN9-0001sZ-Tg
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbXHAXMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbXHAXMn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:12:43 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40576 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbXHAXMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 19:12:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801231240.ZTAL14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 19:12:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WnCh1X0081kojtg0000000; Wed, 01 Aug 2007 19:12:41 -0400
In-Reply-To: <200708011505.02078.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 1 Aug 2007 15:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54497>

Jakub Narebski <jnareb@gmail.com> writes:

> But I agree that this should be protected by the %feature mechanism.
> Two questions:
>
>  1. Should we make '-l' default when turned on? Or make 'showsizes'
>     %feature tristate: off, on, by default on?
>
>  2. If it is turned off, should we silently (or not so silently)
>     ignore this option, or return "Permission denied" or perhaps
>     "Invalid extra options parameter"?
>
> And how we should name this feature (key in %feature hash)?

I would say we would not do this by default, only with an
explicit override with gitweb-config.perl.  I am not sure what
the good name would be.  "expensive-ls-tree" perhaps?

> P.S. I have received no comments on
>  [RFC/PATCH] gitweb: Enable transparent compression for HTTP output
> (trade CPU load for lower bandwidth usage).

That's probably nobody was interested in it.
