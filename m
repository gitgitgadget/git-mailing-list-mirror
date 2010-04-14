From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] diff: add --word-diff option that generalizes
 --color-words
Date: Wed, 14 Apr 2010 14:23:07 -0700
Message-ID: <7vpr21ohj8.fsf@alter.siamese.dyndns.org>
References: <cover.1271260308.git.trast@student.ethz.ch>
 <9a2b460ea5db47154623386638e883f749c4ee35.1271260308.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:23:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2A3a-0001ec-Ke
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab0DNVX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:23:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914Ab0DNVXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:23:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87359AAEF0;
	Wed, 14 Apr 2010 17:23:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=poM0FKl8gWLu0nm20nyaKNIXVb8=; b=qBIoXi
	fUDv2v3vXOgrb5PQULIpvrfnSroKPVPfzb5//zpSKJxGz73sljbXksZJr0N7xEpN
	FhiKKFLyGGc9hjrbJcf251N6OjCUFP49XklbuHBLRISA6iBivyUK9VpRBoswzTpX
	ED0nBpWAScfo2SrvzzV2+Zu6zcFJK5oSeyh/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bR/jKMO/D5Rb6j18YBTvuD/SsUeySXvl
	X6AbpgaSI69VXjXh6GPjEXQvUYbzYDSYI/hD1nX1mbvPiFAbXYRtf3TdBax2gYct
	I8+h00QoJPNV9FEbrthSdn0YsWn0UBtzYua+N7Ayn128swFirg+FNVtigAkSD4mI
	H2ubj3js/TI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C4A2AAEE1;
	Wed, 14 Apr 2010 17:23:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB38CAAEC4; Wed, 14 Apr
 2010 17:23:08 -0400 (EDT)
In-Reply-To: <9a2b460ea5db47154623386638e883f749c4ee35.1271260308.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed\, 14 Apr 2010 17\:59\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F104597C-480B-11DF-9D14-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144918>

Looks good; I'll queue this one and hopefully Paul can give feedback to
the gitk patches.

Thanks.
