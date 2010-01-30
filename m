From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 10:25:08 -0800
Message-ID: <7vr5p7pi0r.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ron1-F006CF.18381129012010@news.gmane.org>
 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
 <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
 <alpine.LFD.2.00.1001300011290.1681@xanadu.home>
 <7v1vh8417w.fsf@alter.siamese.dyndns.org>
 <ron1-B18EFA.22250929012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 19:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbI0b-00022X-NL
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 19:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab0A3SZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 13:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166Ab0A3SZS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 13:25:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0A3SZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 13:25:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0660A957ED;
	Sat, 30 Jan 2010 13:25:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UlfonmDc1ptF36ySU+CrAkPW2k8=; b=f5FPKd
	mThb2vJqCP+MPUAmImaKK7M1Cw0FldxyFh5U4ycXm6S7jemWhnKl0tcIMM+/WwHc
	tDRTtD7amJeiUuR+pKlv4/ecl1KbJnH+Rphmq9xOWdws85BZ/+6JlwKq9Kf73/mW
	5xqE7wlGBMENnddUppgTkfNkG20Xb/xCJovmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1hw9Lu3wLRptWewwv1W0MTrreMGv/hk
	sJhs4kLn+VaQA09vjrN/QBn2rHGa1AIVwBzVjB7IsOtvRrqS+o9QszsV4ux4LbK9
	KnMv0GW0ED+FX44RTfxFTq1wQiGtpRdnyCHqYhfcTm4DK+R92owAxNmV8RB/fyeT
	+2UwaQQimFs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4334957EA;
	Sat, 30 Jan 2010 13:25:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A7AA957E9; Sat, 30 Jan
 2010 13:25:10 -0500 (EST)
In-Reply-To: <ron1-B18EFA.22250929012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 22\:25\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE3325A0-0DCC-11DF-A603-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138490>

Ron Garret <ron1@flownet.com> writes:

>> Also it would be nicer (just a personal preference) if a picture that
>> forks only one branch forks it upwards, like this:
>> 
>>              o---o
>>             /    
>>     ---o---o---o
>> 
>> not downwards, like this:
>> 
>>     ---o---o---o
>>             \
>>              o---o
>
> Just out of curiosity, why does this matter to you?

Imagine you pick up the whole assembly and let it fall (gravity works from
top to bottom of the sheet of paper it is printed on, not from above down
to the face of paper it is printed on)?  Which one looks more stable and
would land on the floor as-is?

The top one, of course.  It sits better when printed, and especially so
when it is presented as an illustration that comes before a paragraph,
which is a more-or-less rectangular-looking block of text; at least it
looks that way to me.

Didn't I say it is just a "personal preference"?  ;-)
