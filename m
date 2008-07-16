From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-cherry-pick.txt et al.: Fix misleading
 -n description
Date: Wed, 16 Jul 2008 08:49:43 -0700
Message-ID: <7vmykhu8vc.fsf@gitster.siamese.dyndns.org>
References: <20080716123344.5875.88693.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 16 17:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ9HH-0002zg-I0
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbYGPPtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 11:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbYGPPtv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 11:49:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757300AbYGPPtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 11:49:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5886738470;
	Wed, 16 Jul 2008 11:49:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CB72238463; Wed, 16 Jul 2008 11:49:45 -0400 (EDT)
In-Reply-To: <20080716123344.5875.88693.stgit@localhost> (Petr Baudis's
 message of "Wed, 16 Jul 2008 14:35:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1CE543A-534E-11DD-99E6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88693>

Petr Baudis <pasky@suse.cz> writes:

> The manual page of git-cherry-pick and git-revert asserts that -n works
> primarily on the working tree, while in fact the primary object it operates
> on is the index, and the changes only "accidentally" propagate to the
> working tree. This e.g. leads innocent #git IRC folks to believe that you
> can use -n to prepare changes for git-add -i staging.

True, and false ;-)  Just "unstage" first in your "git add -i" session and
then add only the necessary pieces back to the index (alternatively you
can "reset" before entering "git add -i" session).

The change is good; will apply.
