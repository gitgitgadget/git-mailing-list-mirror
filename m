From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pushing branches
Date: Sun, 22 Jul 2012 11:40:54 -0700
Message-ID: <7vobn7skp5.fsf@alter.siamese.dyndns.org>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
 <7vhat2toz8.fsf@alter.siamese.dyndns.org>
 <CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
 <CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
 <CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
 <CAJsNXT=-Ap0zJqK2F_3uJ7secmq7uvnSc218x+NoYdO5pLJAMg@mail.gmail.com>
 <CACnwZYdUzk74znPs4F+xz3haA3QhA9-DbR3mWWEVMfnztp-oCA@mail.gmail.com>
 <7v7gtwucx7.fsf@alter.siamese.dyndns.org>
 <CACnwZYcP7Ke-zyMLT8JBGt_BHS22G4cN6GYe+yauxXF6cVLZ1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 20:41:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St15U-0002t1-8t
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 20:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab2GVSk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 14:40:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab2GVSk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 14:40:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40D0B8CD0;
	Sun, 22 Jul 2012 14:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RN3Opgl8MFH4iNrtTAOm72AgSdQ=; b=uh8GLv
	My8YCrwmagX3ApLnURstjIXTfhjAI7FdZ94LnB6KY9yJymdgnS24D5Jez2XYi+AK
	wq1YdYca/XmAcc0c61lZTYEXTKbktKoysL/TSgzaz7RyD+mVdrW/IRgFm4mZfyyV
	VApsf3vLw5Ccjwwir/1p6nLcxFhaVujvywkqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MkSYn8A0bK5iG3SSMXV3Q+cIG0Q6ZuE6
	1ipJjdnNuE/f9w8iKobk8SH7yhdo0xeBAgeXooQqmoKhkH4AMbIsljV8avkOGps1
	MwJHwjIsRcXydh1ud1CSnozLDupte/rqrfgMAYAotmpCtFJcB7D1eRNfPw06acXb
	WM781ZF4oDQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295C18CCF;
	Sun, 22 Jul 2012 14:40:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 626ED8CCE; Sun, 22 Jul 2012
 14:40:56 -0400 (EDT)
In-Reply-To: <CACnwZYcP7Ke-zyMLT8JBGt_BHS22G4cN6GYe+yauxXF6cVLZ1g@mail.gmail.com> (Thiago
 Farina's message of "Sat, 21 Jul 2012 23:54:21 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C60B9014-D42C-11E1-9BC6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201855>

Thiago Farina <tfransosi@gmail.com> writes:

> On Sat, Jul 21, 2012 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Yes.
>>
>>> Hence does not make sense to ask git to do "push origin master" while
>>> inside feature-work branch.
>> ...
>> No.  As long as you know your master is ready and suitable to be
>> published when you ask "push", the command perfectly makes sense; it
>> does not matter on what branch you are on.
>> ...
> In my case it wouldn't because I do not modify my master branch, I
> just fetch upstream, merge upstream/master into my local master branch
> and switch to feature-work, then git push origin master will always
> give me "Everything up-to-date" I suppose (that is what always happen
> in my case/workflow).

It would not make _any_ sense to ask "git push origin master"
regardless of which branch you are on if that is the case, as you
are not modifying, then.
