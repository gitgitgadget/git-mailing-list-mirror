From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to patch git documentation
Date: Thu, 08 Mar 2012 21:49:09 -0800
Message-ID: <7vk42u9ve2.fsf@alter.siamese.dyndns.org>
References: <jjbqe9$8l3$1@dough.gmane.org>
 <7v1up2bikm.fsf@alter.siamese.dyndns.org> <4F5991D8.60207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 06:49:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5shf-0004j5-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 06:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003Ab2CIFtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 00:49:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2CIFtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 00:49:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A3F7AE8;
	Fri,  9 Mar 2012 00:49:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0xxZZDowhKscmX7T5Yr5TN0JpMo=; b=D5/JHO
	fyyijc1Coio8htoe1Bpcw5HT2YUnNXF0/865zyw5KOr/1Dxo+R8h+FnSKZ8DFNbl
	+ENM9RCTn+9SADwkvOlnswFPifqfgIqKdHpEtOI/i/CqM3Pe/W2JLD7IRHrvOrB0
	GRJ2+NdafbNF0ISoZPf23Ks/0iy4Fh2XBqhZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AnPQNFmWDjajaNazcj8LYCc77zs3ABUK
	ifJ6ixW3zoULSH7HOiIGEf01c27N7A7nuJO5dgCzQx95WGwJFnpl+QVYpRTkrGZ4
	jzlWSb9ftGQgQEo9/aZ+q1lLzJMGk3OLbPHwq6knSN4Ooq1QlqOz+MaWU/k0KTqL
	kH3UoV+iCgo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 604267AE7;
	Fri,  9 Mar 2012 00:49:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA2897AE6; Fri,  9 Mar 2012
 00:49:10 -0500 (EST)
In-Reply-To: <4F5991D8.60207@gmail.com> (Neal Kreitzinger's message of "Thu,
 08 Mar 2012 23:15:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98156A68-69AB-11E1-AC39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192679>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> On 3/8/2012 8:43 PM, Junio C Hamano wrote:
>> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>>
>>> What language are the git documentation *.txt files written in?
>>
>> Mixture of Pidgin English and a bit of AsciiDoc ;-).
>>
> Is it ok to submit patches to git.git using msysgit, and also from
> git-osx?  I'm not sure how fast I can get past our security people on
> the linux servers, if at all.

Honestly, I highly doubt if I could even tell if your patch was
created with "git format-patch" running on Linux, Mac OS X, Windows,
or CP/M-86 for that matter.  As long as the port of Git to the
platform is working correctly, that is.
