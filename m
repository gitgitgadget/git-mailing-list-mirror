From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make "git stash" configurable
Date: Fri, 21 Dec 2007 09:54:08 -0800
Message-ID: <7v3atw7x33.fsf@gitster.siamese.dyndns.org>
References: <200712211026.lBLAQWWM014059@mi0.bluebottle.com>
	<2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com>
	<vpq4pec7yb8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq?= =?utf-8?B?44Gq44GT?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5m54-0006C2-BZ
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbXLURyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbXLURyS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:54:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbXLURyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:54:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 31029504F;
	Fri, 21 Dec 2007 12:54:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B2671504C;
	Fri, 21 Dec 2007 12:54:11 -0500 (EST)
In-Reply-To: <vpq4pec7yb8.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri,
	21 Dec 2007 18:27:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69082>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Steven Grimm <koreth@midwinter.com> writes:
>
>> Git's command line interface is already confusing enough without
>> adding this kind of variability
>
> It also makes portable scripts harder. It's easy to write a script
> that works only if you have the option set ...

In general I'd agree but in this particular case I do not think
that applies.  Scripts can always say what they want, either
"stash save" or "stash list".
