From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Sun, 31 Mar 2013 18:56:55 -0700
Message-ID: <7vhajrnhco.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
 <7vhajvv51f.fsf@alter.siamese.dyndns.org>
 <CALkWK0=+7ctiiYJSs3SQvV8aywT4tvwGLZ02KLozP8zjU-LQ2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 03:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMU03-0006Jq-BO
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 03:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab3DAB5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 21:57:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41292 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721Ab3DAB46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 21:56:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6F0BE34B;
	Mon,  1 Apr 2013 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vB9mY6yWddP5nrLfzFC56i502+Q=; b=bmtaTc
	EoEon1RdR+ojNelUO+i+uLswhTFx7K3iZUzdkA1R+KlDvaXwsfdeAW/WoD64/Bph
	w05XbskGj903fDTCUcTYyhuCgrLnMaCQx+Znt3stjH6nLWwPojZY9e/vHLP/dX7U
	ArT2llvsqt3ufq/vDcwjD5Qj1zHNT4E4Rj27M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ap+0nsP/OQXaRU5mOJHzpSmE4DL/gVAW
	hpf2hiHg++ANlZwGzPnzaHeuhrjZFnd9x76ycTU6V+lxG4YX9X/IpaAfnnhVd1Xr
	5+FOVc2wVenqns86RjB5y8lvtxQFT2reI9MSWhRx+FswznjO/maCsYAfXer3EarX
	saZU0Ap2usg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F25EE34A;
	Mon,  1 Apr 2013 01:56:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D031E348; Mon,  1 Apr 2013
 01:56:57 +0000 (UTC)
In-Reply-To: <CALkWK0=+7ctiiYJSs3SQvV8aywT4tvwGLZ02KLozP8zjU-LQ2g@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 1 Apr 2013 02:24:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F2EE070-9A6F-11E2-B452-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219656>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>> [...]
>> Thanks.  That is one of the reasons why we do not want to see too
>> many custom test helper functions.
>
> I noticed that you queued my original series without modification in
> rr/triangle.  Should I submit a re-roll with Peff's suggestion
> incorporated?

If you want the topic to make progress, yes.

The only reason a topic is queued in 'pu' is to let me not pay
attention to it, without risking to forget about it completely ;-).

The topics on 'pu' have potential to be a useful change even though
they are far from ready for 'next'.  By queuing on 'pu', rather than
just letting them sit in the mail archive and relying on the author
to send follow-ups, I can send out "what happened to this topic?"
inquiries from time to time, without paying constant attention to
them.
