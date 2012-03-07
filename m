From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Wed, 07 Mar 2012 14:24:23 -0800
Message-ID: <7vvcmgkq20.fsf@alter.siamese.dyndns.org>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org>
 <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
 <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PHb-00081P-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab2CGWY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 17:24:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016Ab2CGWY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 17:24:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 246757615;
	Wed,  7 Mar 2012 17:24:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cvw09/qmbVCpK8ZA5ZrKONGX7u0=; b=P569gl
	Pn+7m3CQ31QcIFNxcO6EdocVYNHlpMVvFBe/uDQbW5ahenqmcfaJgxb6NtXyTjQ5
	Xp75DvODA6LDZU76U01NnoUdE/8qdnForLUadRWP3ZsmQy031rfeiyb8gps0ZmM7
	tHwZsDr3lQJbHQdoeenk4nsXvF/vtbp5Ujeh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCA0g90hDIX1mUrTlCW/hsfK8lpzjltw
	m5swAkCXt6MI8PWCjueEsHSh8ywTlufcNqbNo1AYmStMfTOth8yOaokN9Q7XBDDP
	XlXE1fVnqDcH3d+OQhR4t5MMVuCBrquOZQF53aKb/svRHqfxNhbic9UaPs1uezFH
	IIfjPiqRcMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C2B57614;
	Wed,  7 Mar 2012 17:24:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A75ED7613; Wed,  7 Mar 2012
 17:24:24 -0500 (EST)
In-Reply-To: <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com> (Phil
 Hord's message of "Wed, 7 Mar 2012 17:10:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B69B500-68A4-11E1-97E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192496>

Phil Hord <phil.hord@gmail.com> writes:

> On Tue, Mar 6, 2012 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>        'remaining'::
>>
>>        Print paths with conflicts that are not resolved.
>>
>> Should be sufficient, I think.
>
> ....  'mergetool' uses this command to
> avoid asking the user to resolve files which git rerere already
> resolved for her.

Ok, so "Print paths with conflicts that are not resolved." indeed is
sufficient.
