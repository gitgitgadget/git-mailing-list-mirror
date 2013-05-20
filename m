From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] remote-helpers: test fixes
Date: Mon, 20 May 2013 16:13:46 -0700
Message-ID: <7v7gits0r9.fsf@alter.siamese.dyndns.org>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2sltgj4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0gK5EgD-pJb1NVrpJvYeyXmN_nS6MT7renFHhne1cZJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 01:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeZH7-0004st-O2
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 01:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396Ab3ETXNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 19:13:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757335Ab3ETXNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 19:13:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C67C20EB5;
	Mon, 20 May 2013 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E47X6riLl3/v6i0Z/m2UKbb53Bc=; b=ZkSd6z
	CzfM+o0nNtYKwyyfl0lpDCuInT+OrKwZQF82FCd7AtmYTxiFXQM6jhRuYvyw5Vsz
	0uQviQOQWLavvxKH273Jz50OmT/GTvNDxba40PHysCiFnECgGzr5eEY9lt2O/m7f
	Q4BUfNq4a1dE4q/jrBM+2Z/tEElVkHGZWolrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2rloOuTULODJEAhqY2V8j9Vnfwz9rsr
	7/2K+ROu9iLf2JPt3pEyftOyJrG6Lt3Y1Tyo6UDcosy+/mDy0kHWoLSLmLT7JHwu
	pBF7WckwSppsrySXbpguhkFVcOpgMja6lbs5CTk2kbacqr/zWqN+oCUCtcoZjCzV
	pBjNtQt1hIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53B4120EB4;
	Mon, 20 May 2013 23:13:48 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B262520EB2;
	Mon, 20 May 2013 23:13:47 +0000 (UTC)
In-Reply-To: <CAMP44s0gK5EgD-pJb1NVrpJvYeyXmN_nS6MT7renFHhne1cZJg@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 20 May 2013 17:53:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECDE5032-C1A2-11E2-83B5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225001>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, May 20, 2013 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Hi,
>>>
>>> I've setup a project in Travis CI for continuous integration with very good
>>> results, however, I had to apply a couple of fixes.
>>>
>>> I'm not sure if this is v1.8.3 material, but here they are.
>>
>> Thanks; I'll queue them at the tip of fc/remote-hg to graduate soon
>> after 1.8.3, then.
>
> No, they should be graduated first. The tip of fc/remote-hg is in pu,
> no? I have rebased that branch and squashed some fixes so every commit
> works on all versions of Mercurial. I will resend all the patches, the
> only reason I haven't done so is that I didn't want to create more
> noise before v1.8.3, and you said I was the one taking the decision
> when to merge remote-helper stuff to master.

Then is this v1.8.3 material?  Please do not stay "I'm not sure" for
very long.  I do not think we want -rc4 only for a contrib/ stuff.

For today's integration run I didn't want to wait so tentatively
they are queued at the tip of fc/remote-hg, and it is too late to
redo everything I did today, but I can requeue them for 'master' in
the tomorrow's cycle if you want.
