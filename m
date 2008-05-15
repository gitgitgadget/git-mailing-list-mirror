From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: mention how to define multiple strategies
Date: Thu, 15 May 2008 16:44:01 -0700
Message-ID: <7vfxsjf7zy.fsf@gitster.siamese.dyndns.org>
References: <1210889417-21370-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri May 16 01:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwn8F-00014L-Ln
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 01:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758953AbYEOXoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 19:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758130AbYEOXoP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 19:44:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186AbYEOXoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 19:44:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A5B237D7;
	Thu, 15 May 2008 19:44:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 865B937D0; Thu, 15 May 2008 19:44:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1E8A6B0-22D8-11DD-8E4B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82244>

Miklos Vajna <vmiklos@frugalware.org> writes:

> pull.twohead and pull.octopus supports multiple default strategies but
> this was undocumented and it was not obvious how to do so.

It indeed is supported to give multiple strategies and let "git merge" try
each of them.

However, I have a very strong doubt if it is really worth keeping the
support, let alone advertising it.

Really.  It was a fun experiment while it was being invented, but I never
saw any practical usefulness with it.
