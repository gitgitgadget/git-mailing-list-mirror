From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How are the same file modified on different brances stored
 physically?
Date: Mon, 03 Mar 2008 01:06:05 -0800
Message-ID: <7vskz8i3cy.fsf@gitster.siamese.dyndns.org>
References: <15799383.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: amishera <amishera2007@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 10:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW6dO-0000Mn-Di
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 10:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbYCCJGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 04:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYCCJGU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 04:06:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYCCJGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 04:06:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98F9522E1;
	Mon,  3 Mar 2008 04:06:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0EFF722E0; Mon,  3 Mar 2008 04:06:13 -0500 (EST)
In-Reply-To: <15799383.post@talk.nabble.com> (amishera2007@gmail.com's
 message of "Mon, 3 Mar 2008 00:16:49 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75909>

amishera <amishera2007@gmail.com> writes:

> I am trying to figure out how stuffs work behind the scene. We know that we
> can switch branches freely and then work on the switched branch. If the same
> file is modified on two branches then how are the two copies of the two
> branches saved?

They are saved separately, and depending on which branch you check out, the
appropriate one for that branch is given to you.
