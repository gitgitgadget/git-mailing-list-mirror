From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] rebase -i: write better reflog messages
Date: Tue, 18 Jun 2013 13:55:16 -0700
Message-ID: <7vsj0f2l6z.fsf@alter.siamese.dyndns.org>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
	<1371581737-10013-8-git-send-email-artagnon@gmail.com>
	<7v38sf40my.fsf@alter.siamese.dyndns.org>
	<CALkWK0==+Zs-Ej92VsHnF60_=RTigkKo+3xLew3JdavC3fbzoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:55:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2w9-0006ez-L7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab3FRUzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:55:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756282Ab3FRUzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD1E829A88;
	Tue, 18 Jun 2013 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWeTUWYqV7bce+uOR9REal7wnP0=; b=FT4f4j
	gGxq6wsZfUfGukyzbU1O2CxKSqolVg31pGEi6H9lB/6Fsaa8KZauNj0LOOEujpLV
	kdEorx6jAFB+5N5Yxak989HLAvWrENeg5EB1g/v/QM/tDzRpm3PvDSwAfu9BfrGy
	qgWlAjHkurKEMLmIUOs13DulNRn4tTsufqVb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BIUl/qXiXAYItgg3e0g3xyAQFjldAy3y
	optkDTlcOZk5S/QAVPQ85vIQw3WwfeAE/Ma1YRECxUWtWvxAtxFBO4VDahomFg3q
	1v1jQJFS4UYXtdGbqkWBaUejoYKBQMRCxlq1tkfDyvacbeDRhdNbSPeoA+aZdDgv
	znY+uaQZYCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0ADA29A87;
	Tue, 18 Jun 2013 20:55:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A9F629A85;
	Tue, 18 Jun 2013 20:55:18 +0000 (UTC)
In-Reply-To: <CALkWK0==+Zs-Ej92VsHnF60_=RTigkKo+3xLew3JdavC3fbzoA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 19 Jun 2013 02:08:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61F7802E-D859-11E2-8B9E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228316>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Why did this have to change back from branch-reflog-test to branch1
>> (which I used by mistake in "how about this" patch, but fixed in the
>> version queued on 'pu')?
>>
>> The reason I did not use 'branch1' in the version I queued on 'pu'
>> is because rr/rebase-sha1-by-string-query, when merged on top of
>> this, makes an assumption on where branch1 is in the test and
>> fliping its tip here will break it.
>
> Oh, okay.  Then just tweak before applying, if you don't mind?

Sorry, you've already used my time allotment for this week.
