From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove dead link
Date: Fri, 23 Aug 2013 11:01:53 -0700
Message-ID: <xmqq1u5kp9pq.fsf@gitster.dls.corp.google.com>
References: <884d025e9da6f309d33dffdd1ed3731defa514ba.1377267683.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org,
	Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCvgP-0001Qt-JX
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab3HWSB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:01:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923Ab3HWSB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 14:01:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603133B518;
	Fri, 23 Aug 2013 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WHmCVHOB5b+/7G6jss4JK5vGLxw=; b=tXd+2+
	CiZ+0ct5vfGN0HXNhjQYPL1cwNcCrRgXxmBxbpMyDBpa+j8hG/R2OEMjlN6lV0cc
	MOVOlgvoew1qhqUCCF6M1zljF2AChCHU6AGyjPmnW/0lme3s10z3TSGdyyqgdPM7
	u78I7p1esquuYgXNWrhB73ex+2vVb25gNGEGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pY8/PwKTJ5IL1Xt4Og+Clexak8gKhoz4
	4SxxemnqFXtEb1ZtCsTLKvJUU4wU/tde0A8+df5vWH8Lv9yUWmA1j3/SLAcmHOKn
	nmHm4l93qHUycLQZoKaHZuq0FXOlM7CNBP2ctf7YK1welHDqXo4xIoBf78mlLeFL
	8dLZvD/iEIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 568983B517;
	Fri, 23 Aug 2013 18:01:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEF823B515;
	Fri, 23 Aug 2013 18:01:55 +0000 (UTC)
In-Reply-To: <884d025e9da6f309d33dffdd1ed3731defa514ba.1377267683.git.mina86@mina86.com>
	(Michal Nazarewicz's message of "Fri, 23 Aug 2013 16:25:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18E246AA-0C1E-11E3-AD2E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232817>

Michal Nazarewicz <mpn@google.com> writes:

> From: Michal Nazarewicz <mina86@mina86.com>
>
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> ---
>  Documentation/technical/pack-heuristics.txt | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
> index 8b7ae1c..b7bd951 100644
> --- a/Documentation/technical/pack-heuristics.txt
> +++ b/Documentation/technical/pack-heuristics.txt
> @@ -366,12 +366,6 @@ been detailed!
>  
>      <linus> Yes, we always write out most recent first
>  
> -For the other record:
> -
> -    <pasky> njs`: http://pastebin.com/547965
> -
> -The 'net never forgets, so that should be good until the end of time.
> -
>      <njs`> And, yeah, I got the part about deeper-in-history stuff
>          having worse IO characteristics, one sort of doesn't care.

That is unfortunate, especially given the last line that the patch
removes.  Has anybody asked pastebin folks why it is gone and if it
can be resurrected?
