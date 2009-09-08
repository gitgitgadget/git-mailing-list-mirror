From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: Use git-add-file for unmerged files, remove
 git-resolve-file
Date: Tue, 08 Sep 2009 13:43:34 -0700
Message-ID: <7vhbvdxj49.fsf@alter.siamese.dyndns.org>
References: <4AA026AC.10907@gmail.com> <873a6x9t0l.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Nordholts <enselic@gmail.com>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7Xd-0007ov-1e
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZIHUnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbZIHUnm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:43:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZIHUnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:43:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF20C2B80B;
	Tue,  8 Sep 2009 16:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=tLIJlfpd9igsR2EbYh0466tCXpI=; b=UsvH6DtV+eCixnECOVXX9zu
	iCWk4IjBypVo1Y5pdQYoyOGzEstkRnYGU11IEIb+3g3dCqiPQ0g8A2rcyMooiLW1
	G54v29RX6hNQ5KEcPDWGFdKW+hfp5RjuwlpKG48ReWSSDHOeX7Q5/8faIekV/DH/
	yusTHnW9iKfmPzSXg/Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=V2l3jPdzbtU6zcK3H6A0vL1pPCeJjFMgYU8sjkM8EXYQPaWYa
	1COLkYFpDBV6VmQD8y4h9AtvjKgKrM+t7CeVWxY5RDUJI1aFrMSwsK5fQgagUs0q
	5H9rZv2LULEumLEl/Dqjh7oPNr+33Ep9KbocO3quGn5vZJFzqGpnXGjrlI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 873022B80A;
	Tue,  8 Sep 2009 16:43:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBA492B806; Tue,  8 Sep
 2009 16:43:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B14F282-9CB8-11DE-B14A-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128033>

Alexandre Julliard <julliard@winehq.org> writes:

> Martin Nordholts <enselic@gmail.com> writes:
>
>> Use `git-add-file' to mark unmerged files as resolved in the
>> *git-status* buffer to be consistent with git's CLI instructions. Also
>> remove `git-resolve-file' to make it clear that that "R" is a now a
>> free keybinding.
>>
>> Signed-off-by: Martin Nordholts <martinn@src.gnome.org>
>
> Looks good, thanks.
>
> Acked-by: Alexandre Julliard <julliard@winehq.org>

Thanks, both.
