From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn rebase issues (the commiter gets changed)
Date: Sat, 15 Dec 2007 21:50:21 -0800
Message-ID: <7vve6zkx2a.fsf@gitster.siamese.dyndns.org>
References: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com>
	<20071129075205.GB32277@soma>
	<94ccbe710711290816t7a6ba9b1o8f37ecf583305a51@mail.gmail.com>
	<20071216032523.GA17666@muzzle> <20071216033947.GB17666@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 16 06:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3mOw-0007be-V0
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 06:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXLPFue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 00:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbXLPFud
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 00:50:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbXLPFud (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 00:50:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C2A4E0F;
	Sun, 16 Dec 2007 00:50:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BDB244E0E;
	Sun, 16 Dec 2007 00:50:23 -0500 (EST)
In-Reply-To: <20071216033947.GB17666@muzzle> (Eric Wong's message of "Sat, 15
	Dec 2007 19:39:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68440>

Yes, I think Jeff's patch (and my simplification) should fix it.  Sorry
about the brown-paper-bag bug.
