From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [gmane.comp.version-control.git] [PATCH 0/4] gitk crash fix and locale updates
Date: Fri, 30 Oct 2015 09:03:11 -0700
Message-ID: <xmqqmvv0mji8.fsf@gitster.mtv.corp.google.com>
References: <xmqqziz5dv3f.fsf@gitster.mtv.corp.google.com>
	<20151030101038.GG25993@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Takashi Iwai <tiwai@suse.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@ozlabs.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:03:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsC9C-00025B-4n
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 17:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbbJ3QDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 12:03:17 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751858AbbJ3QDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 12:03:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4AB426918;
	Fri, 30 Oct 2015 12:03:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jnKGAMPvLazPrJaDVM5hQm9g3Xg=; b=Or+rEn
	WHWeNRUpwQaNwGAm7FfQ0YXrk64DgDbn+lmwB0W75yNxkE9Pk3ni2k7a3sCBiHPG
	mQOwux8N5RR8VEModkvvj75yujZCoJZn7PFSlqBYZdb0RveLLj5xtipKaNoLpEOf
	0PXOes/DUWpVlvXxcHUa9O+Gs0oJgiod7Lkkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImvUDWy3PmXQe2b0Eif9RGyo75A3/qzm
	PznPD37OCpvd+EPr9npwuC7NDKk+1s9ZF3Am8wD6kagFHijoWat5BL5TlpqHbQgm
	uFqhlAcdphv5qtSKY0APhIsDVd3GODnd9ZaDxkSdTm+uJJXkU00a6U3OolY4kkzF
	GyVwAFjhdto=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD30726917;
	Fri, 30 Oct 2015 12:03:13 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 620BB26916;
	Fri, 30 Oct 2015 12:03:13 -0400 (EDT)
In-Reply-To: <20151030101038.GG25993@fergus.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri, 30 Oct 2015 21:10:38 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B94BDE82-7F1F-11E5-9DA5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280490>

Paul Mackerras <paulus@ozlabs.org> writes:

> Yes, sorry about that.  I have applied a patch from Beat Bolli fixing
> the basic issue, since his patch was the same as Takashi's first patch
> and was posted earlier.  I have also applied 2-4 of Takashi's series
> plus some other translation updates.  I have pushed all that out to
> git://ozlabs.org/~paulus/gitk.git.
>
> Please pull whenever is convenient for you.

Thanks!
