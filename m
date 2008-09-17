From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff, but not condensed, howto?
Date: Wed, 17 Sep 2008 09:58:30 -0700
Message-ID: <7vwsha6761.fsf@gitster.siamese.dyndns.org>
References: <48D0B907.7040903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 19:00:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg0Nc-0002Ik-KN
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387AbYIQQ6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755918AbYIQQ6j
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 12:58:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288AbYIQQ6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 12:58:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 06F23627ED;
	Wed, 17 Sep 2008 12:58:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7F17E627E8; Wed, 17 Sep 2008 12:58:32 -0400 (EDT)
In-Reply-To: <48D0B907.7040903@viscovery.net> (Johannes Sixt's message of
 "Wed, 17 Sep 2008 10:00:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD83EEEA-84D9-11DD-A6E8-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96129>

Johannes Sixt <j.sixt@viscovery.net> writes:

> After a merge conflict, 'git diff' shows a combined diff, which presents
> only the parts that conflicted or where there are near-by changes from
> different parents (potential conflicts). Is there a command line switch so
> that *all* changes are shown, even non-conflicting ones?

Like "git diff HEAD"?
