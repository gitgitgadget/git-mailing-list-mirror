From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed, 04 May 2016 16:08:16 -0700
Message-ID: <xmqqshxxctgf.fsf@gitster.mtv.corp.google.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 01:08:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5u9-0007Lm-Vq
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbcEDXIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:08:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755059AbcEDXIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:08:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A52019FF1;
	Wed,  4 May 2016 19:08:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lREjsuFGkxJgW8TKSpKeUfJj0vY=; b=lJixwF
	LDQwjJOdKCUX+YYYF/Ot10mexySVHuOweIOIqOgneiGuaCX2oaH/6+VHEhozFOOg
	Gd2I0igd5nNt5QtXsrUo46wJn09qDGjImFOYDw9fV6kULBRqXCqPwTdvpM1gTzk3
	ckckrkZPf0tT8M4n0J+12HXVj3Y/PqgrlKHAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R/PouQbdSy4Qyzb6O6LLiH49sri9BZyE
	RPRPZv5qKCD7kP1GZ7FPTPIl7zsGh0NTt+0GqW/StTbOmQIWvbrNgSkfy3MKz/Af
	Cgr+2PHuqj1DPNKzriAJ5SxIBDFWNGEhKpTs/sGsvjZVXHNPUKsQszf7wmJK0Zqk
	SqSsklw8xOo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 91E5119FF0;
	Wed,  4 May 2016 19:08:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18D8519FEF;
	Wed,  4 May 2016 19:08:18 -0400 (EDT)
In-Reply-To: <1462401603-2067-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 4 May 2016 15:40:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1687E814-124D-11E6-AC27-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293621>

Stefan Beller <sbeller@google.com> writes:

> +When the command is run without pathspec, it errors out,
> +instead of deinit-ing everything, to prevent mistakes. In
> +version 2.8 and before the command gave a suggestion to use
> +'.' to unregister all submodules when it was invoked without
> +any argument, but this suggestion did not work and gave a
> +wrong message if you followed it in pathological cases and is
> +no longer recommended.

Thanks for noticing and fixing my typo ;-)

I read everything again and it all looks good.

Thanks.
