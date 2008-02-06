From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 06 Feb 2008 01:31:19 -0800
Message-ID: <7v8x1y1leg.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<m3zluf4s6r.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:32:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgdR-0003I5-1I
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760888AbYBFJbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760847AbYBFJbd
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:31:33 -0500
Received: from rune.pobox.com ([208.210.124.79]:60395 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760871AbYBFJbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:31:31 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 1F5B419421F;
	Wed,  6 Feb 2008 04:31:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C287A19420A;
	Wed,  6 Feb 2008 04:31:48 -0500 (EST)
In-Reply-To: <m3zluf4s6r.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Tue, 05 Feb 2008 02:24:19 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72782>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * jc/submittingpatches (Sun Feb 3 17:02:28 2008 -0800) 3 commits
>>  + Documentation/SubmittingPatches: What's Acked-by and Tested-by?
>>  + Documentation/SubmittingPatches: discuss first then submit
>>  + Documentation/SubmittingPatches: Instruct how to use [PATCH]
>>    Subject header
>> 
>> These I think are sensible but they did not see much discussion,
>> so they are parked here for now.
>
> In those series I think the middle patch could be improved. I guess
> that need for brevity overcame need for being explicit. I don't know
> if patches meant for discussion are to be send to mailing list only,
> or if the patches meant for submissions are to be sent to git mailing
> list _and_ maintainer (and is it an error to send them only to the
> list) from this description.

Yeah, I was very unsure about the wording.  What I think is the
ideal patch flow is:

 (0) You come up with an itch.  You code it up.

 (1) Send it to the list and cc people who may need to know about
     the change.

     The people who may need to know are the ones whose code you
     are butchering.  These people happen to be the ones who are
     most likely to be knowledgeable enough to help you, but
     they have no obligation to help you (i.e. you ask for help,
     don't demand).

     The people could include me, but that is not because I am
     currently the maintainer, but because I may happen to have
     been involved in the code you are touching.

 (2) You get comments and suggestions for improvements.  You may
     even get them in a "on top of" patch form.

 (3) Polish, refine, and re-send to the list and the people who
     spend their time to improve your patch.  Go back to step (2).

 (4) The list forms consensus that the last round of your patch is
     good.  Send it to the list and cc me.

 (5) It is merged to 'next', and cooked further and eventually
     graduates to 'master'.

In any time between the (2)-(3) cycle, I should pick it up from
the list and queue it to 'pu', in order to make it easier for
people play with it without having to pick up and apply the
patch to their trees themselves.
