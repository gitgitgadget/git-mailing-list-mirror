From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove deprecated OPTION_BOOLEAN
Date: Mon, 29 Jul 2013 11:50:35 -0700
Message-ID: <7vzjt5yzd0.fsf@alter.siamese.dyndns.org>
References: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com>
	<7vbo5l1c5a.fsf@alter.siamese.dyndns.org>
	<51F6AEA5.7040504@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3sX0-0001Sp-Kw
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983Ab3G2Suu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:50:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab3G2Sut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:50:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CD5034987;
	Mon, 29 Jul 2013 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=51BsK+dXaupsVuQsqJhoVs1a/nE=; b=mlGq86
	jA4DImoN9FOUNnHP8r+6bImbG/1viqfbQhaW09JxOj1jRC/vRERh8loWzwdgpE2L
	PW/mf9kkSEl7KaSsuWoUnzIR2aaVNQqyW+6kh04fOlIh903e7nY+GtnW3firvD8v
	FB/SR8LmbHziL9bLIy+tHL/0C6cHVz2AFP2+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fy7OTpt5DozMok/6al+MVwTXI8v4GJ7l
	NS7C5M+RSRledX7BulUMyHQ86P8zK5X3N11zs1cFNI9qRx+CTCPSFq92mC967lYB
	vVTx8FF2KbeuaiZppajAI4uZrUkKONhEGQWCDtkqDfcPm3OKDom5nHSnkwDoItMt
	+IIE5IYDkSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC4AD34986;
	Mon, 29 Jul 2013 18:50:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B668134980;
	Mon, 29 Jul 2013 18:50:46 +0000 (UTC)
In-Reply-To: <51F6AEA5.7040504@googlemail.com> (Stefan Beller's message of
	"Mon, 29 Jul 2013 20:04:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C795E038-F87F-11E2-8516-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231319>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 07/29/2013 07:58 PM, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>> 
>>> So recently Junio released -rc0. Is that a reason to not
>>> send out patches, which do not do bugfixes? So the following 
>>> commit for example doesn't fix a bug nor does it add a feature.
>>> Is it fine to send out such kind of commits during the -rc
>>> times or better wait for the next development cycle?
>> 
>> It would be a good idea to show it to others as a preview of what to
>> come even in a pre-release freeze period, so that people holding
>> real patches in the affected area can work with you to avoid
>> conflicts.
>> 
>> But I would not expect them to be applied to the upcoming release,
>> nor even 'next'---this largely depends on the maintainer workload.
>> 
>> Thanks.
>> 
>
> Thanks for the answer. Let me rephrase the question a little bit:
> Would you rather encourage to send it out now, or later?
> ("I'll apply it ot a local branch and eventually remember it next
> release to merge." or "I'll forget about such stuff, you need to
> resend it anyway.")

It is closer to the latter ("I'd appreciate if submitters let me
forget about them"), but still you may want to send them out for
early reviews from others.

>
> Regarding possible merge conflicts I'd be happy to resolve them
> and not add a burden to people doing features.
>
> Stefan
