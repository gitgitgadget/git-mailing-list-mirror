From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] prefix discovery at runtime (on Windows)
Date: Sun, 17 Aug 2008 11:01:25 -0700
Message-ID: <7v3al35xmy.fsf@gitster.siamese.dyndns.org>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 20:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUmaP-0003Dc-A3
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 20:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbYHQSBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbYHQSBe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 14:01:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbYHQSBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 14:01:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0ECFB65BC8;
	Sun, 17 Aug 2008 14:01:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 28F7A65BC7; Sun, 17 Aug 2008 14:01:27 -0400 (EDT)
In-Reply-To: <1218977083-14526-1-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Sun, 17 Aug 2008 14:44:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85FF0936-6C86-11DD-A98E-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92617>

Steffen Prohaska <prohaska@zib.de> writes:

> Apologies for proposing such large changes that late in the release cycle.
> Maybe we want to postpone the series until 1.6.0.1 or even 1.6.1.

Well, from the cursory look, it does not seem to be 1.6.0.1 material, even
though it is possible to fork a topic at 1.6.0 and use the changes in
'next', then 'master', and eventually to 'maint' to produce 1.6.0.X, if
all of this hapapens before 1.6.1.

I wouldn't mind at all if the binary distribution on Windows is based on
"git.git plus port specific patchset that will eventually be sent
upstream" like it used to be.  In fact it might even be preferrable, as I
won't be testing ports to that platform myself anyway.
