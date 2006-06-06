From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][gitweb] Make it possible to retrieve HEAD plain blob
Date: Tue, 06 Jun 2006 15:05:21 -0700
Message-ID: <7vwtbulz32.fsf@assigned-by-dhcp.cox.net>
References: <20060606205737.GX10488@pasky.or.cz> <e64rhu$i7n$1@sea.gmane.org>
	<4fb292fa0606061431g2fcc8cdet93685b5a4977c29f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 00:05:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnjfy-00007P-Cd
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 00:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWFFWFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 18:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWFFWFX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 18:05:23 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28350 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751189AbWFFWFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 18:05:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606220522.JNVB27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 18:05:22 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0606061431g2fcc8cdet93685b5a4977c29f@mail.gmail.com>
	(Bertrand Jacquin's message of "Tue, 6 Jun 2006 23:31:09 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21407>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> This is also a gitweb fault which always define document as plain-text
> instead of correct MIME.

But that is somewhat unfair to blame it for -- we do not store
what the correct mime-type is for each blob, so gitweb has to
choose between guessing and getting it wrong, or not guessing
and havign the browser deal with it.  It chose the latter, which
is understandably sensible.

Having said that, I would agree it would be very nice if I can
see t/test4012.png blob in gitweb automagically ;-).
