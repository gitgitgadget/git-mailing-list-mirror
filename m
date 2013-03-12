From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Tue, 12 Mar 2013 15:34:26 -0700
Message-ID: <7va9q85jt9.fsf@alter.siamese.dyndns.org>
References: <cover.1362069310.git.trast@student.ethz.ch>
 <7973d90cfcd86a3c15776b8718ad6bd84ee7b4ac.1362069310.git.trast@student.ethz.ch> <7vk3psicgf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 12 23:35:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFXmm-0001oT-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 23:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440Ab3CLWec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 18:34:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933701Ab3CLWe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 18:34:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA2BAAC9;
	Tue, 12 Mar 2013 18:34:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LHhTZl5UyPKefUnCmS5LXauU3N4=; b=Yr28Q1
	+Myj61i4DK6yvQpfoVdC5/F9r6/r1yaDfL4L6F1VJfGqw9VmUTn4Qua9olUaJfQu
	IswsUX+jGX37WYjtFrTdqcG6uQJP1rebvSa8Aik6R1oZetrBKK1TOWeGEglLKU0s
	NXBcGkOCVaum5ncQOFyB9Rr84xqTF6LRd4n+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bwuNY9QCUooaeqbKscw7R12CIil3K4ho
	UVMkhdLxKixcfAWYrTo40O9xCEJOP9BiIFrmq6lL2+L7hnnbxpwN/tbpEvtFvJkv
	iHSJHTgSlM1bPWVP81VRGjTc6Oin60650N+TLsvVSiurfOzDINA/y07gW9uVyQop
	qGFadno4ARk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9293CAAC8;
	Tue, 12 Mar 2013 18:34:28 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B47FAAC7; Tue, 12 Mar 2013
 18:34:27 -0400 (EDT)
In-Reply-To: <7vk3psicgf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 28 Feb 2013 09:18:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFE250DA-8B64-11E2-B8DE-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218005>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> To save the user a lookup of the last line number, introduce $ as a
>> shorthand for the last line.  This is mostly useful to spell "until
>> the end of the file" as '-L<begin>,$'.
>
> Doesn't "-L <begin>" or "-L <begin>," do that already?  If it were
> to introduce "-L $-4," or "-L$-4,+2", I would understand why the
> addition may be useful, but otherwise I do not think it adds much
> value.

It is a quiet-period so there is no need to rush, but did anything
happened further on this series?
