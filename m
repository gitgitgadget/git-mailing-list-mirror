From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Sun, 07 Sep 2008 23:50:45 -0700
Message-ID: <7vbpyzgmgq.fsf@gitster.siamese.dyndns.org>
References: <20080828171533.GA6024@blimp.local>
 <20080828212722.GF6439@steel.home> <20080828212815.GG6439@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 08:52:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcabQ-0003yd-QR
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 08:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYIHGuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 02:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYIHGuy
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 02:50:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYIHGux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 02:50:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 76A5D7828F;
	Mon,  8 Sep 2008 02:50:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9FC447828E; Mon,  8 Sep 2008 02:50:48 -0400 (EDT)
In-Reply-To: <20080828212815.GG6439@steel.home> (Alex Riesen's message of
 "Thu, 28 Aug 2008 23:28:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A6DEB58-7D72-11DD-B3AE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95219>

Alex Riesen <raa.lkml@gmail.com> writes:

> It is off(0) by default, to avoid scaring people unless they asked to.

I do not think this is off by default, by the way.  "off by default" means
that you would not waste extra cycles to compute the list of suggestions.

I am not suggesting that it should be "off" by default in that sense,
though.  I am just pointing out that it is not described correctly.

I also noticed that this does not seem to pay attention to mistyped
aliases.  Is it by design, oversight, or lazyness?
