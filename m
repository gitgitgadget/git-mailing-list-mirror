From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make dist: include configure script in tarball
Date: Mon, 18 Jun 2007 19:36:57 -0700
Message-ID: <7v1wg8y8ja.fsf@assigned-by-dhcp.pobox.com>
References: <20070618213036.GA7222@moooo.ath.cx> <f578a4$6mm$1@sea.gmane.org>
	<Pine.LNX.4.64.0706190203111.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 04:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0TaX-0004h5-8z
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 04:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760575AbXFSCg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 22:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760484AbXFSCg7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 22:36:59 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55288 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759420AbXFSCg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 22:36:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070619023658.JVMG17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Jun 2007 22:36:58 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DEcx1X00H1kojtg0000000; Mon, 18 Jun 2007 22:36:57 -0400
In-Reply-To: <Pine.LNX.4.64.0706190203111.4059@racer.site> (Johannes
	Schindelin's message of "Tue, 19 Jun 2007 02:03:37 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50441>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 19 Jun 2007, Jakub Narebski wrote:
>
>> Matthias Lederhofer wrote:
>> 
>> > +dist: git.spec git-archive configure
>> 
>> Ack. This way you don't need autoconf to ./configure install.
>
> ... but you force our good maintainer to have it installed...

Which is fine by me.  I was wondering why this wish did not
surface much earlier myself.

Not that I'd use "./configure" myself nor help debugging the
autoconf-generated shell scripts ;-).
