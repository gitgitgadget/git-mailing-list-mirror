From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git remote" a mirror mode
Date: Mon, 03 Sep 2007 01:13:26 -0700
Message-ID: <7vmyw4majd.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709021245040.28586@racer.site>
	<7vk5r8q1yz.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709022101290.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS744-0007rT-OY
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbXICINc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756926AbXICINc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:13:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbXICINa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:13:30 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7400012A210;
	Mon,  3 Sep 2007 04:13:50 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709022101290.28586@racer.site> (Johannes
	Schindelin's message of "Sun, 2 Sep 2007 21:10:14 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57442>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When using the "--mirror" option to "git remote add", the refs will not
> be stored in the refs/remotes/ namespace, but in the same location as
> on the remote side.

Thanks.  With this and the "git remote rm" I think we would be
in much better shape.  Another thing that would be needed
further before we can rewriting git-clone would be the "guessing
where HEAD points at" and we would be in a very good shape.

I notice you did not add any tests, though...
