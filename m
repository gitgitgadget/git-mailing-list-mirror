From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git clone" for git:// protocol
Date: Sat, 09 Feb 2008 20:15:54 -0800
Message-ID: <7vhcgh4fb9.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802091657000.11591@racer.site>
	<alpine.LNX.1.00.0802091205530.13593@iabervon.org>
	<alpine.LSU.1.00.0802100302050.11591@racer.site>
	<alpine.LNX.1.00.0802092208280.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3cf-0002CP-3R
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbYBJEQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756026AbYBJEQG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:16:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbYBJEQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:16:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 32ECD353B;
	Sat,  9 Feb 2008 23:16:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A58DF3536;
	Sat,  9 Feb 2008 23:15:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73309>

Thanks.  The patch makes sense.

I wonder this deserves a new test case to protect the fix from
future regressions.
