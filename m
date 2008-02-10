From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Sat, 09 Feb 2008 19:44:03 -0800
Message-ID: <7vd4r55vcs.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	<46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
	<7vwspfkhxm.fsf@gitster.siamese.dyndns.org>
	<3AA71024-080B-4252-8416-82AE38A4498E@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 04:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO37f-0005xO-VB
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 04:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbYBJDoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 22:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbYBJDoW
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 22:44:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbYBJDoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 22:44:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B3429254F;
	Sat,  9 Feb 2008 22:44:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B121254E;
	Sat,  9 Feb 2008 22:44:16 -0500 (EST)
In-Reply-To: <3AA71024-080B-4252-8416-82AE38A4498E@zib.de> (Steffen Prohaska's
	message of "Sat, 9 Feb 2008 12:22:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73304>

Steffen Prohaska <prohaska@zib.de> writes:

> On Feb 8, 2008, at 8:48 AM, Junio C Hamano wrote:
>
>> Perhaps it might make sense to have a checkout hook that notices
>> the branch that is being checked out is meant to build on top of
>> a corresponding remote tracking branch, and performs the
>> necessary fast-forward when that is the case.
>
> Or just print a warning that there are new commits on the
> tracked branch and leave the decision how to proceed to
> the user?

Yeah, that would be even safer.  And I do not mind if the "git
checkout" learned to do so natively without needing of such a
hook.
