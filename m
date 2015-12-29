From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 15:12:21 -0800
Message-ID: <xmqqd1tog88a.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
	<1451415296-3960-1-git-send-email-ischis2@cox.net>
	<4187709.UG5bg1kMPP@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 00:12:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE3RR-0004Oo-K4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 00:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbbL2XMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 18:12:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752951AbbL2XM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 18:12:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0180392B3;
	Tue, 29 Dec 2015 18:12:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ztrCXtTOqkOEIXKF20nbKrQiraQ=; b=xYWRhk
	rJULV/LgHz4vjEiksuk+DrfLzdZHZ8YWNEGYkTZsRIOJUFn/6NJYA2x+29yUkphO
	egpfHvaear70Dip41ZqaapeXlenJ+Yl8AVpv7mdi2Jrmdd73QyWQZJvpQUzWXbol
	5QTjOurJo6xuinLGz6XVJObsrh/oJV2KkRrY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AybJhx4J1fDzVmk11YiF6nJjyaFMaNiD
	FicE91pfGHx0d3oWV39N0oem0pohmUj0CMMAACipzdrnxI4fhcc/JtqiTkXjkqQq
	hdKNsXBmASR0yqBvHQDD5DJIROgGMqd/Rk7zrOgl6hefjVzORqnuTM8BczV2DcLs
	k48Csu9RDPM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8339392B2;
	Tue, 29 Dec 2015 18:12:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 66AD8392AE;
	Tue, 29 Dec 2015 18:12:27 -0500 (EST)
In-Reply-To: <4187709.UG5bg1kMPP@thunderbird> (Stephen & Linda Smith's message
	of "Tue, 29 Dec 2015 14:47:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0ACA708-AE81-11E5-B687-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283157>

Stephen & Linda Smith <ischis2@cox.net> writes:

> On Tuesday, December 29, 2015 11:24:00 AM Junio C Hamano wrote:
>> "Stephen P. Smith" <ischis2@cox.net> writes:
>> 
>> > Rather than merely pointing readers at the 1.5 release notes to
>> > learn about shallow clones, document them formally.
>> >
>> > Signed-off-by: Stephen P. Smith <ischis2@cox.net>
>> > ---
>> 
>> Thanks.  I do not think the reference to RelNotes were meant for the
>> end-user readers, though.  That was a hint for whoever is working to
>> clear the "todo" items from that list i.e. you ;-> ).
>
> Actually that was a suggested update[1].   Do you still think I should replace it?
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/282831

Sorry, but I am not sure what you mean by "it".

If you mean "replace the proposed log message", yes, I do.  The way
I read "Document X?  See Y" in the "todo" section is that it is a
hint for later contributors that X might be worth documenting, and
whoever wants to do so should look at Y while working on it.  It is
not at all telling the readers of the docuement to go read Y.

This commit follows through a "todo" item and what it did is
sufficiently described by its title.  I did not think there is
anything to add in the body of the message, and I found what was
there more confusing than enlightening, because the document wasn't
even pointing readers at the 1.5 Release Notes.

Thanks for working on this.  Perhaps the last paragraph can be like
this?

    Merging inside a <<def_shallow_clone,shallow clone>> will work
    as long as a merge base is found in the resent history.
    Otherwise, it will be like merging unrelated histories and may
    have to result in huge conflicts.  This limitation may make such
    a repository unsuitable to be used in merge based workflows.
