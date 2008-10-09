From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement git clone -v
Date: Thu, 09 Oct 2008 04:06:40 -0700
Message-ID: <7vr66qown3.fsf@gitster.siamese.dyndns.org>
References: <20081008060257.GA15240@spearce.org>
 <1223509232-3520-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KntNE-0005KT-WD
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbYJILGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756116AbYJILGy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:06:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbYJILGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:06:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7167A6C31C;
	Thu,  9 Oct 2008 07:06:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BE0B56C31B; Thu,  9 Oct 2008 07:06:43 -0400 (EDT)
In-Reply-To: <1223509232-3520-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Thu, 9 Oct 2008 01:40:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 607E1522-95F2-11DD-BA19-9364E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97840>

Miklos Vajna <vmiklos@frugalware.org> writes:

> The new -v option forces the progressbar, even in case the output is not
> a terminal.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

The patch made me wonder why this new feature had to be implemented in the
first place and had me look up the message the patch was an follow-up to.
For somebody who would not recall the original request-for-feature (that
includes you 6 months from now), it would have been easier to understand
the context if the commit message said what the intended purpose of this
(i.e. "have it read by an IDE").
