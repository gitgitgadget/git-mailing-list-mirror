From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove deprecated OPTION_BOOLEAN
Date: Mon, 29 Jul 2013 10:58:25 -0700
Message-ID: <7vbo5l1c5a.fsf@alter.siamese.dyndns.org>
References: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:58:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3riK-0007yw-IY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab3G2R62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:58:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259Ab3G2R62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:58:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9105348F3;
	Mon, 29 Jul 2013 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ENFjvFL80zaHiEzmkPj961BqfCk=; b=R1o/BK
	MhTPlEkOw/nUS3oryNK8DAm/ATVglt9bEebRNAL/IY8wfn2lppNq0W8ahhj3L7aN
	ozuyjY4UGNdkheUzpXKH5zbayS3+zFqs0dXl6Jp47bfGB0xYN7r5L1as13UTkaJk
	3emBnJBI563R70KjZF22PcwKb0XgK0D7rCxPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qohH+BPpbK4VoIgYRFYXVnV2sDTHGZaF
	I75Dy029wvHsKLyc5W9rn2e1QKDAAg/IxS82zSq3PupVbdSGV6NJ4tFlRDen1InP
	psh8R8FLJBlmPJdCPkYeLOiwQf/3l9kyB53WS9GV3NmYxpTEjX+Aro+Y5HMyG06D
	TuNYrAZrrnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F08F348F2;
	Mon, 29 Jul 2013 17:58:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 018E4348EE;
	Mon, 29 Jul 2013 17:58:26 +0000 (UTC)
In-Reply-To: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Mon, 29 Jul 2013 17:38:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 782766CC-F878-11E2-B62D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231309>

Stefan Beller <stefanbeller@googlemail.com> writes:

> So recently Junio released -rc0. Is that a reason to not
> send out patches, which do not do bugfixes? So the following 
> commit for example doesn't fix a bug nor does it add a feature.
> Is it fine to send out such kind of commits during the -rc
> times or better wait for the next development cycle?

It would be a good idea to show it to others as a preview of what to
come even in a pre-release freeze period, so that people holding
real patches in the affected area can work with you to avoid
conflicts.

But I would not expect them to be applied to the upcoming release,
nor even 'next'---this largely depends on the maintainer workload.

Thanks.
