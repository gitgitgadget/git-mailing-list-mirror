From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 12:17:01 -0700
Message-ID: <7vy76cn1aq.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
 <alpine.DEB.1.00.0805141803240.30431@racer>
 <7vbq38oi3j.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805141940460.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 21:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwMUD-00032K-75
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600AbYENTRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758312AbYENTRJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:17:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYENTRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:17:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA235433D;
	Wed, 14 May 2008 15:17:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5669D4335; Wed, 14 May 2008 15:17:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805141940460.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 19:42:55 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57C338EE-21EA-11DD-94B5-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82135>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The point is: for the sake of a script (which wants to ignore 
> submodules) asking if there is a diff, I think it makes sense to not 
> ignore those changes.  IOW I think my patch is enough for the purpose of 
> getting stash/rebase to behave.

But the patch is not about stash/rebase but affects all diff users,
doesn't it?
