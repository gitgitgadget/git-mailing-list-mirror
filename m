From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/31] Follow perlcritic's recommandations
Date: Wed, 12 Jun 2013 15:53:59 -0700
Message-ID: <7vobbbym7s.fsf@alter.siamese.dyndns.org>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
	<vpqr4g7owyi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 13 00:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umtvf-0000Wo-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 00:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132Ab3FLWyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 18:54:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756837Ab3FLWyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 18:54:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1E0027087;
	Wed, 12 Jun 2013 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sMa8KxYg51RM9bWqER8JELr7nno=; b=nIkR9D
	tcQVVU0Jxe3vIi5ElMbIDUgd0J9PClblHT2+i54aeSwlSJURY3ZhBflbrC+XGcFS
	M3FyRdDS5k/padfLeCrtNsy+pVqYZWaunPBQLxgl1XNObVAkSVjAnktoH9nM+lHi
	T7+A40oWdNocLp2+RwbnfWpNy+JBQrAIcmVc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JROXs3svrZ2b7HSGEoyUlcOWVms6cvrk
	sCQMzPfLeo1poIruea7xQXZETswNGHxHFRQsWwqnBu9ln9dhVdfWwJurLvcK65QO
	4Pmu7VRe0tpWIOth0I6350iSfPpNaLPjOLHbIMpdKXpFzVKXLeoPWqkicrhqbdTk
	Yeyso7ugi3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D658327086;
	Wed, 12 Jun 2013 22:54:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD03927084;
	Wed, 12 Jun 2013 22:54:00 +0000 (UTC)
In-Reply-To: <vpqr4g7owyi.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	12 Jun 2013 23:12:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8E3A356-D3B2-11E2-A7C5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227689>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Which commit is this based on?
>
> "git am" fails, whether I try from Junio's master, next or pu. My best
> try was from da608b124c76f8f7dba8a9d8f0bc8174b9744176. It seems you're
> based on a local commit which doesn't exist on Junio's end.
>
> Most commit in-flight are in next, so I guess rebasing the series on
> next would make it easier for Junio (we normally send patches against
> master as much as possible, see SubmittingPatches for more details).

This is why a wholesale updates like "use sq instead of dq when we
can", "always return; from a sub", etc. needs inter-developer
coordination.

I agree with you that it would probably be the easiest to build this
on top of the merge bewteen master, bp/mediawiki-credential, and
your mm/mediawiki-https-fail-message topics.

Thanks.
