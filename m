From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 14:29:48 -0700
Message-ID: <7vodhptyk3.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiEz-0006AC-4q
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbXHBV3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbXHBV3u
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:29:50 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54410 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbXHBV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:29:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802212950.UXLV11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 17:29:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9Vo1X00E1kojtg0000000; Thu, 02 Aug 2007 17:29:49 -0400
In-Reply-To: <7vsl71tyyq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 02 Aug 2007 14:21:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54616>

You might find this thread amusing.

    http://thread.gmane.org/gmane.comp.version-control.git/7116/focus=7136

Historically, I have even avoided accepting ${var#word}, ${var%word},
and arithmetic expansions.

I would still reject shell arrays.
