From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 00:11:11 -0700
Message-ID: <7vir7xozxs.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<20070802232126.GU29424@schiele.dyndns.org>
	<85k5sdy0lk.fsf@lola.goethe.zz>
	<20070802234515.GW29424@schiele.dyndns.org>
	<85d4y5xznj.fsf@lola.goethe.zz>
	<20070803000113.GX29424@schiele.dyndns.org>
	<857iodxyrc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:11:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrJc-0001tP-MF
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758221AbXHCHLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758269AbXHCHLN
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:11:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37468 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757685AbXHCHLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:11:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803071112.PBEM26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 03:11:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XKBB1X0041kojtg0000000; Fri, 03 Aug 2007 03:11:11 -0400
In-Reply-To: <857iodxyrc.fsf@lola.goethe.zz> (David Kastrup's message of "Fri,
	03 Aug 2007 02:11:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54682>

David Kastrup <dak@gnu.org> writes:

> ... For autoconf, it is fine to call sed (and you would probably not
> believe how small the portable language subset for sed is) all the
> time.  Performance is not an issue.  For normal user commands, this is
> different.

Wow, you made me recall a painful past for myself.  AIX's sed
was so bad that I had to send in a few bugfixes to autoconf to
work it around.  I do not know if I should feel happy to find
somebody to commiserate with...
