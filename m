From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git describe question
Date: Mon, 14 Jul 2008 16:17:52 -0700
Message-ID: <7v1w1wf42n.fsf@gitster.siamese.dyndns.org>
References: <20080714085557.246f52b9@crow>
 <7vvdz8hp3d.fsf@gitster.siamese.dyndns.org> <20080714092040.4090046b@crow>
 <487BD34F.4080201@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXJw-0002Eo-Q3
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbYGNXSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 19:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbYGNXSE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:18:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912AbYGNXSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:18:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A5BF32C85F;
	Mon, 14 Jul 2008 19:18:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0A0C2C84E; Mon, 14 Jul 2008 19:17:55 -0400 (EDT)
In-Reply-To: <487BD34F.4080201@gmx.ch> (Jean-Luc Herren's message of "Tue, 15
 Jul 2008 00:29:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1AA5C008-51FB-11DD-95E8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88478>

Jean-Luc Herren <jlh@gmx.ch> writes:

> Mark Burton wrote:
> ...
> I don't think people usually say "tag X is on branch Y", excepted
> maybe if Y has never been merged anywhere.  Specifically, nobody
> would say v1.5.6.3 is *on* branch master.  But it's part of its
> history.  v1.5.6.3 is *on* maint, at best.

Actually I am somewhat sympathetic to Mark here.  Probably what he wants
is to describe 10ce020 as v1.5.6-390-10ce020.

While that probably is doable by using the first-parent-only traversal, I
do not think it is such a good idea.  It is not how branches in git are
designed to work.  As Merlyn always says in #git at freenode, a branch is
an illusion, and it is especially true in the presense of fast-forward
merge (aka the upstream maintainer asking a subsystem lieutenant to do a
merge for him).
