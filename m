From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Fri, 03 Aug 2007 18:30:12 -0700
Message-ID: <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>
	<200708040341.36147.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Sat Aug 04 03:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH8TS-00087P-Vx
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 03:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbXHDBaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Aug 2007 21:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbXHDBaS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 21:30:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48988 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756955AbXHDBaR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 21:30:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070804013016.DZYY26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 21:30:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XdWE1X0021kojtg0000000; Fri, 03 Aug 2007 21:30:14 -0400
In-Reply-To: <200708040341.36147.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Sat, 4 Aug 2007 03:41:36 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54784>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> Can't build manpages, same error as ...

Sigh...

The asciidoc toolchain used by us (either AsciiDoc 7 nor 8) does
not seem to work well with docbook-xsl 1.72 and 1.73, it seems.

If you can investigate where the breakage is to come up with
patches to make it format with newer docbook-xsl, without
breaking 1.71 (which k.org uses to make the preformatted
documentation in html and man branches), it would be very much
welcomed and appreciated.

I however have a slight suspition that the patch might end up to
be against either asciidoc or docbook-xsl package, not our
documentation...
