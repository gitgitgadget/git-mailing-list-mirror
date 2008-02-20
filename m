From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test case for a problem with git add -u from subdirectory
Date: Wed, 20 Feb 2008 10:37:36 -0800
Message-ID: <7vhcg35v9r.fsf@gitster.siamese.dyndns.org>
References: <20080220143215.GA23053@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: kaitanie@cc.helsinki.fi
X-From: git-owner@vger.kernel.org Wed Feb 20 19:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtpt-0008DC-Pu
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbYBTShv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbYBTShv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:37:51 -0500
Received: from rune.pobox.com ([208.210.124.79]:44811 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480AbYBTShu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:37:50 -0500
Received: from rune.listbox.com (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 2F89A19E54B;
	Wed, 20 Feb 2008 13:38:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id
 A774D19E4CF; Wed, 20 Feb 2008 13:38:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74534>

Pekka Kaitaniemi <kaitanie@cc.helsinki.fi> writes:

> The key sentence being: "If no paths are specified, all tracked files
> are updated."

My recollection is that the current behaviour was requested
specifically by the users.  Although I do not remember offhand,
the first implementation might have even been doing the whole
tree unconditionally, and surprised users by stepping outside of
the current subdirectory.

Sometimes I am annoyed that it does not do the whole tree
(i.e. you have to go to the top), but some other times (which
happens to be majority for me but it would depend on the
project) I find the current behaviour a lot more convenient, and
personally I do not think it is a good idea to change the
current behaviour.

Please send in documentation clarifications.
