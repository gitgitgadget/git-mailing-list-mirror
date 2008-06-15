From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] path-list documentation: document all functions and data
 structures
Date: Sat, 14 Jun 2008 22:04:58 -0700
Message-ID: <7vhcbve1ad.fsf@gitster.siamese.dyndns.org>
References: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org>
 <alpine.DEB.1.00.0806141705050.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Olivier Marin <dkr+ml.git@free.fr>,
	Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 15 07:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7kRQ-0004zH-64
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 07:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbYFOFFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 01:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYFOFFQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 01:05:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYFOFFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 01:05:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53191370D;
	Sun, 15 Jun 2008 01:05:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2B6E2370C; Sun, 15 Jun 2008 01:05:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2E3EC44-3A98-11DD-B8A7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85062>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Speaking of which: Junio, could you give me any clue how you would like to 
> proceed with that patch?

It would be most convenient to do so when

    git diff master pu | grep path.list

shrinks to the minimum.  I think very early after 1.5.6 would be the best,
as there is nothing outstanding that adds new use or removes existing use
of path_list.
