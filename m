From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add strbuf_printf() to do formatted printing to a strbuf.
Date: Tue, 31 Jul 2007 15:01:19 -0700
Message-ID: <7vhcnkfd1s.fsf@assigned-by-dhcp.cox.net>
References: <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
	<11859116632279-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 00:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFzmU-0001Se-5I
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 00:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757105AbXGaWBY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 18:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760494AbXGaWBY
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 18:01:24 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48110 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbXGaWBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 18:01:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731220121.MGLT26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 18:01:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WN1M1X00E1kojtg0000000; Tue, 31 Jul 2007 18:01:21 -0400
In-Reply-To: <11859116632279-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Tue, 31 Jul 2007 15:54:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54375>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> The old hardcoded limitation of just 2048 bytes wasn't too bad, consi=
dering
> that it's just the limit for one strbuf_printf invocation, not the to=
tal
> size of the strbuf contents.

I tend to agree with you now.  Sorry for the noise to make you
go to wild goose chase.  This does not look worth it.
