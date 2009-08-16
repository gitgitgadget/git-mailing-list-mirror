From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Sun, 16 Aug 2009 12:48:22 -0700
Message-ID: <7v7hx35ym1.fsf@alter.siamese.dyndns.org>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
 <1250036031-32272-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Johannes.Schindelin@gmx.de, David Aguilar <davvid@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Aug 16 21:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mclia-0005WM-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 21:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbZHPTsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbZHPTsc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 15:48:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZHPTsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 15:48:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E52D4F7;
	Sun, 16 Aug 2009 15:48:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B580D4F5; Sun, 16 Aug
 2009 15:48:24 -0400 (EDT)
In-Reply-To: <1250036031-32272-3-git-send-email-johan@herland.net> (Johan
 Herland's message of "Wed\, 12 Aug 2009 02\:13\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C67072D0-8A9D-11DE-9D7F-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126070>

It appears that the "make install" step with this patch is broken, trying
to write into /usr/lib/python2.6/ without honoring DESTDIR.

It needs to be resolved before the series nears 'master', preferrably
before it hits 'next', as "make rpm" step is one of the things that is
broken by this.

I am sure people who are more savvy on Python can offer help.

Thanks.
