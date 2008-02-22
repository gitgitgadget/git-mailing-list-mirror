From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Eliminate confusing "won't bisect on seeked tree" failure
Date: Fri, 22 Feb 2008 09:18:03 -0800
Message-ID: <7v63wgap10.fsf@gitster.siamese.dyndns.org>
References: <1203571214.24456.6.camel@homer.simson.net>
 <87pruqfc59.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:19:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbY3-0003pA-DB
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYBVRST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYBVRSS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:18:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYBVRSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:18:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AC2184715;
	Fri, 22 Feb 2008 12:18:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F0B234714; Fri, 22 Feb 2008 12:18:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74738>

Carl Worth <cworth@cworth.org> writes:

> This error message is very confusing---it doesn't tell the user
> anything about how to fix the situation. And the actual fix
> for the situation ("git bisect reset") does a checkout of a
> potentially random branch, (compared to what the user wants to
> be on for the bisect she is starting).

The message itself refers to a Cogito "feature" and I suspect
that removing the check and refusal would confuse Cogito.  While
I think the patch itself is Ok for us, we may want to wait a bit
for a while. until Cogito users all die out.
