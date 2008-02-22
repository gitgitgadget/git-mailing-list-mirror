From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Fri, 22 Feb 2008 09:18:15 -0800
Message-ID: <7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
 <87skznhqk6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbYE-0003sU-6l
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYBVRSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbYBVRSb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:18:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYBVRS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:18:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 73EE9471A;
	Fri, 22 Feb 2008 12:18:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B8F5B4719; Fri, 22 Feb 2008 12:18:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74739>

Jim Meyering <jim@meyering.net> writes:

> ...
> Here's an updated patch:
> ...
> Date: Thu, 31 Jan 2008 18:26:32 +0100
> Subject: [PATCH] Avoid unnecessary "if-before-free" tests.
>
> This change removes all obvious useless if-before-free tests.

Thanks.  I'll queue this probably in 'next' for now, but we
would want a conditional workaround for git-compat-util.h before
we push it out to 'master'.
