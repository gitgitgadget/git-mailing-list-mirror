From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Another use of "@"?
Date: Thu, 02 May 2013 23:28:54 -0700
Message-ID: <7vr4hozie1.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9US-0003Ve-EU
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762676Ab3ECG27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:28:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762674Ab3ECG25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:28:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5159B15B59;
	Fri,  3 May 2013 06:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=78BA1Ou/xtsvAnZjs8Suy3LtlDw=; b=HWpi2/
	59x9l9doJTSNMJjB2TNIcenolo5BBOseofnxV4kQWqF+Fr0glOykaPyAe5OlwDEj
	bY87ESkeDMBzPonl8HCIzNTBLq5+Cl5oLdXlDDjJFqr1zT19HW3xCVlosSSJkluo
	kdbICcro1DT/QRhKg2a4TMDXgarA+PPi0xV4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrr/Y2TlGNd51BH9z4P2NPyzTweupSko
	7ypR0wWLkUyO4eq+XVJttakRzRqIgb/H1icInn9SRkcKb8rwcYURkf7RvS9BRgMz
	Z17sBRsI748UkC3dJ3oUO0krs2mtpd/Z6SHv6fujZLRdBkmqjZqabnnJ3yCzErsB
	knx9gEISVsc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 487E315B58;
	Fri,  3 May 2013 06:28:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BACA015B57;
	Fri,  3 May 2013 06:28:55 +0000 (UTC)
In-Reply-To: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 3 May 2013 12:51:18 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB08A2CE-B3BA-11E2-A351-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223284>

Duy Nguyen <pclouds@gmail.com> writes:

> My setup is a bit peculiar where I do git development on three
> different machines. Say I updated branch long-branch-name on machine
> A. Then I continue my work on machine B. I would want to hard reset
> that long-branch-name on machine B before resuming my work. What I
> usually do is
>
> git co long-branch-name
> git diff A/long-branch-name
> git reset --hard A/long-branch-name

Perhaps

    git checkout long-bra<TAB>
    git diff A/!$
    git reset --hard !$

In any case, not a Git question, I would have to say.
