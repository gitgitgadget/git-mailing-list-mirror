From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 11:28:28 -0700
Message-ID: <7vli6lu65v.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
	<alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
	<CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
	<vpqhah9248u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1Ov-0003OH-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab3FGS2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:28:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298Ab3FGS2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:28:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E05A2659D;
	Fri,  7 Jun 2013 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0cdnhEE5k129pseBjXcsazRXU4=; b=pekOHv
	5lGyTqvDr57CuSzy72k8A4xOWDxhBuN4Io7jll6VBwJCP40zuIryQhF6o5rZFbwe
	TRUdun+4xD+bkBh5bSFFdrTRK+gAGZc+E19bMu33bVrd1dhQxmVE4q9m8n0o5dyc
	tx7E8THJ8kwf2nPpyueubxfhYoeeg77buXe8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0cbeKDJGetOjwhUwdzVEA/4M2gjK5pZ
	ON1PTfIL6oHxd1JWve6xpVpjw/IAzlOQJhMBN13cz2iz//K84R2sJm8KNMKRrUH8
	AsOKWMDi9oA/i9t2j4PuCgPxlxSvFYVuKmXjPBxtRkG5BrEP8WYcpCXT2/kqafga
	s4niRw9YnJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC9B2659C;
	Fri,  7 Jun 2013 18:28:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ACC726595;
	Fri,  7 Jun 2013 18:28:30 +0000 (UTC)
In-Reply-To: <vpqhah9248u.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	07 Jun 2013 19:57:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DA6C3CA-CFA0-11E2-A209-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226660>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The POSIX guys shouldn't move faster than the Windows guys can follow.

That is a very good summary.

It does not mean everybody must always crawl at the same pace as the
slowest people.  But it is one of the important things we should
consider, when we have choices to make (e.g. "do we write this in
Python", "do we write it using this Perl module we haven't depended
on", etc.), to pick the one that does not make others work harder
than necessary---it affects the trade-offs.
