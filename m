From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Tue, 10 Apr 2012 09:23:59 -0700
Message-ID: <7vbomzqzuc.fsf@alter.siamese.dyndns.org>
References: <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
 <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
 <7vvcmzczku.fsf@alter.siamese.dyndns.org>
 <CAA01Cso0bjN5d40p0jRKdWt_vJ06C+X+Q1PJqtEsAheYfHBiSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeYf-0008Dp-UY
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab2DJRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:08:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758Ab2DJRIa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:08:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7906E701C;
	Tue, 10 Apr 2012 13:08:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=hpNQxYVR2XcYTNOYpMxsrscM7PM=; b=eJ1audRaQzvrbepKOMIP
	uBpYYLQnUjahvWmY/ht3FARtt6r9RUcDAkMRX8DLxYA9AhOvubor5oGvlFC2hNCW
	yB8+VcrY1QyEu3zr48wFOubKALPxzAredDBOmhTkpIS4/v2D4oKGhn+hk7M7UMpR
	Qoaux5Y8KFxDxQqqmYCPBDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dMrNQC6TFfi7V4SbQskcVK77BbUtSQ4o2oBT4N1gGj0f6+
	m3zc1mlPQMWgpvYzJZIr0sjIVG7rsETaRsm4KROUWaPXV2YqXBeZm/iS+bf2v91B
	+qb8dBC30dNshQ+MZg4VzQALiEMGzrlN580GMrwDud8giuPqxuXP+I1ms/pJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FE35701B;
	Tue, 10 Apr 2012 13:08:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E565F7013; Tue, 10 Apr 2012
 13:08:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAF406F4-832F-11E1-9887-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195106>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> could I ask what is the status of this? There were some patches
> posted, but I think nothing final?

I do not think you meant to address your inquiry to me, but I think these
patches tried out some ideas, got issues discovered in them and then got
abandoned before resulting in a working code that is ready for testing.

I wish there were fewer such series, but it happens (see "Stalled" section
in What's cooking).
