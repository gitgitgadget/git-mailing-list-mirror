From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge adds test to a message -- bug?
Date: Mon, 24 Mar 2008 09:45:49 -0700
Message-ID: <7viqzcvznm.fsf@gitster.siamese.dyndns.org>
References: <slrnfudp0q.19k.joerg@alea.gnuu.de>
 <7vabko3dm2.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803241208400.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 17:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdpou-0004bN-9L
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbYCXQqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026AbYCXQqE
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:46:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbYCXQqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 12:46:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BD48F11CE;
	Mon, 24 Mar 2008 12:46:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0FF1011CD; Mon, 24 Mar 2008 12:45:56 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803241208400.4353@racer.site> (Johannes
 Schindelin's message of "Mon, 24 Mar 2008 12:08:59 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78058>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 23 Mar 2008, Junio C Hamano wrote:
>
>> I unfortunately do not recall why _prepend_, and not _replace_, had =
to be
>> the right behaviour.
>
> http://article.gmane.org/gmane.comp.version-control.git/31896/match=3D=
git+merge+make+usable
>
> Hth,

Ok, it helped.

So it was "my suspicion that people who would want to pass -m would wan=
t
it to behave this way".

I do not care deeply either way myself, as I never have found use for -=
m
to the merge command, but I think it could have been argued either way.
"If you want to include the standard message, you can do so yourself by
running the fmt-merge-msg yourself" would have been a valid argument to=
o,
even though it would make it a lot more cumbersome if many people wante=
d
the standard message anyway.

I do not see any objections to the suspicion back then in the thread,
there may have been discussions and user requests that made me suspect
that nearby as well, and ever since the feature was defined that way th=
ere
wasn't any objection until J=C3=B6rg brought this up.

So I'd say we should let the sleeping dog lie for now.
