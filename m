From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/resend] CVS Server: Support reading base and roots from 
 environment
Date: Wed, 30 Dec 2009 11:49:20 -0800
Message-ID: <7vpr5wz1hb.fsf@alter.siamese.dyndns.org>
References: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com>
 <7vocmwvmvr.fsf@alter.siamese.dyndns.org>
 <20091230224108.6117@nanako3.lavabit.com>
 <81f018ac0912300912g25887523g1bdf29fd6e31d011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: Phil Miller <mille121@illinois.edu>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4YS-0001ii-4Y
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZL3Ttc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 14:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZL3Ttb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:49:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZL3Tt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 14:49:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59D548C6E9;
	Wed, 30 Dec 2009 14:49:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=l8TsAXdv0k1EZarLkRK7Iewwhlo=; b=p50SmDqHZwUjMmfs08fM6MV
	C+cqEGHL2Dx7OnMegPIe34FLSzQj9Quw4i7EHEiipPe9SLX074OJz9ndBlUYH7zm
	O1IH07ybYplOOcYyWXLreUspWGxNr4xrNo76u5CmhQeIOizwaIqx+jXz0oaemY+y
	puq3Afq781jrGzjZCjbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TBEb171gykHiqNc02VkR+Hts3XbWivnuWnB3fCQB6EudprvRM
	GZcZ+i4lLHOHoSZvl4s/hF9Mt4ZtrE7JE9JZBYZYQ1XfyG+l/IkLT0+lPQU7qM3J
	oTsedN3xwPdhLYZJ7VTTOrCCPZfZ0QQnm/owqiutijnDoMktQkEZCLyz0Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21E078C6E8;
	Wed, 30 Dec 2009 14:49:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DE398C6E7; Wed, 30 Dec
 2009 14:49:21 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6EC8F814-F57C-11DE-88BB-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135920>

Phil Miller <mille121@illinois.edu> writes:

> I never resent with modifications as Junio requested. I've been busy
> with some end-of-year close-out stuff, and actually wanted to
> dramatically simplify part of the patch before the resend. I'll do
> that shortly.
> ...
> The documentation hasn't been updated, but the recent history makes as
> least some usage clear. I'll send more details in a follow-up.

Thanks Phil for status updates (and thanks Nana for prodding).
