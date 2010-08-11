From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] tests: use skip_all=* to skip tests
Date: Wed, 11 Aug 2010 11:32:30 -0700
Message-ID: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG6w-0002K0-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab0HKScm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 14:32:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0HKScl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 14:32:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB45CC401;
	Wed, 11 Aug 2010 14:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FOt/iCmS+njmBxUP3eAPIvgLvH8=; b=cRwqiCcXgPeoRjFSGeoOEZZ
	cuCKZt+8TTEryRR8bWVgdY1vp7JRfhhmHlzvV2Oy90umEMCfLSUSir8ZPUELtrr0
	SbqaA4MX28Fn0Zc7i0TgFVd8YeJOSaHoRs/S4zr4sKcjLSV499bOzh2WWUwXnRqi
	oxKVDRHKlu2bntMWXYwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yLwQVDN2qw2mOVKE3UdvK5CiJsRDQsesN6QywfHZaN+1N8vrQ
	KXys95BZEHMOykxpJaWYoQIrP5QgY1Bb0Ym4Ob7eMMIz4+JwgLkh+5kZm+HpMnDI
	16/5fFSg8x3R/C96qm0x+97Ud+CZs3Wpu0JEunaXb1tDaBAou2gUtXDFeM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDBB0CC3FC;
	Wed, 11 Aug 2010 14:32:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFD01CC3F9; Wed, 11 Aug
 2010 14:32:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF6A66C6-A576-11DF-ABA5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153277>

Except for a few which I'll comment separately all of these looked
reasonable (I didn't look at 7/7 very carefully, though).

Thanks.
