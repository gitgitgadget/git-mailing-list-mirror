From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mini bug report origin/pu: t1512 failed on Mac OS X (commit
 957d74062c1f0e ?)
Date: Fri, 13 Jul 2012 16:31:29 -0700
Message-ID: <7vk3y76xwu.fsf@alter.siamese.dyndns.org>
References: <4FFDDD5E.3080309@web.de>
 <7vipdtdhla.fsf@alter.siamese.dyndns.org>
 <7va9z5dgff.fsf@alter.siamese.dyndns.org> <5000A483.4090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 01:31:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SppKk-0000Gv-Eo
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 01:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab2GMXbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 19:31:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756316Ab2GMXbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 19:31:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C6185F6;
	Fri, 13 Jul 2012 19:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjWVQSuw60X34hP47u8kS2WbrZ0=; b=kX4mcv
	KX8APd6VjsvIuS0tJ1JspL2bD4oBw/Dtkt/pOdiq47arAnmprszAN2uHud6iROma
	eG7BR0/WLBDesky/FGqA2qmvpsjcG8GgW1isimuDqw3wxDFuqxM/6Aukm9bdp8mO
	5t6g6O8qa7Xl6m1ql/rwyXx7lRNXE2hI++UX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n5Phlb1N//wvu7tggxvyUdlHCExOJ16c
	vUAtwa2XKjrN9G4oT/54B6oSTqKnRNKOMtjRw7mbzsy4z0FD5RCilJmQ14ROOH/Q
	bpSITl9rrLYldvhNnKY0avF8JNhN/v6mDLlrNf//dqpZQW/FZ3qxzl2UFg8JgrVz
	RGba3pwyqxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA0E85F5;
	Fri, 13 Jul 2012 19:31:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B578885F1; Fri, 13 Jul 2012
 19:31:30 -0400 (EDT)
In-Reply-To: <5000A483.4090307@gmail.com> (Stefano Lattarini's message of
 "Sat, 14 Jul 2012 00:43:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E000C732-CD42-11E1-983B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201429>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 07/12/2012 01:30 AM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> I think the other tests in t/ prefer to unquote it so that we would
>>> ignore spaces around "wc -l" output, i.e.
>>>
>>> 	test $(wc -l <actual) = 16
>>>
>>> Thanks for a report.
>> 
>> -- >8 --
>> Subject: [PATCH] t1512: ignore whitespaces in wc -l output
>> 
>> Some implementations of sed (e.g. MacOS X)
>>
> 'sed'?  Shouldn't this read 'wc'?

Heh, funny typo.  I don't know what I was thinking.
