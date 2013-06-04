From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Mon, 03 Jun 2013 23:01:58 -0700
Message-ID: <7v4nde9zxl.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-7-git-send-email-artagnon@gmail.com>
	<7vehcjgkuq.fsf@alter.siamese.dyndns.org>
	<CALkWK0nMWPvVBXEyM5TwCC+0LGvLGbUVXPBhewY8X4==nHELSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 08:02:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjkJr-0007Iq-EU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 08:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331Ab3FDGCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 02:02:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab3FDGCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 02:02:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D401FED2;
	Tue,  4 Jun 2013 06:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LFb/tB8y1EvZ0BIS42O5FbJmqno=; b=pEmZcy
	T0X1C2elm2iJiHt0yyTbWL6CHYhjUel8Vu+ys6h/CXy7OqOH3TSxnSy5Rd6RK149
	IAf7Awaw+F55e48/UJGyJEXOgQU1xNuytuTZBWKxjmGROymEjp07AQX1YoTXGY5g
	/cL4mDTveLORzekBcUD/U26ckdqouUqkPvrX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JjRQphRaIeXYp8pnsfPfEfo+/shRl1EK
	+iLMzpaLB+HZkwabOK5dQ0kmrsQ3b6EvECewwgI485mALkafZ+gmBSPei7W26Ewg
	tGaVntXcQQlbvs4GZurTDWMv/WilN5oTTOcd/0Ptyt3t96sRAGl2qlwIFbuNw0Ry
	ySZnzyp2EPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D021FED1;
	Tue,  4 Jun 2013 06:02:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1AAD1FECE;
	Tue,  4 Jun 2013 06:01:59 +0000 (UTC)
In-Reply-To: <CALkWK0nMWPvVBXEyM5TwCC+0LGvLGbUVXPBhewY8X4==nHELSQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 4 Jun 2013 09:19:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 452D0B54-CCDC-11E2-8D8C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226317>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I think this is the same as 5/6 and better explained in a single
>> patch, as the rationale is the same: these commands can all take the
>> usual revs and then paths, so using misnamed complete_FILE helper is
>> wrong.
>>
>> Mind if I squashed them together?
>
> I'm okay with what you've queued in pu (sans some points raised by
> SZEDER; looking into that), but you can squash them together if you
> like.

In any case, I think it is sensible not to remove the _file
helper. We may want to fix it not to expand revname and do only the
pathname, but that is a separate issue from using _revlist_file for
the commands you updated completion for in these two patches.
