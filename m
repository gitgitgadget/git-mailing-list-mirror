From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/6] setup: Add 'abspath_part_inside_repo' function
Date: Tue, 04 Feb 2014 11:18:29 -0800
Message-ID: <xmqqr47i8z5m.fsf@gitster.dls.corp.google.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
	<1391523920-26946-6-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 20:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAlW1-0000nl-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 20:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbaBDTSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 14:18:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123AbaBDTSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 14:18:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 649776742F;
	Tue,  4 Feb 2014 14:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z+ftx0ZcbbwFYFpLs3qSovGGDqU=; b=K1IGdt
	benuShqum/Aei2caq24SEh1avHjcBNOg8LQXU9rEhaKhN7lxosGDN6EZgfaCDfAJ
	If9lvYtzuZQdNYlxoafjiqlMapM8dfqBtAYfft/xOC1FyhJ3a/L0M17hUPT5pDao
	Q2vquj14VUP2lGx3GjWNwa95pgQPSuJD1SNLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKQCcAEuCTmEBDCHFqLNmjshsot3mFI2
	RdW9NOPgPXnHCCtzljrhTRvLbZKKs++PJ6hae7TGoixEW+AmvBieWdQ0neEDBduB
	PTIVhb5lJc15O378d5qx0zVYE04OVZN+iFLxf8e95ovJaAZ0l1SXf0lY18sErCzI
	x1eMDGWkSM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DD1B6742D;
	Tue,  4 Feb 2014 14:18:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74F926742B;
	Tue,  4 Feb 2014 14:18:31 -0500 (EST)
In-Reply-To: <1391523920-26946-6-git-send-email-martinerikwerner@gmail.com>
	(Martin Erik Werner's message of "Tue, 4 Feb 2014 15:25:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 225FA4C2-8DD1-11E3-A79F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241541>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> +	const char* work_tree = get_git_work_tree();

Style: asterisk sticks to the variable, not type.

No need to resend---all patches looked reasonable.

Thanks, will queue.
