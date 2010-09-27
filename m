From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improvements to `git checkout -h`
Date: Mon, 27 Sep 2010 10:54:12 -0700
Message-ID: <7vy6anysvv.fsf@alter.siamese.dyndns.org>
References: <AANLkTinBoofjS=+ropQnHARn+qtzJWh2Nx6n87cud5Di@mail.gmail.com>
 <1285345319-6109-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Daniel Knittl-Frank <knittl89+git@googlemail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 27 19:54:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0HuF-0005Fw-VD
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 19:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900Ab0I0RyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 13:54:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759191Ab0I0RyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 13:54:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F7AD94BF;
	Mon, 27 Sep 2010 13:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AKqv5pdIw2gjMtm11RAsr5z359s=; b=ZE3UbB
	EQYs95HEeAPz55lxUEof6gShoBcxppBSeRTpQMds98BgKhEj4swPwgU/9aHZo2Fv
	SVWe/JYCbavAovtiiYct0BauEf4J3/gLidxu/o7/zmvyHINA0J7Np9JXUTRgu3CZ
	72vD7cQmtVLKXZRbH24M3zfMOuAYhaWlR5OOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDYTZHKueoby86TnWdTVl55UJsd8neaS
	Mhs4HNgMZtb94kxDMwrjJEKXowfhVOnDQyjUcjbCLAD/oqna07gBcalaar9/oQPq
	psBpyr6hiZQAvIrBNvnhn+sPvrOYhqUWY8CaUJlxgchNQEI+Z4tlGpElDcX0wimU
	CYcr7nAGWsw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 007C2D94BB;
	Mon, 27 Sep 2010 13:54:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DC85D94BA; Mon, 27 Sep
 2010 13:54:14 -0400 (EDT)
In-Reply-To: <1285345319-6109-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 24 Sep 2010 18\:21\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 405A6D82-CA60-11DF-8C6A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157360>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
>
> be a little more verbose about what each option does
>
> Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> ---
> Daniel seems to have difficulty to send the patch through gmail, here
> it is again, taken from repo.or.cz.
>
> That seems OK for inclusion to me.

Thanks.
