From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t9903: add tests for git-prompt pcmode
Date: Sun, 23 Jun 2013 00:39:01 -0700
Message-ID: <7vobaxgtt6.fsf@alter.siamese.dyndns.org>
References: <cover.1371780085.git.erdavila@gmail.com>
	<3dd104f19a995081d8c8bf89bc9e33052077e052.1371780085.git.erdavila@gmail.com>
	<20130622130604.GK20052@goldbirke>
	<CAOz-D1L3mrqTKwpnRVEEfZayFNX+eKVNC1-Ewy45tmf9MPQhtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: "Eduardo D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqetS-0005Mq-Va
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820Ab3FWHjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:39:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab3FWHjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:39:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCFD32641D;
	Sun, 23 Jun 2013 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/qCHXygu7gDU/ZTH3o4hLskiTjE=; b=L6NOeO
	BMG649En18Cw/+UpmwDP5mfcvG4sSA8UWcO/N7z7CoK5jp/59U6LtcBdMbgvk1nM
	g3mj3BB5ChF1IQcP7afnzjCkiQFlRj7NJpLOdaOo93GLIYmmAxWAiJJr2ey/T4MW
	5QfQ/Zy7UXpgzAEJvtMPt+ZKf4M7md8jK6aiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DEU/Tc812TMptWDEktiUEqP/u1jlvcsa
	IPdM6gW2Ljyc5yQRrmgg3Ew+TbGLvQT5yqdfCHtYft9p9vF6MSpUUa2fII6DpLEY
	YacjTyWljHY9FHJmtd6YgjfBX9L10IxPLeOfwlmCNqq54w+F9TnJOa8oKY2LdVDF
	6vyarMBBGG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE6E82641C;
	Sun, 23 Jun 2013 07:39:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2303426415;
	Sun, 23 Jun 2013 07:39:03 +0000 (UTC)
In-Reply-To: <CAOz-D1L3mrqTKwpnRVEEfZayFNX+eKVNC1-Ewy45tmf9MPQhtQ@mail.gmail.com>
	(Eduardo D'Avila's message of "Sat, 22 Jun 2013 13:32:38 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9F016BC-DBD7-11E2-B808-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228724>

"Eduardo D'Avila" <erdavila@gmail.com> writes:

> However, I agree that they became redundant.
>
> Would it make sense to include a patch that only removes the zsh
> tests, after the refactorization?

I think that would be a sensible thing to do.

In any case, Szeder seems to be giving a good guidance on patches in
the completion area (not just this series), and completion is not
something I am deeply interested in, so I'll watch from the sidelines
and wait until you two to figure out the best solution ;-)

Thanks for working on this topic.
