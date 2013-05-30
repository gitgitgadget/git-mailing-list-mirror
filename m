From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Retrieving a file at a before a specified commit
Date: Wed, 29 May 2013 19:27:18 -0700
Message-ID: <7vobbtp5h5.fsf@alter.siamese.dyndns.org>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
	<20130529075811.GA7204@sigill.intra.peff.net>
	<20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
	<20130530105956.dbf5e3363fa0abbc0143d463@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Erik de Castro Lopo <erikd@mega-nerd.com>
X-From: git-owner@vger.kernel.org Thu May 30 04:27:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhsaL-0005Pn-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 04:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967307Ab3E3C1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 22:27:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966805Ab3E3C1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 22:27:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B559E1A2DE;
	Thu, 30 May 2013 02:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8p2rD31CtpGdwqMd48gCreizp0Q=; b=DsUMif
	Dg+J9bf/zDZHKX3xuIkPKTltgGWufiBHcheGuXtmO2xpEdH11hZEjpeTdbfwfuhG
	b+azyMi9vUWe0jpUgWlRQCQqjrl8VmeFfcR4qalK/5WX5AOWnYhrOGEIn0TEZCD/
	mAffKHeRqirDPKWoJDHBBUYz19cUevzlbxqrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lomT8w9Htmp8/RNa1mPhY1osOKuH35yC
	6SmqyoW7nRBEpZwqiJMC1BqfrbyGQU6TS5M99YCLH4H3eifKsEMhzD9tsS86OdeC
	+BqwpRP1W6P+lK0dH8DvDb7HWP1F10mU5tEk1Zkpz5VrV+1L49Pe6doH21NBgyVx
	FWd4sd8Lwa8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6A41A2DD;
	Thu, 30 May 2013 02:27:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 265631A2DB;
	Thu, 30 May 2013 02:27:20 +0000 (UTC)
In-Reply-To: <20130530105956.dbf5e3363fa0abbc0143d463@mega-nerd.com> (Erik de
	Castro Lopo's message of "Thu, 30 May 2013 10:59:56 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7421AF56-C8D0-11E2-89C1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225910>

Erik de Castro Lopo <erikd@mega-nerd.com> writes:

> Erik de Castro Lopo wrote:
>
>> Does this explanation make sense?
>
> Just to answer my own question, Yes it does.
>
> The file was added in commit 53266574 and was actually zero length
> at that time.

While you are at it, you may want to check your LESS environment
variable settings, especially if you find that the command gives you
control without showing anything for a small (not zero length) file.
