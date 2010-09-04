From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] instaweb: ignore GITWEB_CONFIG_SYSTEM
Date: Fri, 03 Sep 2010 18:36:10 -0700
Message-ID: <7vsk1qxpbp.fsf@alter.siamese.dyndns.org>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino> <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino> <20100902235429.GB6466@burratino>
 <7vfwxqzqoq.fsf@alter.siamese.dyndns.org> <20100903235820.GC4471@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 03:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrhgT-0005EY-4S
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 03:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab0IDBg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 21:36:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab0IDBg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 21:36:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B37FD3F97;
	Fri,  3 Sep 2010 21:36:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uAJrIn4UKOR+
	GCvOQfySi3+yxsk=; b=yI9NUt7NjIpyB5hrBe1RWkjwb6AUuBYIq4mijQIckbAP
	7LE1zHCie3b3YGVGMxpcps9O/E03rHdaoBnVM1vKwboTOmtS/uU/HaiSroutM+rO
	c5oz/MkOdbqafH7d3cWLIalTMD0vp9qaSdqTRbqHteGcJ2jepYgkLhel1IgCiy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JDUtTt
	eL1MfgEiAnK2cfVnlVzvoLl5tKCB82u0vsf9TisdIw2B6obAWhuGNVnl+BnJ+RNR
	Y+gxXGTq7fJ8IrKEghuf9LfMX0aq+ZNs3hdC0vyrluFaebWSTiS1FM7Mi8IW16wj
	a5j6AZLB85jxjcSHn+m5IuhzNzi7N8TxL3nS4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35565D3F89;
	Fri,  3 Sep 2010 21:36:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18539D3F87; Fri,  3 Sep
 2010 21:36:11 -0400 (EDT)
In-Reply-To: <20100903235820.GC4471@burratino> (Jonathan Nieder's message of
 "Fri\, 3 Sep 2010 18\:58\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0F5A824-B7C4-11DF-B090-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155296>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> The configuration in /etc/gitweb.conf might specify any old
>>> layout; in particular, it is likely not to be identical to that
>>> which git instaweb sets up.  Noticed by Uwe Kleine-K=C3=B6nig.
>> ...
> Ah, I missed your point here.  By "any old layout", I meant "an
> arbitrary layout"[1].  Sorry for the lack of clarity.

Ah, you mean "instaweb wants to use a specific layout but whatever is
specified in /etc/gitweb.conf will interfere with it"?
