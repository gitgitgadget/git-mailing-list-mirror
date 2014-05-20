From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: test "Nothing to do" case with autostash
Date: Tue, 20 May 2014 11:34:17 -0700
Message-ID: <xmqqfvk4z4d2.fsf@gitster.dls.corp.google.com>
References: <CAPig+cSWrc-W+9CZQ9vF-E3xcLY3OFoRMpHLb3K8Vsx3iz1Mjw@mail.gmail.com>
	<1400572171-28372-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ether@cpan.org, felipe.contreras@gmail.com,
	philippe.vaucher@gmail.com, artagnon@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 20 20:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmors-0000Wn-3U
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbaETSeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:34:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50518 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbaETSeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:34:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2EBF18F5B;
	Tue, 20 May 2014 14:34:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yl7IEiGO9FZGbe/P7BfZYsnnDY0=; b=aN5v+I
	7pSIPEbqWnLsAmYpFEfh50jXOgFY9sAtIC189gElNNmmM3c6PkXTvrDiE+SOPTTk
	kTcicxgVHWynSYao2A1tEAn7xNugTlYH4OCT+qQgW4ZWYUOY7i663qWpLKFgjslC
	ynNP3MivCK+ndfTu3xKinbDRNhXebatvHNlxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=THwI4NvAQ+I0CGZ9JDNBvJRpHm48kXae
	0bZpw9VKLBJXJgWG0wlQHmlO3d5k6tVM7BeLlLM3Hq6RFixwRx/rytnLYtTCfHid
	NqH5zKWqEITRMTKqbchAzl7dSoDRNFglKco3J6wEcNMY6VUAi0N8mvkpA4ZMARS+
	oDwWe8VCZ0A=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9893418F5A;
	Tue, 20 May 2014 14:34:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39AF218F59;
	Tue, 20 May 2014 14:34:19 -0400 (EDT)
In-Reply-To: <1400572171-28372-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 20 May 2014 09:49:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5AD8655E-E04D-11E3-9204-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249722>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Simpler (replace above two lines):
>>
>>     test_set_editor "$(pwd)/abort-editor.sh" &&
>
> Indeed.
>
> And I had debug statements left.
>
> Hopefully, this after-coffee-v2 will be clear enough and correct ;-).

Thanks, will queue on top of Ram's fix.
