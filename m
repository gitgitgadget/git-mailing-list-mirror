From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Get correct column with for options in command usage
Date: Tue, 05 Feb 2013 08:09:05 -0800
Message-ID: <7v38xavj32.fsf@alter.siamese.dyndns.org>
References: <0b035132df6de2cac56ac59d66b04f30e90ad760.1360049671.git.worldhello.net@gmail.com> <20130205121552.GA16601@lanh> <CACsJy8Ci05C1mKDGp_YzP0H6G0Y40K8MUUq+D6NzjtPGRNms0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:09:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2l5Q-0000hR-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3BEQJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:09:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab3BEQJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:09:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FAE0B136;
	Tue,  5 Feb 2013 11:09:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ZPYaIDAt/7UgyNlQUom9tBBZm4=; b=QN75Cf
	lp2MfycKar9MjJcHY7V5R2L6DzZ3slDjDbhjdw4Tl9e37Qh3wKJ+otXsUSlWCA1j
	sm6LCZXZwTCfip4vblWXNsFRY9xgVceHLWr7ozKho5o25131UQArft1yMaKDvWLJ
	Rl6IlfSyRlNs3mGaQu7lsIhnNAvs9E45YXg0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYPa25elmD1QFvS7Z4a4LZLK12+KNGgP
	hgMDdvKaNG9a1bkcX8JFejdlN5sQmPdSj/79sTBf75tEqyHkWNoUbbgPnsAc5s8b
	+8QZFwWg5XtYIF5DpCyzAbC6oEt6eCf7e1XEnb+AoCftHUaJ5T5yEj+lFJOC2+w8
	0yE2sR/oORE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6309DB134;
	Tue,  5 Feb 2013 11:09:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4C42B12F; Tue,  5 Feb 2013
 11:09:06 -0500 (EST)
In-Reply-To: <CACsJy8Ci05C1mKDGp_YzP0H6G0Y40K8MUUq+D6NzjtPGRNms0g@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 5 Feb 2013 19:18:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E21AA24-6FAE-11E2-A681-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215512>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 5, 2013 at 7:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> +       fprintf(outfile, sb.buf);
>
> Use fputs instead. I looked up fputs man page but somehow still left
> fprintf there.

Once the streams of "oops that was wrong" comments are done, I'd
appreciate if one of you guys send a finished patch for application,
instead of forcing me to follow all the messages in the discussion
and picking up pieces.

Thanks.
