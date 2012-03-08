From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 08 Mar 2012 08:28:27 -0800
Message-ID: <7v4ntzf45w.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <m3wr6vs7a2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5gCh-0005hd-Cm
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 17:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373Ab2CHQ2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 11:28:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216Ab2CHQ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 11:28:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 838897732;
	Thu,  8 Mar 2012 11:28:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CD45PlIAaLujcQpFyGLKukXy5W0=; b=syMhMu
	7jpIJ1NaKXJBQYiTn30PYOd+ExJKJMC4BToMOZpfj9xoMUunxTCadxVOeC1V+WIs
	/hdF2QHKPuyjsJDWyY6r5kufqmgoPoP+B/TR9ujxJOpKbQJ7m9L4jbtsnpEYOXqJ
	82gp00Ss2gqvpUQzBMff7A4b8L73LCa/nBnEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1QO80U3toDIhD8Suto6QJdcg/6LwXnR
	KllSmEEm6+MO/9CbRviIjyS5vCChkEzlUcEYv4nLLxzmOAFgcP2Eh8ydv4JlMeMO
	RRzVuJ3hmqZGHX3AH4kZOD/I5mYr7T8PvTxXw+Ub17zRXn0sW/mrfHmBvdB63y4D
	rj8TXfo36pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B5787731;
	Thu,  8 Mar 2012 11:28:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 105197730; Thu,  8 Mar 2012
 11:28:28 -0500 (EST)
In-Reply-To: <m3wr6vs7a2.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 08 Mar 2012 02:42:49 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCE27766-693B-11E1-A285-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192615>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> Fixes since v1.7.9
>> ------------------
>> 
>> Unless otherwise noted, all the fixes since v1.7.9 in the maintenance
>> releases are contained in this release (see release notes to them for
>> details).
> [...]
>
>>  * "gitweb" used to drop warnings in the log file when "heads" view is
>>    accessed in a repository whose HEAD does not point at a valid
>>    branch.
>
> It looks like fix for fixed-string project search is missing.

Hasn't it been already fixed in the 1.7.9.x maintenance track?
