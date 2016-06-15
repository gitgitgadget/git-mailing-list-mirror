From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Wed, 08 Feb 2006 19:14:18 -0800
Message-ID: <7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 04:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F72GE-000446-Lm
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 04:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWBIDOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 22:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWBIDOU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 22:14:20 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:753 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030428AbWBIDOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 22:14:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209031245.LJOL20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 22:12:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Feb 2006 18:26:39 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15786>

Linus Torvalds <torvalds@osdl.org> writes:

> Now, arguably, the raw format should default to the same kind of "were 
> there data conflicts" that "-c" does for merges, but it doesn't, so it's 
> silent ;(

True.  There was a discussion to come up with a sensible
semantics for -c without -p (currently --cc and -c implies -p),
but I haven't got around to it, since --cc was more useful in
general.

Volunteers?
