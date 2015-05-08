From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 09:19:47 -0700
Message-ID: <xmqqk2wjm47w.fsf@gitster.dls.corp.google.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<vpqfv7ap25j.fsf@anie.imag.fr>
	<xmqqoalxbo0w.fsf@gitster.dls.corp.google.com>
	<vpqbnhw4w3r.fsf@anie.imag.fr>
	<xmqq7fskp6qf.fsf@gitster.dls.corp.google.com>
	<vpqioc38ot3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 08 18:19:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yql0E-0000oF-VL
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 18:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbEHQTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 12:19:51 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753160AbbEHQTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 12:19:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 598914CBA2;
	Fri,  8 May 2015 12:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hSL2moqhLPuNu/DbxWjd4M5KO5E=; b=gJ7b5G
	/tPZDuXh5YnA6vi2R3reJtXz3fha/oLexwVPnc6RFt8F+DHxHeaLEaRNhjGTlHYe
	9Jjc8Rx2VAGufoJ6ZKOBsw8i+MJg3l3U0EqTE2TM4dRr86+gstY0+w4VFYaQzMZK
	RnJdgkteeqy3vFiynRfrwm+GTlQaWuV0zTF/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z0wDZL9blTeTeeXg/GtExJZVxTEHjcZR
	JbROY7Ul4CHRYb8Pz1Cz3bjAxeE3xORFxuo0ED42GG/C51gunGvvzXLCpdrVbXj8
	VAH1LNzZN4LiuUwRNXso33Q06/1dSiggO0XzdjuxQXdHDi384q0dnxtO29VkW/8j
	Ueef29yv6zM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 501C54CBA1;
	Fri,  8 May 2015 12:19:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE9574CB9F;
	Fri,  8 May 2015 12:19:48 -0400 (EDT)
In-Reply-To: <vpqioc38ot3.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	08 May 2015 10:18:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C4ECF42-F59E-11E4-953F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268622>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Yeah, but you are moving the goalpost.
>
> Yes, because Git has more than one user and each user may have different
> ways of thinking. I both find it weird to present "add" without "rm" and
> to expect users to look at the doc for "add" to find "rm".

I would not expect somebody who wants to find 'rm' to look in 'add',
but you were talking about 'I just learnt add.  What is the opposite
of add?' people.  'remove', 'revert', 'reset', 'unadd'...?

Yes, you can try "git help revert", "git help remove", ..., giving
all random words you think of in turn, but that is crazy.  That is
why 'git add' lists related subcommands in SEE ALSO.

I do not mind keeping 'rm' with the description of what it does in
the list if we had enough vertical space.  I think it would hurt to
have it in the list without the description of what it does, though,
because 'rm' is not opposite of 'add'.
