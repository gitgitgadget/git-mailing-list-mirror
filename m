From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Sun, 08 Jul 2007 14:54:37 -0700
Message-ID: <7v1wfi1rz6.fsf@assigned-by-dhcp.cox.net>
References: <1183053733.6108.0.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7eiH-0006XK-1U
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbXGHVyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757202AbXGHVyi
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:54:38 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61707 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757269AbXGHVyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:54:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708215436.XIFE17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 17:54:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M9uc1X00J1kojtg0000000; Sun, 08 Jul 2007 17:54:37 -0400
In-Reply-To: <1183053733.6108.0.camel@mattlaptop2> (Matt McCutchen's message
	of "Thu, 28 Jun 2007 14:02:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51927>

Matt McCutchen <hashproduct@gmail.com> writes:

> -sub gitweb_have_snapshot {
> -	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
> -	my $have_snapshot = (defined $ctype && defined $suffix);
> -
> -	return $have_snapshot;

Although you are removing this function, you still have a couple
of callers left in the code.
