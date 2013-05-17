From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-bzr: fixes for older versions of bzr
Date: Fri, 17 May 2013 11:01:16 -0700
Message-ID: <7v7gixzdsj.fsf@alter.siamese.dyndns.org>
References: <1368810619-18419-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1-RdmM9vs=XSvN1KNOh92Zr=nJWHGR0MZZV9BFXG_3JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 20:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOy3-0001si-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab3EQSBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:01:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab3EQSBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:01:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4330F1C200;
	Fri, 17 May 2013 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ra/VXJxaz0SloU/MS+pyg3hFQRk=; b=J0Aclp
	5bkvgLMxvmiZrjc6P/HZ+VRDfT1t6dePdoYFvfVzbQFEw6iNUpkBztW8sCwIUOPx
	RLm0Z8BSaf5JGsOrujgkmSOnGEUWozP6dMKnLCf973a5CUlft8owND611yhDNzoU
	nhc47LMU8RB/t63746SUWM6Jb6T0d+LNQE5rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L51m0eHuQgRGPmqbQ0YdrfC2jA47mzot
	112ixqhdaPbtYSG472biuOlBwYzW1pgdkT7RH18Tu/GW5frjC7/DrctUeHAyFIc3
	OCJbYkJ1d9XDizlJf7SWw1mpvyWmJrOlNY0KLKxrtmVKQ4ACnJl9dmtUIMWdjbmn
	m8bCE9uNXh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B3AB1C1FF;
	Fri, 17 May 2013 18:01:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B18DF1C1FB;
	Fri, 17 May 2013 18:01:17 +0000 (UTC)
In-Reply-To: <CAMP44s1-RdmM9vs=XSvN1KNOh92Zr=nJWHGR0MZZV9BFXG_3JQ@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 17 May 2013 12:25:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5C19F88-BF1B-11E2-B7FD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224724>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 17, 2013 at 12:10 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Up to v2.0.

Is that "down to v2.0"?

>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-bzr | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> We want this for v1.8.3, otherwise it wouldn't work in older versions of bzr.

I take it that somebody tested this with both new and old versions
so that the old way you rewrote the code with is still supported by
the more recent ones.

Will apply before 1.8.3-rc3; thanks.
