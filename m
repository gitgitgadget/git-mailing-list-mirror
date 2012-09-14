From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestions for "What's cooking"
Date: Thu, 13 Sep 2012 19:29:12 -0700
Message-ID: <7vboh99w1z.fsf@alter.siamese.dyndns.org>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
 <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
 <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
 <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com>
 <7vmx0t94rc.fsf@alter.siamese.dyndns.org>
 <CAH5451n3bAkidWrtu4sy=NXPYZ7wWc+WFoReOm98xq2S22+55w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 04:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCLen-0003lb-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 04:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab2INC3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 22:29:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508Ab2INC3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 22:29:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B98FB94BE;
	Thu, 13 Sep 2012 22:29:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l7AWe7h11+bb2pCxIcP+xb7PR3Y=; b=Tcxj71
	j266q9chLkBJSqiQyjUkNmxAqk0fRBgQOhp7poKnu0E1uMKuUsjQZxWE5EeJRpn8
	NhL41UhnhZW4ikgKuFbuToefrCNLtRrtLrqyHOUv5VQW7MjxvHA3MBSvWnlwK3SC
	3q6bGqH3oF7aKYa8vVlHLMZTV/HeY6NbLtX6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VlU169mJ8GBo0+q1x0eTv6siHxpjG0vh
	OLfFpA6TC29flNwtcIFND+2LVV8ZvMkaMZvzrzoM19Jt3Sjbng9AvlREaHJmOen5
	Q8ChJcNTzhlzVI8sqcyqu21coZowVSGKgceO9pgyxtWBQf6M7C8bEIAJpGfbE1mq
	uwHEBVwBn1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FF0494BD;
	Thu, 13 Sep 2012 22:29:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2FED94BC; Thu, 13 Sep 2012
 22:29:13 -0400 (EDT)
In-Reply-To: <CAH5451n3bAkidWrtu4sy=NXPYZ7wWc+WFoReOm98xq2S22+55w@mail.gmail.com> (Andrew
 Ardill's message of "Fri, 14 Sep 2012 12:11:49 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F95E851E-FE13-11E1-B684-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205446>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 14 September 2012 04:06, Junio C Hamano <gitster@pobox.com> wrote:
>> Andrew Ardill <andrew.ardill@gmail.com> writes:
>>
>>> <short-branch-description>
>>>   <long-branch-description>
>>>   <notes>
>>>   <next-steps>
>>>   * <branch-name> (<creation-date>) <number-of-commits>
>>>     (<merge-status>)
>>>    [list-of-commits]
>>>     (<branch-usage>)
>>
>> I do not see how it makes any sense to have the "This is where the
>> section begins with, and its name is this" line in the middle of a
>> block indented in such a way.  Care to explain?
>
> I'm not quite sure what aspect you are referring to,...

Just this part, as I do not have much time.  Here is your reordered
one I will reject:

  A > jc/maint-blame-no-such-path
    >   "git blame MAKEFILE" run in a history that has "Makefile" but not
    >   "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
    >   confused on a case insensitive filesystem.
    >
  B >   * jc/maint-blame-no-such-path (2012-09-10) 1 commit
    >    - blame $path: avoid getting fooled by case insensitive filesystems

I was noting that B which *is* formatted as a header line (it EVEN
has a leading asterisk to make it clear that it begins something
new) is in the middle, and you added a redundant A that is not even
marked clearly as a header line.
