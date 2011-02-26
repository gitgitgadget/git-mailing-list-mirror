From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Sat, 26 Feb 2011 12:11:44 -0800
Message-ID: <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 21:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtQUj-0008HE-6w
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 21:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab1BZULz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 15:11:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab1BZULy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 15:11:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E5D934D8;
	Sat, 26 Feb 2011 15:13:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DR4mUpyo2e89
	UqwcDagaFfb2BzI=; b=qIrx4Hu0DRGHS+7AzYEL54DpT+IUZqAbSo/BJ5ORQFJn
	phXGHPgKaaFFZBmsb6Tuxpe2gFnD2a8Wji44qtiFmS0Z70FhXA2R482l65OnSGvl
	KsvhmtHY09tCNGUlLx1idTDW4iJHVX1DJ8GbrVK4xCTOzJSruoRnWJDEzryA4rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U35p7Q
	tOkfEt+tHC9T+aUz7wRZu0TjgiN0Jcxfk6X4YdGUNnUEfFseikRMQ5Iuh8zt+yhr
	MU4H+gap3Ayk561d9J8aKTj+KNIcLF91thbalw920i9Uvu/x06y4OfJlWkjEGopo
	UaE2A0dVS82cXaT5tScc4LQ6DpCziISZ3RhAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7998434D6;
	Sat, 26 Feb 2011 15:13:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2D0834D5; Sat, 26 Feb 2011
 15:13:02 -0500 (EST)
In-Reply-To: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 ("Mart =?utf-8?Q?S=C3=B5mermaa=22's?= message of "Sat\, 26 Feb 2011
 15\:16\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D21D07D8-41E4-11E0-96EB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167992>

Mart S=C3=B5mermaa <mrts.pydev@gmail.com> writes:

> Paging through deletes adds a cognitive burden when reviewing code.

Wasn't the ability to say '/^diff --git ' in your pager invented for
exactly for that?
