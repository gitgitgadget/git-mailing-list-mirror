From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #09; Tue, 30)
Date: Tue, 30 Sep 2014 14:09:09 -0700
Message-ID: <xmqqppecrf2i.fsf@gitster.dls.corp.google.com>
References: <xmqq38b8svrd.fsf@gitster.dls.corp.google.com>
	<20140930204704.GI3770@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Sep 30 23:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ4fe-0001TN-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 23:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaI3VJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 17:09:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51228 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbaI3VJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 17:09:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 341763FAA1;
	Tue, 30 Sep 2014 17:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QnwGW+XAl9nKgA2DqNxWK1IGhHk=; b=HU20R+
	+Z+w+tDd5Doz7lwwd2x073HE1eRyvK3bARPqTPH7DOCvBFgia2SHs57lSBguNzc4
	00vf6PW13e19Cd7yxn46GgHnzQtkaHzrYKExiWYlvbrl0jDMox3zjZ2bOpiSeJ9D
	zqT6T2I1jgfLzhaugm0dL4DyG6V1MRNQtxKzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uP1/HJgLBF/A/DuIL/3FC6QobJ0MlIT/
	RO2zNz0y87QBrcLQDIq2mNbOFv1MEULOA2DK3vuzL9PxMEjxqEA4zyJfEMOk0JtC
	2LseXyWyUpDL/ArC5z17kzjG1p6JbQDd/mjM00oL5f0zYv6eaTftl5+9qR00CT+N
	jhMP1nPq6EA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5E953FAA0;
	Tue, 30 Sep 2014 17:09:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 30EB13FA9A;
	Tue, 30 Sep 2014 17:09:11 -0400 (EDT)
In-Reply-To: <20140930204704.GI3770@odin.tremily.us> (W. Trevor King's message
	of "Tue, 30 Sep 2014 13:47:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 063A0474-48E6-11E4-A477-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257682>

"W. Trevor King" <wking@tremily.us> writes:

> On Tue, Sep 30, 2014 at 01:23:18PM -0700, Junio C Hamano wrote:
>> Here are the topics that have been cooking.
>
> It looks like my boring git-mailinfo doc patch [1] fell through the
> cracks here ;).  Or maybe it's just cooking a bit longer before
> getting queued?

Nobody is cooking it as far as I remember.  Did I see any discussion
on it?

I looked at the new text and I find it fairly objectionable.
A review in a separate message will follow.
