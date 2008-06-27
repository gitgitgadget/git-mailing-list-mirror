From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 14:51:49 -0700
Message-ID: <7vskuypmve.fsf@gitster.siamese.dyndns.org>
References: <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
 <1006.35704952783$1214525911@news.gmane.org>
 <20080627193328.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "David Jeske" <jeske@willowmail.com>, <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCLsQ-0004tg-B7
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 23:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765509AbYF0VwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764002AbYF0Vv7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 17:51:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765509AbYF0Vv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 17:51:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D56EFD0C6;
	Fri, 27 Jun 2008 17:51:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 24839D0C4; Fri, 27 Jun 2008 17:51:51 -0400 (EDT)
In-Reply-To: <20080627193328.6117@nanako3.lavabit.com> (nanako3@lavabit.com's
 message of "Fri, 27 Jun 2008 19:33:28 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42903D02-4493-11DD-801B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86638>

しらいしななこ  <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> "David Jeske" <jeske@willowmail.com> writes:
>>
>>> If I understand it right (and that's a BIG if), it's the same as doing a merge
>>> of C into G where every individual commit in the C-line is individually
>>> committed into the new C' line.
>>>
>>> ...........-------------A---B---C
>>> ........../            /   /   /
>>> ........./        /---A'--B'--C'  topic
>>> ......../        /
>>> ....D---E---F---G - master
>>>
>>>
>>> (1) Is the above model a valid explanation?
>>
>> I would presume that the resulting trees A' in the second picture and in
>> the first picture would be the same, so are B' and C'.  But that is only
>> true when commits between A and C do not have any duplicate with the
>> development that happened between E and G.
>
> Sorry, but I think you are wrong, Junio.
> ...
> I agree that your explanation why A is not recorded as a parent of A' is
> right for the philosophical reason (the purpose of rebasing to create A'
> is so that you do not have to record them).  But from the point-of-view
> of correctness of commit history, I think A must not be recorded as a
> parent of A', either.

All correct.  Sorry about the confusion.
