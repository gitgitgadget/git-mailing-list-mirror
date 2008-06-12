From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 13:45:16 -0700
Message-ID: <7vprqmz8kj.fsf@gitster.siamese.dyndns.org>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
 <cover.1213084587.git.marius@trolltech.com>
 <alpine.DEB.1.00.0806101632570.1783@racer>
 <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org> <484F6A27.1040602@trolltech.com>
 <alpine.DEB.1.00.0806112000400.1783@racer> <4850E647.7050602@trolltech.com>
 <7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
 <20080612195553.GK13626@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tgk-0001Uu-NW
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbYFLUph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbYFLUph
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:45:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbYFLUpg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:45:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D99E139F3;
	Thu, 12 Jun 2008 16:45:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0357939E7; Thu, 12 Jun 2008 16:45:26 -0400 (EDT)
In-Reply-To: <20080612195553.GK13626@fieldses.org> (J. Bruce Fields's message
 of "Thu, 12 Jun 2008 15:55:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8184471C-38C0-11DD-8B43-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84792>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> (Is there any advantage, then, to the :n:filename syntax to a user?
> Is it useful in any cases when they couldn't use HEAD or MERGE_HEAD
> instead?  If not I might be tempted to cut this bit entirely (or
> postpone it till later.)

I am somewhat torn between the two.

This section is only about merge conflicts, so using "checkout HEAD path"
would be a good substitute.  The text flows better that way, because the
previous paragraph talks about HEAD and MERGE_HEAD.

When people run "am -3", however, they may wish that they learned how the
notation to name blob objects in the index (e.g. :2:path) can be used to
examine and resolve the conflict, as there is no HEAD/MERGE_HEAD in that
usage context.
