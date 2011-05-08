From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add option to preserve user names
Date: Sun, 08 May 2011 10:32:37 -0700
Message-ID: <7voc3dt7wq.fsf@alter.siamese.dyndns.org>
References: <1304577819-703-1-git-send-email-luke@diamand.org>
 <7vy62k2z8j.fsf@alter.siamese.dyndns.org> <4DC38657.7020703@diamand.org>
 <20110506235912.GA11842@arf.padd.com>
 <7viptmup53.fsf@alter.siamese.dyndns.org> <4DC67756.3090002@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:32:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ7qg-0005bn-0H
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 19:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab1EHRcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 13:32:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab1EHRcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 13:32:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FE114DCB;
	Sun,  8 May 2011 13:34:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v4ptE07922RlrC+x9XySqE8JN2Q=; b=tma23m
	4KmYQmcH6PkI1ikrAa9FzOWLEPF+l4RrtV8xVCzh8JI6XWidZ3r3RNRX2pDHL7Dz
	1NZQkikPR1TVmDtq0AbPpwIB7Oz1Xp2E+I8lSyTtDRjnBFrgJXXHsc6iB+OIdfXX
	9AhmUJP4NDpu621vamwDwww67pCS1+Wg8q9eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tGZKL1esDcWce5mDke/kI+EX1EMBf7Xm
	U2sv+uxUxBKdkeRcONNRX7abgMWo99eZC6HXROYsWAan/NIaG3WihmXWNFjC5D8S
	AO29zwTwDwOpv/CkvszqEQRRzdjmwVOcz2WYsL1yH0Pork6sHR4lUsQNse2mIIXd
	uTFFyBBcTPs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 48D124DCA;
	Sun,  8 May 2011 13:34:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 273B24DC4; Sun,  8 May 2011
 13:34:43 -0400 (EDT)
In-Reply-To: <4DC67756.3090002@diamand.org> (Luke Diamand's message of "Sun,
 08 May 2011 11:58:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78A4F9C6-7999-11E0-961E-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173165>

Luke Diamand <luke@diamand.org> writes:

>> It looks to me that the message is not helping the users, even though it
>> may help as a debugging aid for git-p4 developers.
>
> Should I just remove it?
>
> I guess it only adds a small amount of information which could be
> explained in the instructions.

I was trying to get a feel of how much thinking went behind that message,
by suggesting a possible improvement to help users who forgot to pass the
new option when they might have wanted to, instead of just assuring users
who did pass the option when the command did the right thing for them.

People learn to quickly ignore repeated and regular messages. They will
learn that they will get that message whenever they pass the new option,
and they learn that most of the time it says what they wanted, and will
easily miss when the username you put in the message is different from
what they expect.

In our commit template, we say "# Author: author name" when and only when
it is different from you. Most of the time, you are committing your own
commit, so this line is _unusual_ and that is very much deliberate.

If you do not think of a good way to improve the "help" part of the patch,
that is Ok. We are still making progress by giving a functionality that
has been missing.

To remove or to keep, I am less qualified to judge than either you or
Pete. I'm not the primary audience. If you think it helps users, leave it
in. Otherwise remove.

Thanks.
