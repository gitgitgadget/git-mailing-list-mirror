From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Fri, 22 Feb 2008 09:40:22 -0800
Message-ID: <7vskzk99fd.fsf@gitster.siamese.dyndns.org>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
 <87skznhqk6.fsf@rho.meyering.net> <7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
 <87ir0gx5bn.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:41:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbtZ-00041R-9m
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbYBVRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbYBVRkg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:40:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbYBVRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:40:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BFC4A4F21;
	Fri, 22 Feb 2008 12:40:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C3D9D4F1F; Fri, 22 Feb 2008 12:40:27 -0500 (EST)
In-Reply-To: <87ir0gx5bn.fsf@rho.meyering.net> (Jim Meyering's message of
 "Fri, 22 Feb 2008 18:35:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74741>

Jim Meyering <jim@meyering.net> writes:

>> Thanks.  I'll queue this probably in 'next' for now, but we
>> would want a conditional workaround for git-compat-util.h before
>> we push it out to 'master'.
>
> Ok.
> Would you like an autoconf test to check for working free?

Sure, but that could be left for later rounds.

We usually first add manual configuration option to Makefile
(say, NO_FREE_NULL=Unfortunately) and then set that symbol via
autoconf only when somebody really cares about.
