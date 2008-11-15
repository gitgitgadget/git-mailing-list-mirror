From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] Documentation: git-svn: fix example for
 centralized SVN clone
Date: Fri, 14 Nov 2008 21:49:35 -0800
Message-ID: <7vljvl7d3k.fsf@gitster.siamese.dyndns.org>
References: <20081114184514.6f7d437a@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
To: =?utf-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Nov 15 06:51:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1E4A-0002H5-84
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 06:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYKOFt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2008 00:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYKOFt7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 00:49:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYKOFt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 00:49:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6701E16B6B;
	Sat, 15 Nov 2008 00:49:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1E42E16AC2; Sat, 15 Nov 2008 00:49:37 -0500 (EST)
In-Reply-To: <20081114184514.6f7d437a@perceptron> (Jan =?utf-8?Q?Kr=C3=BCg?=
 =?utf-8?Q?er's?= message of "Fri, 14 Nov 2008 18:45:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BDF77FC-B2D9-11DD-966B-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101049>

"Jan Kr=C3=BCger" <jk@jk.gs> writes:

> The example that tells users how to centralize the effort of the init=
ial
> git svn clone operation doesn't work properly. It uses rebase but tha=
t
> only works if HEAD exists. This adds one extra command to create a
> somewhat sensible HEAD that should work in all cases.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---
> When I first sent this one I said I didn't like the solution all that
> much (it would be nicer to use origin/HEAD but we didn't fetch that)
> but Eric said he thinks it's okay and the original author of the
> section hasn't piped in. It's still better than a nonfunctional examp=
le
> in any case.

I'll mark this Acked by Eric and apply to 'maint'.  Thanks, both.
