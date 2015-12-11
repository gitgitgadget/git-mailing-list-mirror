From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Fri, 11 Dec 2015 14:49:42 -0800
Message-ID: <xmqq1taseh2x.fsf@gitster.mtv.corp.google.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 23:50:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7WVj-0000rg-I8
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 23:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbLKWtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 17:49:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626AbbLKWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 17:49:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D881D326FF;
	Fri, 11 Dec 2015 17:49:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oJZRm8rv60z1Vi/yMTHwty9HqLA=; b=YM++ea
	SOTRJfIUULphRPF8cF7DRp7bbJSTYIEZ5wsbRcR0sTfKKMWIstL61SppfTsV7HMm
	wa86XWGRP/HF6po1USpE8bM4EKwANWCR6ZFKKZT/viY9AN/HDEwAuD1A+Y/GEFKU
	flYDtQylgQ0zrsDMrFIfYRLZLa3+nWLs00pKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VG9IVZPWIgZwbdZgYzT6hfatLlk/5UYz
	Jpwu+91f2ysDMYcSQyHXGW/s4VimGVL1eKghG2WoASF4HG1iW8fp/z6ZuIRMPlUP
	hOX7tRn/MtmRLI5+cI0VJwzYpNNjQBYjMlccvXqilFHrl9WAgGIzUvPslPNEvXfz
	poHJEkMZn8s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF29C326FE;
	Fri, 11 Dec 2015 17:49:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C26B326FD;
	Fri, 11 Dec 2015 17:49:47 -0500 (EST)
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 12 Nov 2015 01:14:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A8CD088-A059-11E5-AC13-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282282>

Karthik Nayak <karthik.188@gmail.com> writes:

> Karthik Nayak (10):
>   ref-filter: introduce a parsing function for each atom in valid_atom
>   ref-filter: introduce struct used_atom
>   ref-fitler: bump match_atom() name to the top
>   ref-filter: skip deref specifier in match_atom_name()
>   ref-filter: introduce color_atom_parser()
>   strbuf: introduce strbuf_split_str_without_term()
>   ref-filter: introduce align_atom_parser()
>   ref-filter: introduce remote_ref_atom_parser()
>   ref-filter: introduce contents_atom_parser()
>   ref-filter: introduce objectname_atom_parser()

It seems that this series had seen quite a good inputs, mostly from
Eric.  I finished reading it over and I didn't find anything more to
add.  The patches are mostly good and would be ready once these
points raised during the review are addressed, I think

Thanks.
