From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Do not override LESS
Date: Sat, 23 Aug 2008 02:08:58 -0700
Message-ID: <7vtzdc14k5.fsf@gitster.siamese.dyndns.org>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
 <7vvdxs2t03.fsf@gitster.siamese.dyndns.org> <87k5e8i18c.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWp8W-0006Fo-Nr
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYHWJJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYHWJJH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:09:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbYHWJJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:09:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 87B646ABD2;
	Sat, 23 Aug 2008 05:09:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F1D696ABD1; Sat, 23 Aug 2008 05:09:00 -0400 (EDT)
In-Reply-To: <87k5e8i18c.fsf@cup.kalibalik.dk> (Anders Melchiorsen's message
 of "Sat, 23 Aug 2008 10:28:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21AE85DA-70F3-11DD-A291-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93447>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> 3. Christ has been happily using git with his PAGER set to "less".  He
>>    suddenly notices that output from git linewraps and the pager does not
>>    exit when showing a short output, and gets very unhappy.
>
> Well, I noted that point already, so I had hoped for a reply
> explaining why it is a big problem.

It is a huge problem.  It breaks people's existing perfectly well working
setup.

And I do not think it is impossible to solve the issue without doing so.

> While I am wary of advocating a patch that makes Christ unhappy, the
> "3." issue is easily fixed by him setting GIT_PAGER="less -FRSX".

That's not a solution.  Alice and Bob can also change their environment to
their taste as well.  Why punish existing users?

If the problem you are trying to solve is that there is no existing
combination of the environment variables for them to do so, you can solve
it by introducing a new configuration or environment to support such usage
and documenting it, can't you?
