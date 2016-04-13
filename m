From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Tue, 12 Apr 2016 18:04:04 -0700
Message-ID: <xmqqh9f6mi9n.fsf@gitster.mtv.corp.google.com>
References: <1460506710-23994-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:04:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9E9-00057n-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbcDMBEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:04:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123AbcDMBEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:04:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98E3F55E71;
	Tue, 12 Apr 2016 21:04:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DQcznAwDrhqbKU+YuJuhsklaEDo=; b=uo33Ib
	mz48TxUiT8lWG9lSkA4K8eolFO3vvR76cXqjuDn5N8O3LxuGxQe6NZH8Xxxu/9OC
	RyFbUTsEyhexY5NYvnRkyup2+KN8csO3gb6LDFeWiSJEVqAdQbYwyF8gVClqjUEf
	rpI6izuPZ5QdCZJ9o46SY0fDbQX5TSZVTFZvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h8JhRFkHFbOgkUsMWGX9elMvZAV8toYZ
	3QCUq2qvJExwFJieHWyTuSXw7CaYdhMJCW7dJoB/v16ahSwDakATl8TxPuFeBLYo
	hSVZqsuUN73n/b/ompr4P9G0AqoAuKlUmcL2F+MZ7a4KeKsxTqOczhFRWt4m0nZT
	VyMLrA5J17s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9039455E70;
	Tue, 12 Apr 2016 21:04:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A9A755E6D;
	Tue, 12 Apr 2016 21:04:06 -0400 (EDT)
In-Reply-To: <1460506710-23994-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 12 Apr 2016 17:18:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9EC69AB8-0113-11E6-A90F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291355>

Stefan Beller <sbeller@google.com> writes:

> This is a resend of origin/sb/submodule-init (and it still applies on 
> top of submodule-parallel-update)

Resend, or update?  There was some overlap with your recent series
that fixes "prefix" thing, IIRC.
