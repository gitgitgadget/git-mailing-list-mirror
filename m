From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 17:37:34 -0700
Message-ID: <7vpr9y5nap.fsf@alter.siamese.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <200909101850.26109.jnareb@gmail.com>
 <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
 <200909102223.31602.jnareb@gmail.com>
 <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
 <7v4ora76vr.fsf@alter.siamese.dyndns.org>
 <9b18b3110909101619n6904a75dm10dd0b5717fb0d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlu9G-0002qF-HY
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZIKAht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 20:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZIKAht
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:37:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZIKAhs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 20:37:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF3CC2E064;
	Thu, 10 Sep 2009 20:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a+F0+6e4HltH
	/FoiFFyzFvNi04w=; b=QlYF6sLC9tsntAa7FJ+ziaNg8SAuy0AmqxS29LaMCao1
	nksI4VNOjVGLOX4+iUtUTsadA7oz/Kaa8j+/yxe3Z0lBbyMUIqkNEXDI7//jDlhu
	jIgxES+DPjTidcgNl0ENv862cpu9htacAr3IUH2To/pZ8w1qnUL3WP/FaM1OA6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ef785K
	oWRG4AUNbmciyIv3JnFV+/CEmXBmLbvi0h0wc0mzZ0vdgR1wLzOa88+hjKQssGYF
	1vkIP9WXuvJF7YH5tVpFqo+ZTFwcRsn76tnAA2awVjt8KnFWcwyaSDXCAwSaNCbj
	p2scE4fndAfK1zyy1yiU4q2ph3YuuWu8H44xo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DA12E062;
	Thu, 10 Sep 2009 20:37:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F0442E05B; Thu, 10 Sep
 2009 20:37:36 -0400 (EDT)
In-Reply-To: <9b18b3110909101619n6904a75dm10dd0b5717fb0d76@mail.gmail.com>
 (demerphq@gmail.com's message of "Fri\, 11 Sep 2009 01\:19\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 518F3348-9E6B-11DE-A12D-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128166>

demerphq <demerphq@gmail.com> writes:

> 2009/9/11 Junio C Hamano <gitster@pobox.com>:
>> John Tapsell <johnflux@gmail.com> writes:
>>
>>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>>> Dnia czwartek 10. wrze=C5=9Bnia 2009 21:46, John Tapsell napisa=C5=
=82:
>>>>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>>>
>>>>> > First, it would be consistent with how ordinary archivers such =
as tar
>>>>> > or zip are used, where you have to specify list of files to arc=
hive
>>>>> > (in our case this list is HEAD).  Second, I'd rather not accide=
ntally
>>>>> > dump binary to terminal: "git archive [HEAD]" dumps archive to =
standard
>>>>> > output.
>>>>>
>>>>> That could be fixed by outputting to a file.  git format-patch ou=
tputs
>>>>> to a file, so why wouldn't git achieve?
>>>>
>>>> "git format-patch" outputs to files because it generates _multiple=
_
>>>> files; generating single patch is special case.  Also git-format-p=
atch
>>>> can generate file names from patch (commit) subject; it is not the=
 case
>>>> for "git archive" (what name should it use?).
>>>
>>> What if it used the current (or topleve) directory name?  Wouldn't
>>> that work in most cases?
>>
>> Following along the same line of reasoning, it would work in most ca=
ses if
>> the output is literally named "archive.tar".  If it is not the name =
the
>> user wants, the user can "mv" afterwards, or give an explicit filena=
me.
>
> Why not $sha1.tar?

Why not $(basename $(dirname $(pwd)))-$(date).tar instead?

See?  archive.tar is as good a compromise (so is a.out from cc).

> Is it portable to assume that piping is always in binmode? From a
> portability POV i could imagine piping being a problem in this
> respect, and might be why tar provides a way to output to a file and
> not just to a handle. For example ISTR that on windows piping is by
> default in text mode. I think its not a showstopper there as you can
> change it, but still, from a portability point of view you might not
> want to depend on piping.

Windows is not a showstopper to me ;-).

But seriously, I am glad that you brought up about a potential issue wi=
th
pipe.  There is one fairly important reason that it is better to say

	GZIP=3D-9 tar zcf here.tar.gz .

than to say

	tar cf - . | gzip -9 >here.tar.gz

but it has nothing to do with binmode.  The reason is error detection.

=46or exactly the same reason, if we can say

	git archive -9 --output-file=3Dhere.tar.gz HEAD

it is much better than having to say

	git archive HEAD | gzip -9 >here.tar.gz

In other words, I am not opposed to supporting a "--output-file here.ta=
r"
at all.  I just do not want it to be mandatory.  I think that it is an
ugly kludge to force people to work it around with "-f /dev/stdout".

Oh wait.

That is exactly what we have, so what's the point of continuing this
discussion any further?  Can we just _really_ stop this time, please?
