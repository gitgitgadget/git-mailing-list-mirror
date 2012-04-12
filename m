From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] Hierarchical reference cache (once again)
Date: Thu, 12 Apr 2012 08:36:12 -0700
Message-ID: <7v4nspgdxv.fsf@alter.siamese.dyndns.org>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
 <20120412064459.GD27369@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIM4K-0004ph-D3
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934457Ab2DLPgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:36:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934385Ab2DLPgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:36:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A67B267BE;
	Thu, 12 Apr 2012 11:36:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ZkjB892bTHtiOnG4mcUsMYxMVY=; b=dILEXT
	+WfB0/EEH2bu7VyVu9IbrLy1hfzVMo0J8xvWLX8K+GrCq9AO/Mb3CbhSmgRXDfxv
	iUb6iEhI67X2R5fmZk9kB4bQMxcjP6kchzku+iYu2GP+Rx4VVQZYyKzzpWQdilxh
	f4h6H1W2e7wTUayNRDTxrGKGzH/wgyzhaJAa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V4aJitQypwJ74mH9SifRbC3spSYXaAbd
	MCXHBFpANTa2K1/ykPmNa22bHXBrXFnv1X1eA2dz6kpLSUv2ckVSuBwU7rFJZPCD
	SRllSTN6BckPspr5SbSebRlEgpW6HjCtkD4aEiSHFHCsfpClpSo2/RPce5AoCzlc
	6j2BrkZX5OE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C8E867BD;
	Thu, 12 Apr 2012 11:36:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3027667BC; Thu, 12 Apr 2012
 11:36:14 -0400 (EDT)
In-Reply-To: <20120412064459.GD27369@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Apr 2012 02:44:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CD4B80A-84B5-11E1-8E6C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195337>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 10, 2012 at 07:30:12AM +0200, mhagger@alum.mit.edu wrote:
>
>> Michael Haggerty (15):
>>   refs.c: reorder definitions more logically
>> ...
>
> I read through the whole series and didn't find anything noticeably
> wrong.  Overall, it was quite readable for such a large series. Thanks
> for breaking it up as you did.

I hate myself doing this, but...

	<aol> me too! </aol>

The series looked very readable, unlike the previous huge rounds.

Thanks.
