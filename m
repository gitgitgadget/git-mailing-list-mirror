From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add strbuf_initf()
Date: Sun, 29 Jun 2008 01:07:55 -0700
Message-ID: <7vskuwek9w.fsf@gitster.siamese.dyndns.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org> <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org> <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org> <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org> <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org> <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org> <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org> <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org> <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777
 f82528876101fd946.1214581610.git.vmiklos@frugalware.org> <7vk5gal3my.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806281832510.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCryP-0001vt-Un
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYF2IIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYF2IIH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:08:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYF2IID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:08:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1196A2423;
	Sun, 29 Jun 2008 04:08:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 501D62421; Sun, 29 Jun 2008 04:07:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E8BCA5E-45B2-11DD-953F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86784>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Heh.  I suggested it, as I thought this was a perfect excuse to introduce 
> strbuf_initf(), which has been on my wishlist since long.

We may want to consider the change for its own merit, if there is a reason
for the vaddf patch, such as "this is needed because platform X and Y do
not have working vsnprintf()".  Perhaps we add compat/* something.

> Anyway, I'm fine with having them only in my personal fork.

It will cost you some "trust point" next time you try to sneak something
in as a part of a largely unrelated topic.  Please don't.
