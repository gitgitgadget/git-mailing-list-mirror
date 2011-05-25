From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #11; Tue, 24)
Date: Wed, 25 May 2011 08:04:14 -0700
Message-ID: <7v62oy6cup.fsf@alter.siamese.dyndns.org>
References: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
 <4DDCA0D2.2070604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 25 17:04:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPFdQ-00084U-A3
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab1EYPE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:04:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab1EYPEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:04:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 61B074758;
	Wed, 25 May 2011 11:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0GxqZxb/Toq8TDq4dWs9XzyT4g=; b=VamE20
	m3PNoCxswp1/JtF61Nr18Cf6hfiPQ8Tn7c+3nFCghFO8Wqpqe+Hww7roHedNReVW
	uYUvQDE9AxkxP39nd3IRg63rscRciy47z60djiydIxV3LdycRYP85LNEAK3rTDUo
	rbdS47exKXb7UoPeVcWkk0w9axSvwMhhiw2aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rj8V0C2nPwz5arKp/9dpJ/VvjZ6oPjtV
	3+4ini53mFJ+6iWeGfwQDwpPGQR3FwVIB3p5SBu0sSeqbfiUxUhPW8jmS57z72Fh
	4X+6Oo56uSRNhfmnhqVLRzcVvfQjvG9u4YDYjA8d3fGUYPyu78Iojitp1ExOdDUl
	GeuAR0aG8Nc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1AE064757;
	Wed, 25 May 2011 11:06:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1F6F4754; Wed, 25 May 2011
 11:06:24 -0400 (EDT)
In-Reply-To: <4DDCA0D2.2070604@viscovery.net> (Johannes Sixt's message of
 "Wed, 25 May 2011 08:25:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9156605A-86E0-11E0-A77C-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174408>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/24/2011 23:45, schrieb Junio C Hamano:
>> * ab/i18n-scripts (2011-05-21) 48 commits
>>   (merged to 'next' on 2011-05-23 at 69164a3)
>>  ...
>> 
>> Rerolled.
>
> I see you promoted ab/i18n-scripts-basic to master. What are your plans
> with this topic? In its current form, git-submodule breaks in an obvious
> way on Windows, and other pitfalls may hide elsewhere.

The plan is exactly the same as any other topic. Keep in "next" to cook so
that parties that do care can try it out, list the topic in the regular
"What's cooking" message, so that parties that do care have enough chance
to find possible issues before it causes problems to people by hitting
"master". And get annoyed to hear issues only after the topic graduates to
"master". Because somethings things happen, try not to be too upset when
that happens. Instead, help people to fix issues before the release.

At least that has been the plan for me personally.
