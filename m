From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT 1.6.0-rc1
Date: Tue, 29 Jul 2008 01:36:19 -0700
Message-ID: <7vljzlhyt8.fsf@gitster.siamese.dyndns.org>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
 <20080728063838.GB4234@blimp.local>
 <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
 <20080728213727.GA3721@blimp.local>
 <7vr69dky93.fsf@gitster.siamese.dyndns.org>
 <7v4p69jefb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkhx-0007an-UK
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYG2Ig0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYG2IgZ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:36:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbYG2IgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:36:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E89F343FCE;
	Tue, 29 Jul 2008 04:36:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 536C843FCD; Tue, 29 Jul 2008 04:36:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6D570EFC-5D49-11DD-B384-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90601>

Junio C Hamano <gitster@pobox.com> writes:

>>> Junio C Hamano, Mon, Jul 28, 2008 08:44:52 +0200:
>>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>> 
>>>> > t2103-update-index-ignore-missing.sh still broken on Windows because
>>>> > of stat.st_size being 0 for directories there.
>>>> 
>>>> I recall we did not reach a useful conclusion of that discussion.
>>>
>>> Why isn't the proposed patch useful? (and would it be possible to make
>>> the answer out of plain, small and short words?)
>>
>> Can you answer out of plain, small and short words why the proposed patch
>> is correct without unwanted side effects, not just "this seems to solve
>> the particular issue for me but I don't know if it has unintended side
>> effects"?
>
> Ok, I took a deeper look at the codepaths involved.  Although it does work
> around the issue, I do not think your patch alone is the "correct" one in
> the longer term.
>
> It needs a bit of explanation, and the explanation won't be exactly
> "plain, small and short", unfortunately.

Alex, I ran the full test with this, but only on Linux boxes; obviously
not on any flavor of Windows.  I think it is correct, and the "first line
of defence" fix is the same as your patch, so I'd assume it would work for
you as well.  But extra eyeballs are always appreciated.
