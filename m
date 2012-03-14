From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 14 Mar 2012 10:29:05 -0700
Message-ID: <7vpqcfqefy.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <vpqy5r44zg7.fsf@bauges.imag.fr>
 <CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
 <7vbonzssap.fsf@alter.siamese.dyndns.org>
 <CAHkcotgsU6XZCTB+YKKeVMsUC2Yr5pVoc7eJpxdyH-GcxzeTVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:29:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7s0f-00023d-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761260Ab2CNR3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:29:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761236Ab2CNR3I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:29:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B20BA6924;
	Wed, 14 Mar 2012 13:29:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6r/NhHlKn2wd3SDB45dtL16FGMM=; b=EyxCzp
	S2T5z9MC7CvRlE4wuZCyMVpzXExe/KFNuJ66GitQqQfbZzxwqgJeWIMrM5M6LSA2
	2p7V01agm/LVz3KgEXK8oOXhANOJvOU7kSt0wNuDlk7WdVbeHV4dTmjav0mROjKI
	VadaKahvP4XV2vYj/EoJLGdsYbUqswOj2rQsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6EdwpAjNSOwWisnm6x5uTvD1ys3dvOP
	rypJfQfPJ01oTn2dLQBb9Nd/BEDEviDzXgkkYW+biaLsiakRnOAloSm/qj6yIqzO
	bz5GiluOEIwRXDCb1cfZeVDWK+IsKEvoQ4ZJCVbsA5PGCOsp2ZaKbGHqHriPbuvV
	Jx9nDxfE5Ak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A92D06922;
	Wed, 14 Mar 2012 13:29:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EA5D6921; Wed, 14 Mar 2012
 13:29:07 -0400 (EDT)
In-Reply-To: <CAHkcotgsU6XZCTB+YKKeVMsUC2Yr5pVoc7eJpxdyH-GcxzeTVw@mail.gmail.com> (Dmitry
 Potapov's message of "Wed, 14 Mar 2012 15:47:34 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33E4E632-6DFB-11E1-804B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193137>

Dmitry Potapov <dpotapov@gmail.com> writes:

> ... However, if I do
> "git push A ..." as you suggested then A will accumulate old garabage
> from B very quickly.

That is not a valid excuse, is it?
It only shows that lack of "push --prune A" is a problem to be solved.

And hasn't it been solved already?
