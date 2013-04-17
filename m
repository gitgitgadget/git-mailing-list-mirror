From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Tue, 16 Apr 2013 21:48:15 -0700
Message-ID: <7vtxn5hieo.fsf@alter.siamese.dyndns.org>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
 <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
 <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com>
 <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
 <CAGdFq_gCeE8gRxmRYkGkm+kn6_Vo22_8g7+eLMuj-+pKjJjPcA@mail.gmail.com>
 <20130416084252.GK2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 17 06:48:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USKIB-0002PL-IG
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 06:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab3DQEsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 00:48:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776Ab3DQEsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 00:48:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C61A611745;
	Wed, 17 Apr 2013 04:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kzcWIXripof1/YA4qWobYjnoZ/s=; b=b/EQgp
	6Osa8RpluJEaPvu4vr+zZ9E7wQocwdTNwmHr+sk+KHn7iDmI6pOE25plF02HM95q
	jnkhSwwodIzbWjGYf5tq7LJ+rFrST7T9HIXR7R2P24X8q4HJrLqfg6BZFhht9h/C
	J4KUD1ZnVR+IszXvlQjNDqLr7DXvlaNeeCQTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nQWoV4S460d0LizjMCJjp8liCF975aBc
	8BAhTG9nxwvf3IB8wbnnPnbeBo4mXRpsoOfCHrrP24AJ9cXDTuLEFJN+uCrxRLl6
	kHAtEYOVVyzAiWaLL2a4Rm/Uj7L07DaC+tYzMaqDwmvaS5CdMFGJb77VLIqPz8uO
	jGLLwDW9ei0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD5BD11744;
	Wed, 17 Apr 2013 04:48:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BF1011743; Wed, 17 Apr
 2013 04:48:17 +0000 (UTC)
In-Reply-To: <20130416084252.GK2278@serenity.lan> (John Keeping's message of
 "Tue, 16 Apr 2013 09:42:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0530517E-A71A-11E2-AA43-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221504>

John Keeping <john@keeping.me.uk> writes:

> Printing one message per tag also matches the current behaviour for
> --signed-tags=warn.  I don't want to make the behaviour for "warn" and
> "warn-strip" different,...

That is a valid point. Nobody has complained that the current
warning is too noisy, so perhaps the patch is good as-is?

What do others think?
 
