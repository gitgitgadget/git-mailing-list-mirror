From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Documentation: fix linkgit references
Date: Tue, 03 May 2016 08:41:37 -0700
Message-ID: <xmqqd1p3p2ry.fsf@gitster.mtv.corp.google.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
	<1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
	<1462220405-12408-2-git-send-email-larsxschneider@gmail.com>
	<20160502203445.GA19509@sigill.intra.peff.net>
	<E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 17:41:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcSH-0002u1-2c
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 17:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452AbcECPll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 11:41:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932593AbcECPll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 11:41:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3F8F17300;
	Tue,  3 May 2016 11:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DnftlJ2UR+8nb1OFVrgGmzi0cHE=; b=C+Jo5r
	zcbG+KLpYovFt5+eYHUwCAWVSXJDi8UV4n2AoWyxIZX8LaeJZdVqf/HnWrmmlqDd
	WRt/mPdLkvgYS6k2vNsdCOVFSg2T0Arp289oFmWVIUBrYk7FraJL8iEgEL1mwer+
	DT08qzeS1POnL9Nn8rkkbZliGoMd4zQkU93fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXAAO9YjISxb3Hi3qvyANVVZDKlWOb8k
	+n0F+n+Ajaw8vXoK2y+NrSMG+n9dsF6Tsw8jVs198BaNL9wOHA6ExmI0G+7ZNxKr
	/DxjznvLVAxRGh55KFUIyRFsZA0M6ao8ESzWquzz76Jl0unDGko4uYKymwkaquL+
	6mp47x6l8JM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BED9172FF;
	Tue,  3 May 2016 11:41:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07C9D172FD;
	Tue,  3 May 2016 11:41:39 -0400 (EDT)
In-Reply-To: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com> (Lars
	Schneider's message of "Tue, 3 May 2016 10:30:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86A9DA66-1145-11E6-9467-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293403>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 02 May 2016, at 22:34, Jeff King <peff@peff.net> wrote:
>
>> On Mon, May 02, 2016 at 10:20:04PM +0200, larsxschneider@gmail.com wrote:
>> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>> 
>> Fix how? Your commit message doesn't say why this is a good idea. Since
>> this is v3, I'm guessing that reasoning is on the list, but it needs to
>> be summarized here in the commit message.
> You are right, I should have explained my thinking a bit more detailed. 
> A few of the fixed linkgit references are just typos, e.g.:
>
> -linkgit:gitconfig[5]
> +linkgit:git-config[5]

I didn't run "git blame" yet, so it might be that we used to have it
in section 5, but "git config --help" puts the latter in section 1.

Even though you obviously were fooled by AsciiDoctor regarding
literal double dash {litdd}, other parts of the changes did look
good typofixes.  Thanks for starting this.
