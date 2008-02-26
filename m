From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve collection of information for format-patch
 --cover-letter
Date: Tue, 26 Feb 2008 01:24:36 -0800
Message-ID: <7voda46pez.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251822240.19024@iabervon.org>
 <7v4pbw847y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTw42-00044u-Ut
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbYBZJYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759188AbYBZJYx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:24:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbYBZJYw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 04:24:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B68D12208;
	Tue, 26 Feb 2008 04:24:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9C4E62207; Tue, 26 Feb 2008 04:24:46 -0500 (EST)
In-Reply-To: <7v4pbw847y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 26 Feb 2008 01:19:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75114>

Junio C Hamano <gitster@pobox.com> writes:

> This passes all the tests fine isolated, but when merged to
> 'next' or 'pu' the result seem to barf at test #105 in t4013,
> complaining that it does not know about --cover-letter.
>
> Sorry, but I've run out of time tonight, so 'pu' tonight has
> this at the tip.

False alarm.  It seems to be Ok.
