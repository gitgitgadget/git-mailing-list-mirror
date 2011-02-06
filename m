From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Sun, 06 Feb 2011 12:45:48 -0800
Message-ID: <7vipwwx56r.fsf@alter.siamese.dyndns.org>
References: <4D4C5EBC.2090100@web.de> <201102042326.08607.j6t@kdbg.org>
 <4D4D33E7.4000303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:46:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBUi-0004wO-IV
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab1BFUp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:45:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab1BFUp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:45:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F4973402;
	Sun,  6 Feb 2011 15:46:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i7qoVvN93+ScX1FJdomnn6SiFSI=; b=Ts/+Wd
	zje3sbXOHbbugtQSE8nRV+syXYB59Tgbcs/HwU4egNgsmXynPxsQX9sEaiKe4z3d
	JqwHGnxs8iwjt/ypDXbNU+m2/4KUNiy7bi7umCqchIdOENPqjM42rk3eneN4EO/3
	0e3KMQfECx+VofibcubJfeDt01oMJEAFOOB1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZzvJy39BJ0dV0khJmMewaGCCn041Se/5
	aFhlqrXpNFJ4DqwUIlvMDBfJkUKqdgDMcRLVzuMABRbNDqfR3lhAHmm1W1wFhlJz
	atG9phkbFqyD9ury4fLlR276W6Z4DRohjMgppieS9/RezOyIIjwE74Q2+tnR0IEG
	T0qwci+gMrk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CA7033FD;
	Sun,  6 Feb 2011 15:46:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4DB2133F6; Sun,  6 Feb 2011
 15:46:48 -0500 (EST)
In-Reply-To: <4D4D33E7.4000303@web.de> (Jens Lehmann's message of "Sat\, 05
 Feb 2011 12\:26\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39F242F0-3232-11E0-B6A7-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166201>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Yes, but isn't that exactly what the pull man-page says? Quote:
> "Options meant for git pull itself and the underlying git merge
> must be given before the options meant for git fetch."

Yes, it says that, and I think that was a weasely way to say "the command
line parser in git-pull is broken".  The lines you are removing was from
the patch that fixed that breakage, aren't they?
