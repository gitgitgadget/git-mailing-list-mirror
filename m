From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] remote-hg: allow refs with spaces
Date: Mon, 22 Apr 2013 16:03:08 -0700
Message-ID: <7vmwsqmamr.fsf@alter.siamese.dyndns.org>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
	<1366667724-567-14-git-send-email-felipe.contreras@gmail.com>
	<7v61zenqm4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0f+gJNNESJbYXQgG05Xn0xkkFJMJq6=XC9RsnCdAGzMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 01:03:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPlV-0003tg-7T
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 01:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab3DVXDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 19:03:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185Ab3DVXDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 19:03:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D9B618420;
	Mon, 22 Apr 2013 23:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DyDhmMCWmP4aGccpbWip8rhrZxY=; b=a7Btz9
	Z3vbgxQ0HlwDcISNVJPWwdQUdWlKMQwM1CsGLQ8+iM4d7/vXEhEjQa6nSP3Vro+2
	bM/ebRxx9CmETTYbuxnOnIONRL1iCVi7XhENoyhMO2TQ82sabz1REoHwWFQnVwA3
	Gkazgu+AIia0N90JL5scB9oos1aP8UBoTsTQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i5P5KzMLbGfb+bLLKlitOR4lydaweMpy
	a7IRpBHFzGx+EzCadTCWtIdm7Vbm+uD96t+g6jCHEh5tq5Dyv0rQPZDMELP+leyC
	LM8NMhCkb4z4+Sw7A1+ScAeFhkNbVYhqsTxcT+Z7qCEeDKrb1rowPSKDGJC+5ibz
	3tgqXqtJX5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64B201841F;
	Mon, 22 Apr 2013 23:03:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBC301841E;
	Mon, 22 Apr 2013 23:03:09 +0000 (UTC)
In-Reply-To: <CAMP44s0f+gJNNESJbYXQgG05Xn0xkkFJMJq6=XC9RsnCdAGzMw@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 22 Apr 2013 17:38:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD209632-ABA0-11E2-9431-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222128>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Apr 22, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Mercurial supports them, Git doesn't.
>>
>> Another important thing to note is that you represent a SP with
>> three underscores on our side, no?
>
> Probably, I don't think it's really important. Perhaps some users
> would benefit from this information, but they would be better served
> by a README, or a wiki, the commit message doesn't help them.

True, but it helps a reviewer to notice the missing documentation
;-)
