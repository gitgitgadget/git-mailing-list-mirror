From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 00:41:16 -0700
Message-ID: <7v3az1oyjn.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
	<85wswdwjll.fsf@lola.goethe.zz>
	<7vabt9sasl.fsf@assigned-by-dhcp.cox.net>
	<85lkctw3sl.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrmj-0001zB-Uc
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXHCHlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbXHCHlS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:41:18 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35111 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbXHCHlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:41:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803074118.CVVT2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 03:41:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XKhG1X00Q1kojtg0000000; Fri, 03 Aug 2007 03:41:17 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54686>

David Kastrup <dak@gnu.org> writes:

> Ok, seems like the sort of cleanups I proposed would not clash with
> current git policies.  I'll readily agree that the timing of their
> adoption might not really fit with a rc4, but posting them for the
> queue does not seem outrageous.

Yeah, except that Kristian's C-rewrite of git-commit.sh may well
jump the queue before such a patch would touch the file it
intends to replace...
