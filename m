From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 05 Jun 2012 09:36:36 -0700
Message-ID: <7vlik1pvfv.fsf@alter.siamese.dyndns.org>
References: <20120605085604.GA27298@sigill.intra.peff.net>
 <CABPQNSbhgan+i_Q142R8VvRdJ5T+GyYHqgEJ6KS-BBJguRu-OQ@mail.gmail.com>
 <20120605160157.GA20582@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwlA-0006c4-Jl
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab2FEQhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:37:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab2FEQhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:37:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1337C9589;
	Tue,  5 Jun 2012 12:37:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=avRidvHh8QbbNMQYInNhE8MI3gs=; b=gAla2g
	ewiB91FJHPtflCyBCi5GjsUgTxwL7RdswnXdn71WI3znQhUF+dZnVOaTUHA3dU/6
	mTCacLaZUeS7Sca6mFZPkTd5Gk+07XCaEmE47qs5eUhADTZRONPo5uSgOmIC5gvE
	FE0kb8Swonu6YylG38B3uXzCRUutqvHN4YzR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYuXu1OuXWmR+x6kO1Sa4WOAeF6weUZa
	zM1h0TP1vQ7Vhcb5YXDCRLDUXnt/jBZBK2sZzqh6jUdfoFehWPbf2Y+10lLru92m
	ptZiUcMUJJvEJ8vtISj/vAnCyiTrgKGuZpzBQU6WM0ZoMZ+yb+jGeOJJ8ZHD+TcF
	t5AZ7ot2fF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2949588;
	Tue,  5 Jun 2012 12:37:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B40F09575; Tue,  5 Jun 2012
 12:36:41 -0400 (EDT)
In-Reply-To: <20120605160157.GA20582@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 12:01:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A14E0236-AF2C-11E1-A03E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199259>

Jeff King <peff@peff.net> writes:

> Given that the buggy less is apparently still in the wild, and that the
> patch is a pure cleanup, I guess we should scrap it for now. <sigh>

Let's keep it on hold for six more months and then re-evaluate the
situation, perhaps?
