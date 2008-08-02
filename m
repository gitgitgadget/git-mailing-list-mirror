From: Junio C Hamano <gitster@pobox.com>
Subject: Re: email address handling
Date: Sat, 02 Aug 2008 09:36:33 -0700
Message-ID: <7vej57pe5q.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
 <20080801132415.0b0314e4.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org>
 <20080801145804.85041bbd.akpm@linux-foundation.org>
 <20080801221539.GA8617@mit.edu>
 <20080801152720.56dbff09.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org>
 <20080801154902.c60717e5.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org>
 <alpine.DEB.1.00.0808021321500.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808020916370.3318@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 18:37:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPK6z-0003QR-9X
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 18:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYHBQgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 12:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYHBQgo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 12:36:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYHBQgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 12:36:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC0164C877;
	Sat,  2 Aug 2008 12:36:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 102534C874; Sat,  2 Aug 2008 12:36:35 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808020916370.3318@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Sat, 2 Aug 2008 09:20:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2FDD7CE4-60B1-11DD-A991-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91152>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 2 Aug 2008, Johannes Schindelin wrote:
>> 
>> Ah, there lies the rub (you forgot that the original complaint was about 
>> a comma, and pretty=email does not handle those):
>
> Indeed.
>
> I wonder where that is_rfc2047_special() function came from.

It came from the earlier patch from Dscho I rejected yesterday ;-)
