From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 03 May 2016 13:27:07 -0700
Message-ID: <xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:27:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axguZ-0007uI-IM
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbcECU1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 16:27:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756341AbcECU1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 16:27:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F0C118C3A;
	Tue,  3 May 2016 16:27:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qL0pVrkSfBiX+mXuItKtKGt8700=; b=DBhwMj
	+VkvR2KPUDKmzAOe/Kw1XXcfkT6/mZyxLRoaeb1Br2IBmQ/eNAUKBhc5KYjJ5i5y
	hFtXCJgdKpuEFBgVDcKpELnEhWV4Hc2Y867OxSgwcHYEC0h9BHiC5Gfm5eUh5KqM
	XFNKHDf7R6TPPeFZFA1yks8mvNGAbhEhLV0Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VgNpcqm1ELeXGe4K/qVAYsdQhu6jloqS
	swsRXkDr4zMAXfzj9UG6aMXDhWFaYY0f2K94qoSiTrU12SIHDosmPQrjMnQn5xVD
	J7gNU9wgE0qzvRK2u+lTztT9wDqKInNisN/aXPck7wm6ItbaRAGfuBOgnKV0dHMY
	NMSHX8bOGS4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 060F718C39;
	Tue,  3 May 2016 16:27:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77C3B18C38;
	Tue,  3 May 2016 16:27:09 -0400 (EDT)
In-Reply-To: <1462227844-10624-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 2 May 2016 15:24:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 692CDE2A-116D-11E6-8A4C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293451>

Stefan Beller <sbeller@google.com> writes:

> Stefan Beller (3):
>   submodule deinit test: fix broken && chain in subshell
>   submodule deinit: lose requirement for giving '.'
>   submodule init: redirect stdout to stderr

So...

 * I'll take "&&-chain" patch on a separate topic on 84ba959, to be
   later merged to 'master' and probably to 'maint'.

 * I'll queue the "send diag message to stderr" patch on top of
   sb/submodule-init.

 * As to the second one, I prefer to hear opinions from others
   before choosing the possible two approaches.  Perhaps losing the
   "safety" is acceptable.  Otherwise, we could use the one I sent
   but with a "-a and pathspec are incompatible" fix.  That can be
   on its own separate topic.

Thanks.
