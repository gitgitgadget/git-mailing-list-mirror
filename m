From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 15:49:12 -0700
Message-ID: <7v4ora76vr.fsf@alter.siamese.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <200909101850.26109.jnareb@gmail.com>
 <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
 <200909102223.31602.jnareb@gmail.com>
 <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlsTV-0003EP-Ud
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 00:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbZIJWuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 18:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbZIJWuf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 18:50:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZIJWue convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 18:50:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20EC82D4B7;
	Thu, 10 Sep 2009 18:50:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JH+tcW6JQZXm
	aEU3UG3veBSdKTs=; b=Wb4vGMRoP33uu4QrQJkhKQgyO//6kuxzuPLJR6Kdehdy
	VUUc9RA6Usjn8N1dhGaXrF9PRHKPrSmvPZm3AoOy65j0khnSfLjDUxG0UWiyygeg
	50IrSywfITUivAmk56SIZOQ2FTvT7nwNGINFLbqoPvOFoO/YkBGbnGtwPwuDkdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yiLc7p
	A4SgZRtQ2m/TF58PjfBNss1El3pvfzq1pXsM6Z1839xdclUXU/JefIz92jY/B77U
	8OeG++p8USBVlML7q+GSuceNhdc+rU5Z2Pt8F8bJzM+zpt17FAYQXysRk++PCfGk
	P2EqvL3kLwS9XAVZCTCLBi5jdYg7DK2yqXNH8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0A262D49D;
	Thu, 10 Sep 2009 18:50:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6077B2D477; Thu, 10 Sep
 2009 18:49:14 -0400 (EDT)
In-Reply-To: <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
 (John Tapsell's message of "Fri\, 11 Sep 2009 01\:04\:05 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57FF6A72-9E5C-11DE-A7FB-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128157>

John Tapsell <johnflux@gmail.com> writes:

> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>> Dnia czwartek 10. wrze=C5=9Bnia 2009 21:46, John Tapsell napisa=C5=82=
:
>>> 2009/9/10 Jakub Narebski <jnareb@gmail.com>:
>>
>>> > First, it would be consistent with how ordinary archivers such as=
 tar
>>> > or zip are used, where you have to specify list of files to archi=
ve
>>> > (in our case this list is HEAD).  Second, I'd rather not accident=
ally
>>> > dump binary to terminal: "git archive [HEAD]" dumps archive to st=
andard
>>> > output.
>>>
>>> That could be fixed by outputting to a file.  git format-patch outp=
uts
>>> to a file, so why wouldn't git achieve?
>>
>> "git format-patch" outputs to files because it generates _multiple_
>> files; generating single patch is special case.  Also git-format-pat=
ch
>> can generate file names from patch (commit) subject; it is not the c=
ase
>> for "git archive" (what name should it use?).
>
> What if it used the current (or topleve) directory name?  Wouldn't
> that work in most cases?

=46ollowing along the same line of reasoning, it would work in most cas=
es if
the output is literally named "archive.tar".  If it is not the name the
user wants, the user can "mv" afterwards, or give an explicit filename.

What it does _not_ allow is to send the output to a downstream command =
for
postprocessing without introducing some magic token to say "standard
output" (e.g. "git archive -f - | (cd ../foo && tar xf -)").

If the default is to write to the standard output, we won't have all of
these issues.  People who want a file can name the file by

	git archive >my.file.tar

and people who want to pipe (which is 99% of the use pattern for me) ca=
n
say

	git archive | down stream commands.

Oh, wait.

That is exactly what we have, so what's the point of continuing this
discussion any further?  Can we just stop?
