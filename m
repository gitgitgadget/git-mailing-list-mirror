From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] remote-bzr: massive changes
Date: Fri, 26 Apr 2013 09:51:17 -0700
Message-ID: <7vy5c5xmka.fsf@alter.siamese.dyndns.org>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0XHXbX5brcxv-NROJ=PSSzi3oEzQv81=f3-1-zcypQuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 18:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVlrp-0001Gp-4u
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 18:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab3DZQvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 12:51:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab3DZQvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 12:51:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF5CE1A91E;
	Fri, 26 Apr 2013 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O3zWJXnFyn6Iqwovdqsie2gV/jU=; b=GH0jaY
	C5uPUpDmQIud/9ZLJ/vWU7OOAUp3BPBalV7VTnuexAcUG29N16RyE6NjayV08BXA
	PARrHDaXk41rBxDxMbkG09CO9HuD7OUlvkPoEvJnVr3yORrhBmbXlT6Cuh6WrPlZ
	+dD/df4gVLurPy5y5sGzzNP+jJJRyNEnAJX5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgKSKFc7o3+SKYG2hQ0hMhQS9yHVGGoe
	UgaOz0+jTrOrmDcF3Uey1nLf68E9yriYwlHnJ8K3mS6iC/jiQz+LOQOfL91jpVxW
	6gStK/CuFjzTfkkRKWvXUIM4SDAJNQJ3HJIW2TVQtikhJ5MfdUY3YlxfZk7HF+5g
	siobv2v906w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11F91A91D;
	Fri, 26 Apr 2013 16:51:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 411441A91B;
	Fri, 26 Apr 2013 16:51:19 +0000 (UTC)
In-Reply-To: <CAMP44s0XHXbX5brcxv-NROJ=PSSzi3oEzQv81=f3-1-zcypQuQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 21:35:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 849AAA76-AE91-11E2-9DDF-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222540>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 25, 2013 at 8:07 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
> I forgot to mention; these apply on top of the previous 'fixes and cleanups'.

Then I should probably wait for v2 6/9 of that series is rerolled.

There could be ones that you may want to reroll other than 6/9 in
that, I didn't have time to look at the backlog. I'll be whipping
the -rc0 into shape today and it is unlikely I'll have time to look
at this or the previous one today.

Thanks.
