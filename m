From: Junio C Hamano <gitster@pobox.com>
Subject: Re: permissions
Date: Tue, 08 Jun 2010 14:05:30 -0700
Message-ID: <7vtypds09x.fsf@alter.siamese.dyndns.org>
References: <4C0A19FE.1020802@wpursell.net> <m27hmdn704.fsf@igel.home>
 <4C0A9615.4090307@wpursell.net>
 <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
 <4C0B6C32.1090700@wpursell.net> <7vvd9wvswy.fsf@alter.siamese.dyndns.org>
 <4C0E1AB1.2030702@wpursell.net>
 <AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: William Pursell <bill.pursell@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:05:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5zZ-00023l-DM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab0FHVFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 17:05:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab0FHVFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 17:05:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5353CBACA6;
	Tue,  8 Jun 2010 17:05:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=6oTiRy+6eedstt8ibXyPxgHDv
	zA=; b=owG7YRNqG+dQSUOrS8OXFgN2NZV72mffeO0qqGBsinZ3dr22X3gA1SeoH
	btzY8S6PXwV5n0Hb6THMSgPHzYaZbEModX4arcTDGKmJbafpUeudXZzrqR3/h+/o
	GYKVRwpF393qgc56lQ3QJGNKRdbrfjwFaxAd3+1zhDMGHQUEKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=L5BpNtpdTYeZxrNUruD
	9aPLJn1seLsaVxsl0fPjeOFIMhtERb35DHwYh5UridVe6ql/usSkHvY9DxoEWBai
	ZYJe6W8pefmiCcEOb0NP5mE7TRZ4tH94cRvnU8Mey9NU29eIXLsgY2iZ5JvbuCxI
	yZlznqa2RHzenga2mNfGG9xE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F318BACA5;
	Tue,  8 Jun 2010 17:05:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94464BACA0; Tue,  8 Jun
 2010 17:05:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95A1B596-7341-11DF-8861-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148719>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Tue, Jun 8, 2010 at 12:25, William Pursell <bill.pursell@gmail.com=
> wrote:
>> Here's a patch. =C2=A0This doesn't address the issue of a damaged
>> repository, but just catches access errors and permissions.
>
> The change looks fishy.
>
> The patch moves the function is_git_directory at the level of user
> interface where it wasn't before: it now complains and die.
> Not all callers of the function call it only to die if it fails.

Thanks for shooting it down before I had to look at it ;-)
