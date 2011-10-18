From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #06; Tue, 18)
Date: Tue, 18 Oct 2011 11:09:31 -0700
Message-ID: <7v7h42gois.fsf@alter.siamese.dyndns.org>
References: <7vzkgyhh6n.fsf@alter.siamese.dyndns.org>
 <CABURp0po3C9-a4_cGm8gq71=gq2ELzHWBK0y7H=OEcY1=DUdsw@mail.gmail.com>
 <7vmxcygs1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 20:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGE6f-0002kQ-7z
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 20:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab1JRSJf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 14:09:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab1JRSJe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2011 14:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7BE65D8D;
	Tue, 18 Oct 2011 14:09:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0fOZW0ivO3AR
	tciu1fqqLd/mCgY=; b=IDwg1wViOhem4AKLs2KDaqOespTnB8+qcjIY8Yp2EFOH
	w1z7VWr0CInVtvA9F9hCNDAA9cWOKW23bwKX66/euRrz54+CbiK0WH85btfSBOIM
	0ijoqnksszpYlLUgX1LiUY3vGdCnFV1XeJAeO49Ahg29y9cuCIxQUf1miLk3Xm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=THtcu4
	kE3MQQUrycbQJ4Daoc6TigLpUWWTn+H35F0tind7h9btnTYYKUtd7/uoleelFB+Z
	QZt1hLvmCSMlbr6IDNfV6C43BZtmfKXLVgkd4+uDDU3N7WMTQwi5KoJgPcE6Oo20
	RvdtgZHS0epY8zr/waOj25vSE7IPntJgNw9PU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6D35D8C;
	Tue, 18 Oct 2011 14:09:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 550095D8A; Tue, 18 Oct 2011
 14:09:33 -0400 (EDT)
In-Reply-To: <7vmxcygs1m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 09:53:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54D1EA90-F9B4-11E0-AFE6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183893>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> On Tue, Oct 18, 2011 at 3:50 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> What's cooking in git.git (Oct 2011, #06; Tue, 18)
>>> --------------------------------------------------
>> [...]
>>> * ph/transport-with-gitfile (2011-10-11) 5 commits
>>> =C2=A0(merged to 'next' on 2011-10-12 at 6d58417)
>>> =C2=A0+ Fix is_gitfile() for files too small or larger than PATH_MA=
X to be a gitfile
>>> =C2=A0(merged to 'next' on 2011-10-06 at 891b8b6)
>>> =C2=A0+ Add test showing git-fetch groks gitfiles
>>> =C2=A0+ Teach transport about the gitfile mechanism
>>> =C2=A0+ Learn to handle gitfiles in enter_repo
>>> =C2=A0+ enter_repo: do not modify input
>>>
>>> Will merge to 'master' in the fifth wave.
>>
>> Do you want a re-roll of this with your is_bundle() changes added in=
?
>> I do like them better.
>
> Hmm, you may be right. I'll try to queue an update on top of the seri=
es
> and see what happens.

Actually there is nothing that needs re-rolling. We can just make the
jc/unseekable-bundle topic graduate at the same time as this one, and l=
et
the merge remove the is_gitfile() helper that becomes unnecessary.
