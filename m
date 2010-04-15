From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 12:15:04 -0700
Message-ID: <7v633sjznr.fsf@alter.siamese.dyndns.org>
References: <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com> <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
 <20100408115706.GE2077@arachsys.com>
 <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
 <20100409054536.GB2151@arachsys.com> <20100413090604.GB770@arachsys.com>
 <20100413090713.GC770@arachsys.com> <7vsk6zt93s.fsf@alter.siamese.dyndns.org>
 <m3d3y0gath.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:15:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2UX5-0007YF-L7
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0DOTPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:15:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab0DOTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:15:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43E04AB58B;
	Thu, 15 Apr 2010 15:15:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XAA/SCT7NtBwHR4FU6+Z6FxMeqY=; b=kUfY0T
	Ox9mEgtoUKxcqn41M66vXWSVBjfO2wX51A5lhcCABfMstAEDpBYjShfeJzXtjEhi
	J7cO1edgPPYba5/6/AY3MeTP5fFfjlQ5bf4UB8s0YeftuEmjafQZuJFliD1ROrSy
	20X4wvEeQMCOTho2QWXH5gdHO2qKp+2+Ourn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Af14Pe1AiJ1dp+1BkcG9IIM/JGTA/7vi
	Z0Is/dThPBw+9xMSdvxH/UBzi/zYUgHYEFzmmePtJylH2JfHlm5mXDaE8nPIi0c+
	XwW8jMesD2V0yo1JlhOC3o4O49XeplU3g6PMu7WeijkTOZ4ItxXPsSTFlP2s1KZ6
	CdtzBIDPOgE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00500AB589;
	Thu, 15 Apr 2010 15:15:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 310BEAB588; Thu, 15 Apr
 2010 15:15:06 -0400 (EDT)
In-Reply-To: <m3d3y0gath.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 15 Apr 2010 05\:27\:49 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3635076E-48C3-11DF-8F43-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145012>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> Ok.  Somebody else may want to add an autoconf support on top of this, but
>> this is good as-is, I think.
>
> Something like that?

Looks good.
