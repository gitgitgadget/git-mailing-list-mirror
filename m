From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Wed, 03 Nov 2010 09:17:38 -0700
Message-ID: <7vsjzixty5.fsf@alter.siamese.dyndns.org>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
 <7vsjzj1v49.fsf@alter.siamese.dyndns.org>
 <201011022358.11340.johan@herland.net> <20101103064137.GC7606@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 17:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDg2E-0008JD-BI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab0KCQRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:17:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab0KCQRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:17:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 110FC15CA;
	Wed,  3 Nov 2010 12:17:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qw88QtU/PY6XgeaZxYTm7bWQuGs=; b=WTkciV
	5SZmwdud9gn8RvbtlYxF67C45vWhu0JCh1I7FZiPIlurLhTFob9Aee+P8SKnKl8F
	HuJ8w62OF0TzZ3qdsmJNu/SgiA9BYGn5zuL8yMn+ezHiyllNeUXrdl5/RVsveraL
	hI6+AU27z3PIwiE/qvMxFyDVKVAY93tsKt2SI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Swbn87ebxe989JlXP0coaXCDoQWyePxN
	rVc0qnfdckN8AHogZhl5spp4ZNwsK3J04gX32EfpjlTFqb9ZZdCM10JdqWXJchXc
	ozY0cetGfAP/BvNwd5m3d0xZ7WaZaW294TEkVelGP1Eu781sBW3Hxdk9aZiYDbpo
	FO1rvbcSEcs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F65F15C5;
	Wed,  3 Nov 2010 12:17:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9ADF415BD; Wed,  3 Nov
 2010 12:17:39 -0400 (EDT)
In-Reply-To: <20101103064137.GC7606@burratino> (Jonathan Nieder's message of
 "Wed\, 3 Nov 2010 01\:41\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5212EB0-E765-11DF-9FFA-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160607>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about
>
>     refs/notes/*        refs/notes/$remote/*
>
> ?

I was actually thinking more along the lines of "not keeping track of
remote state at all".  We don't do that for tags either.
