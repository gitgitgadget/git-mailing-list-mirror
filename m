From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 001/142] check-builtins.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 13:38:24 -0700
Message-ID: <xmqqa9ceko8v.fsf@gitster.dls.corp.google.com>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
	<1395768283-31135-2-git-send-email-gitter.spiros@gmail.com>
	<xmqqtxamkq4b.fsf@gitster.dls.corp.google.com>
	<xmqqeh1qkobn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 21:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSY7E-00019V-TR
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 21:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbaCYUi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 16:38:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbaCYUi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 16:38:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C17877D84;
	Tue, 25 Mar 2014 16:38:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QCupQY7QFGACutPf1fLnu1ONzQk=; b=CNMNtN
	kVHQ/mhS1KMRrs7JqqpeRlUYWehHwIKbvgwyxRrZBuSXl+P2Yljf+a9dR/6aoqmA
	TyuwWR0ZxKecHAvcQvz++1Jfq8zqvRs0pNG8o54h603nYQ/lkdGBBCrog8TD3Nq1
	9W2CVitgtN8Eea6s22qfMVF8rNyhnyo+c1BQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FF86MUEHNVIUkHdBVV9GOmAeJzeEyOLQ
	viZq4TsVI7jrYKcgSzb/go7Akc4o8d9NVEFW+CAM3Eu8b0L/M1Y/BHOYIJLEF6Lu
	H8cq7Rhr5ijycaQieSvjf3G9/t3gWZCqzzhaZa1Oy4j3PlTvwdruwi/Pgqqns/zP
	z6tUfNFARNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EBF977D83;
	Tue, 25 Mar 2014 16:38:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7595177D7F;
	Tue, 25 Mar 2014 16:38:26 -0400 (EDT)
In-Reply-To: <xmqqeh1qkobn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Mar 2014 13:36:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A9D8972-B45D-11E3-9968-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245151>

Junio C Hamano <gitster@pobox.com> writes:

> I've reworded the above like so:
>
>     check-builtins.sh: use the $(...) construct for command substitution
>     
>     The Git CodingGuidelines prefer the $(...) construct for command
>     substitution instead of using the backquotes, or grave accents
>     (`...`).

... but I think the ", or grave accents" should go.
