From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] blame: add --abbrev command line option
Date: Tue, 05 Apr 2011 20:18:18 -0700
Message-ID: <7vy63ojced.fsf@alter.siamese.dyndns.org>
References: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 05:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7JGZ-0002xz-Iy
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 05:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab1DFDSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 23:18:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab1DFDSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 23:18:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9435252A6;
	Tue,  5 Apr 2011 23:20:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+K+/tNWUz/qa/5WEcLwfnSIiRbM=; b=iGuznD
	yrrJZot6HP20NLaHYp8VAd42uS/OvJyHBvplLQYjnbHx4mb3b3zNELIEULMl/ajK
	xCZGzM/MaQujIFD8e1hx2BqJtG7nE8eI+FQPoEz8Ni42qBd127uEEhD1mo3VbdP4
	scVzZAbZS0HGr5RCkCkN7FH8hRpgQEchWdMLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4AKq3PULedzmGUBlBdUXg+eC1ESJSxE
	MdSCvV8TkpDugfZFnPStGgCL0u9uRgj/q6u0s8sMgif3lvJssKCwlfZ4z24L5U1Q
	NqxZcxbAylbNXV2hYXB9fcOVrhQJ5AWBGtjSx1hR4DKYVnhUIMbNV/JgMMS3jz58
	xNNachuGdIY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FDB752A5;
	Tue,  5 Apr 2011 23:20:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D65652A4; Tue,  5 Apr 2011
 23:20:14 -0400 (EDT)
In-Reply-To: <1302056452-5387-1-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Wed, 6 Apr 2011 11:20:50 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBA09DA8-5FFC-11E0-A429-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170951>

Thanks.

As the meaning of the option changes between 1/3 and 2/3, let's squash
these three patches into a single commit.  Here is what I've tentatively
queued.

commit 84393bfd731c435120dc1dda63432a70124821cb
Author: Namhyung Kim <namhyung@gmail.com>
Date:   Wed Apr 6 11:20:50 2011 +0900

    blame: add --abbrev command line option and make it honor core.abbrev
    
    If user sets config.abbrev option, use it as if --abbrev was given.  This
    is the default value and user can override different abbrev length by
    specifying the --abbrev=N command line option.
    
    Signed-off-by: Namhyung Kim <namhyung@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
