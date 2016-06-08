From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Tue, 07 Jun 2016 17:39:40 -0700
Message-ID: <xmqq4m94o6nn.fsf@gitster.mtv.corp.google.com>
References: <20160531220818.GB46739@zoidberg>
	<xmqqtwhd3lht.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606010919360.5761@virtualbox>
	<xmqqwpm8zyot.fsf@gitster.mtv.corp.google.com>
	<20160607225923.GA66447@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 02:39:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bARXA-0000Pq-WD
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 02:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbcFHAjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 20:39:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbcFHAjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 20:39:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DBE71229DA;
	Tue,  7 Jun 2016 20:39:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ctDaESNUUi84EKQ8N61jXIGBI7Y=; b=qN/dCe
	3pvg2Xa9K3XShW42bVC72NEzBt5jmUGPz8+28lEfHtIfO/6Yj4m9QAZ3TN/nFMkZ
	Bvuv1blLOTKXGetM96y4noZJSi4OewPTauOpKHNn9Bwe3bboI74zFLG/El1jGWTA
	8GKBDso9hzQHQjFDDL4thn0JDwxI4DxLUvuzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=almq6UclAPHdd8sr6UhD/ZO5Z0WvvSqN
	3jjdQpD6PQH0YHpPn98GRc1q6sM3ghjd6yKLQ8orqdJoxCQCQ0UqN3TKFxyO2tmQ
	SldNAcUSg7ST/86i/uXw0/XrUs/wzvXc2ReoJnpFMeP4oVmrYGT00AYKLhVvY74k
	GUWJopfWPq0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3C5B229D9;
	Tue,  7 Jun 2016 20:39:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D01D229D7;
	Tue,  7 Jun 2016 20:39:42 -0400 (EDT)
In-Reply-To: <20160607225923.GA66447@zoidberg> (Edward Thomson's message of
	"Tue, 7 Jun 2016 15:59:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D756612-2D11-11E6-A626-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296752>

Edward Thomson <ethomson@edwardthomson.com> writes:

> On Wed, Jun 01, 2016 at 09:00:34AM -0700, Junio C Hamano wrote:
>> 
>> Unlike the "something like this" we saw earlier, this draws the
>> boundary of responsibility between the caller and the API at a much
>> more sensible place.
>
> This makes sense to me - Junio, are you taking (or have you already
> taken) dscho's patch, or would you like me to squash it and resend?

I didn't plan to unilaterally squash them into one patch without
hearing from you, so I haven't--Dscho's fix-up is queued directly
on top, ready to be squashed in.

So either is fine by me, either you send a final version to replace
the two patches on et/add-chmod-x topic, or you just tell me to go
ahead.

Well, you practically said the latter already, so I'll do the
squashing.  Thanks.
