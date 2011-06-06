From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 06 Jun 2011 06:57:04 -0700
Message-ID: <7voc2b9i6n.fsf@alter.siamese.dyndns.org>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org>
 <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
 <BANLkTimFUkTx_UDWwh_1_7dzJr1onHQW5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Ivankov <divanorama@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:57:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTaJ3-00036L-SS
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 15:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab1FFN5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 09:57:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab1FFN5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 09:57:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B0DF5FA9;
	Mon,  6 Jun 2011 09:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zdSBIlN5GzS0ed1nLIIV03Ls9PE=; b=H4x4wS
	0wEckAyr5K8lb/fDmJWLeMbR7FPDaSd3iTjehBVi9d+zRUQVrzBQ7CJUd8bfepb2
	3o1tKiyvoLgxZwIPZplIYN6fkVbpLcLu+5jaejs0Xq10JOKwTwNkK8prcpLayFkT
	WucHTV138W25JfIlqag9N8iicXH6sdzLNQwpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P2xLz/w9cqSo6jTaZ3OtO/QsCdRn4FOm
	46FysMicTSbYsE9kQZ6KNWCBxeb5QEiNNFgGKXjPNskiJq7oulqsdGL9baISoZT+
	bT60yTgbY/Fm6PiSN6vqApVHpju8wm07u61p5YW1AdsF0d86XFesC2V9VPzWmgNy
	t6B6FvYwKyY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2BB3B5FA1;
	Mon,  6 Jun 2011 09:59:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FDCF5F9A; Mon,  6 Jun 2011
 09:59:17 -0400 (EDT)
In-Reply-To: <BANLkTimFUkTx_UDWwh_1_7dzJr1onHQW5g@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 6 Jun 2011 15:05:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F3D2D54-9045-11E0-B7F6-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175124>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Jun 6, 2011 at 03:00, Junio C Hamano <gitster@pobox.com> wrote:
>> I'll queue it separately as a tentative commit (below) and leave it in
>> 'pu' for now. Please give it a better description so that we can move the
>> fix forward.
>
> Seems like an accurate description to me, what do you feel is missing?

S-o-b to start with.
