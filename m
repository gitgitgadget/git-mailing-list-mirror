From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 15:08:24 -0700
Message-ID: <7vzklpuyp3.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:08:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV9sm-0004FN-Ix
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 00:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084Ab1FJWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 18:08:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab1FJWIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 18:08:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69C10511D;
	Fri, 10 Jun 2011 18:10:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jLDRb5PWqERHxSO1j9aqq9nSivw=; b=GhzGEI
	Ryde/F0Bsod5dK29NHSlY5gTESBdux1ZGwrNtVBD+qjrJex6sQJz0/syv953G9mx
	6buzKZ1fUAYfhwmqlFy1jPHg4LBofjQiyz3LLKEOMDzWW1UCovKB4vI6X6ZJphIu
	9ylMV2lpt4tMxtQc7/jpLf48i52ADzeW7+PFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQHZgTnMutg3Y9DvLfNtYIU8T6oxKNC/
	o9W54pVnOYo7HjDS7Ik55ZTpL2lKn3TFzKJsAxz1YDINNrNL4N9k5MgngEqb88lW
	SJpjjM5OvRYTGewCPDIE+sMmUBO+7Ro+4yaCUnkAXwPdfpwwWkUQ4Y4mZeJuEM0e
	dIIiLUm2hrE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 040B95118;
	Fri, 10 Jun 2011 18:10:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41AA15116; Fri, 10 Jun 2011
 18:10:34 -0400 (EDT)
In-Reply-To: <7v4o3xwe5z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 10 Jun 2011 14:48:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C3E34D8-93AE-11E0-873B-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175630>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks. This is exactly why I love to have people like you on the list,
> who can say what I wanted to say in a matter that is a lot easier to
> understand.

s/matter/manner/; of course.  Sorry for a silly typo and noise.
