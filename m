From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: merge with the default upstream with no
 argument
Date: Thu, 05 May 2011 10:33:12 -0700
Message-ID: <7vy62l833b.fsf@alter.siamese.dyndns.org>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
 <7vpqphasbr.fsf@alter.siamese.dyndns.org>
 <7vd3lharwf.fsf_-_@alter.siamese.dyndns.org>
 <BANLkTimXFt-RFSPOfv8Ge+boPS_e3NLXkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jared Hance <jaredhance@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 19:33:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2Qa-0003IV-3i
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab1EERdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 13:33:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1EERdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 13:33:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D715E5A90;
	Thu,  5 May 2011 13:35:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MqkO1Qr0MnQkrLQ3Bce6OKlLxGM=; b=a3XLlE
	bhPrFkQI+Dv7y8m58n6w7Uf6T8bt1CLt7E6E3fMwO8FHGOy/1o+VUcpcO3beUKkb
	jfgHiXJSt/1YjUXjEM+O/PZZ/eNEyicCOqBc/WmvQWl8OelJKDclLvlet7imfzse
	qMD1PLafJRRlJTJMvJ/eTroQ6fYYEOaDNqYs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pK5Q+B9dFBi7kqPtv5qnXadVt8qN4UT/
	jAMEyClsyAuJTW19iJ+oCInQXWTOeuqj8ssrd8Iux116BM6qtZvnId8dMx0jw1sB
	vNnjYeRiCYxMbDkIqzRS2uTS+ddnVX2/hQU0tDWQwevmLl+bVhrqURDlvpidVbqR
	ikqdrMLljN0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A309F5A8F;
	Thu,  5 May 2011 13:35:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 856BD5A8E; Thu,  5 May 2011
 13:35:18 -0400 (EDT)
In-Reply-To: <BANLkTimXFt-RFSPOfv8Ge+boPS_e3NLXkA@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 5 May 2011 17:05:30 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DE39F0A-773E-11E0-A855-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172856>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Mar 24, 2011 at 9:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "git merge" without specifying any commit is a no-op by default.
>>
>> A new option merge.defaultupstream can be set to true to cause such an
>> invocation of the command to merge the upstream branches configured for
>> the current branch by using their last observed values stored in their
>> remote tracking branches.
>
> FTR. It's actually merge.defaultotupstream, not merge.defaultupstream.

True but that milk was spilled long time ago.  The doc and code at least
have it spelled correctly, no?
