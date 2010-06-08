From: Junio C Hamano <gitster@pobox.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
 commits?
Date: Tue, 08 Jun 2010 10:25:12 -0700
Message-ID: <7vljaptp1j.fsf@alter.siamese.dyndns.org>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
 <201001071813.01187.trast@student.ethz.ch>
 <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
 <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
 <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
 <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 19:25:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM2YL-0007Kd-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 19:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab0FHRZ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 13:25:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0FHRZX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 13:25:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 889B5BA6B7;
	Tue,  8 Jun 2010 13:25:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TPcQiVQek8Fv
	Q9vqVURvEQktbH8=; b=n/rdo2daBrKC0D8VAxsEYdwrJw8psVv1whleouFMWe5N
	xlA4SfdBonPSosVvA0jEzSsAHuuoR57Sy6RhSZh5lE42LYG0HSy1T8X4JqPPBWVu
	ZAoJOff4KvjQAnh+f2fV6DX/lxeymY9SmhfkyebiX8C1ABavSByS8sMYXExwcpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QXX30X
	GSGztL+etnxf7q41W7hww4DNe2AkL0HO0a6qHbYhLgBUTq4B6+8WB4EzAxPzAogn
	SoRQBa290N4p98KTiaGsPclfGykSnyrZlfM4OLKvVjSUXEGYQDbaAtBl1AWqoM+k
	6oUKEhV/g/o9srSUtxl7iKiTWdkgMy7Rp+y3Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 560B9BA6B6;
	Tue,  8 Jun 2010 13:25:18 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78E27BA6B4; Tue,  8 Jun
 2010 13:25:14 -0400 (EDT)
In-Reply-To: <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
 (Eugene Sajine's message of "Tue\, 8 Jun 2010 12\:27\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CEFD92C0-7322-11DF-94D0-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148693>

Eugene Sajine <euguess@gmail.com> writes:

> On Thu, Jan 7, 2010 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> $ git fetch origin branchname
>>>
>>> are both causing the output like this:
>>>
>>> From git://....
>>> * branch =C2=A0 =C2=A0 =C2=A0branchname =C2=A0 =C2=A0-> FETCH_HEAD
>>> ...
>>>
>>> but "git fetch" says:
>>>
>>> From git://....
>>> * branch =C2=A0 =C2=A0 =C2=A0branchname =C2=A0 =C2=A0-> origin/bran=
chname
>>>
>>> Is this inconsistent behavior necessary by design?
>>
>> It is by design...
>
> I'm coming back to this topic as i see some confusion growing about
> such behavior. Every now and then users come across this problem and
> they expect pull to *really* behave as fetch and merge so it will
> cause the update of remote/branchname branch. And it is kind of
> difficult to justify why they have to do git fetch after pull...
>
> Can somebody, please, take a look?



In your transcript, they can say "git fetch" (or "git fetch origin") an=
d
branch is copied to origin/branch, so instead of doing:

    $ git fetch origin branchname
    $ git log FETCH_HEAD ;# or whatever inspection using FETCH_HEAD

they can do

    $ git fetch ;# or git fetch origin
    $ git log origin/branch ;# or whatever inspection using it

In short, teach them that they no longer have reason to learn or run "g=
it
fetch origin branchname".
