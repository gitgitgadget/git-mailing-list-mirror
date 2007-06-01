From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 01 Jun 2007 12:44:36 -0700
Message-ID: <7vr6ovzcgr.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200705020012.13302.ismail@pardus.org.tr>
	<7v8xc85ill.fsf@assigned-by-dhcp.cox.net>
	<200705032222.37387.ismail@pardus.org.tr>
	<7vsladzp29.fsf@assigned-by-dhcp.cox.net>
	<87zm3ju6tg.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:44:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuD3H-0001B9-Bg
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 21:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761379AbXFAToj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 15:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762172AbXFAToj
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 15:44:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57666 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761379AbXFAToj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 15:44:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601194438.ENDE1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Jun 2007 15:44:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Kke1X0011kojtg0000000; Fri, 01 Jun 2007 15:44:38 -0400
In-Reply-To: <87zm3ju6tg.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Fri, 01 Jun 2007 15:45:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48875>

Alexandre Julliard <julliard@winehq.org> writes:

> Sorry for the late nack, but it turns out that this patch breaks diff
> output on the Wine server for files that are not utf-8.
>
> The cause is apparently that decode_utf8() returns undef for invalid
> sequences instead of substituting a replacement char like
> decode("utf8") does.

Thanks for noticing.  Will revert.
