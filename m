From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/3] git-commit: rename --all to --track
Date: Fri, 25 Feb 2011 11:08:54 -0800
Message-ID: <7vvd089bjt.fsf@alter.siamese.dyndns.org>
References: <cover.1298644872.git.git@drmicha.warpmail.net>
 <3873657a89ba3464b68d7b0388d151ab68e44c27.1298644872.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt32N-0006wg-TH
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674Ab1BYTJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:09:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502Ab1BYTJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:09:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1325848AE;
	Fri, 25 Feb 2011 14:10:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fKbgJfOMn+QPqepw3vf1th9i7pQ=; b=L+le7d
	ZJpWsHY7LTYvCAo/fVX5rzETRlzKp9vqv4tEMAbKwEkWxjXZc5IrIREY/csPYbS4
	YU8vl9kR2aueybYyM45VNMvLv+zjjUy9o3KbOun8G4uQDm6HUaPYuRHcm5W9wmNd
	Np030nYNBSkvhvCiMCx10j7t8ZhX8PyGds3z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8dY2HYg2xxNSlFFLqYUTo7GtfMbrf2Y
	/xqrC70QGgu81EcbcnxJCe0jkJB9jiir5pYWMxqnq9ZeFj3vGn1ZpOFZIQSCCR4Y
	2Nvzvu+WO5BMYWtkQS6SuNgXY/A4kZtD4U6ZyPXS3dIeW9ZgYhK/vi/cPixG1xz3
	bKpsm80DwRA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDCAE48AD;
	Fri, 25 Feb 2011 14:10:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7F59048A9; Fri, 25 Feb 2011
 14:10:11 -0500 (EST)
In-Reply-To: <3873657a89ba3464b68d7b0388d151ab68e44c27.1298644872.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 25 Feb 2011 15\:45\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E167CA7A-4112-11E0-A0B2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167921>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Rename the "commit" long option to "--tracked" which conveys the fact
> that it is about all tracked files only.

Please don't.  The fact that "-a" derived from "all" will never change,
and your patch will only confuse future newbies wondering why "tracked"
abbreviates to "a".

Renaming it to "--all-tracked" might be worth considering, but renaming it
to just "--tracked" is not, IMHO.
