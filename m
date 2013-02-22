From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-commit: populate the edit buffer with 2 blank
 lines before s-o-b
Date: Fri, 22 Feb 2013 14:38:52 -0800
Message-ID: <7v38woc6tf.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMdok7wRDhgq7i=b3cu3LB+poExvxLBxYkg8L3pN92bEYg@mail.gmail.com>
 <1361570727-20255-1-git-send-email-bcasey@nvidia.com>
 <20130222223513.GA21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>, git@vger.kernel.org,
	pclouds@gmail.com, jrnieder@gmail.com, john@keeping.me.uk,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:39:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91Gx-00010e-TP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab3BVWiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 17:38:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756826Ab3BVWiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:38:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74070A57D;
	Fri, 22 Feb 2013 17:38:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6RRbTpxTrgXI773O3HrQshoqQCs=; b=PUQzWf
	JFUP2mbj0csprUsNCInbFXyGL/gOgU+UAAB9FjM0ZUJoslcgRR+DSmMKjzE5I1iZ
	TuGZfpswu32C4SGW0VjqnAySSzC+s0CKdJijY5Lsplvu2S4qrlbHv8zDzdL3eKkR
	ADBaCm9PcXETk1RJ6dCbtnHH0Vxnh3pWSF/8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glZGtPOMHuLvsIPJmniZ7hXAI56uoaJ4
	Ma2BXuxFUer0hVF6hI6BpzvmnnIOadYHNVjAeiLeg2VR0Z6vNDmLR+4WUkXolbER
	6uK20xBHj4WIJSK0anOiYn2sf3IXLPMMq1e/ASMYKp1FP2jA72imWpMZd5nY1YHu
	qjoonmgk/R4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65642A579;
	Fri, 22 Feb 2013 17:38:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBEE2A577; Fri, 22 Feb 2013
 17:38:53 -0500 (EST)
In-Reply-To: <20130222223513.GA21579@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Feb 2013 17:35:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2E92002-7D40-11E2-9602-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216872>

Jeff King <peff@peff.net> writes:

> FWIW, as a casual reader of this series, I find this to be way easier
> to follow than the previous round.

It is assuring to know that I am not the only one getting slow with
age ;-)

Thanks.
