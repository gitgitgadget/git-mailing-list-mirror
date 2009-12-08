From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Mon, 07 Dec 2009 23:53:19 -0800
Message-ID: <7v638hlx5c.fsf@alter.siamese.dyndns.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
 <20091208060109.GB9951@coredump.intra.peff.net>
 <7v3a3lorge.fsf@alter.siamese.dyndns.org>
 <20091208074935.GB12049@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:53:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHut6-0005uy-Dc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbZLHHx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZLHHxZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:53:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbZLHHxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:53:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7358A4E94;
	Tue,  8 Dec 2009 02:53:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4x0nB0bGpGpdbpsBxsApWZM7U+w=; b=Jrb9mx
	GKFHtYqyzLqTGhPJ3QUjEMK8Yay2uaqBXjQdDQ8G2sX6jgfYTXhlOp4Y2lSoDpNn
	pP38ULA1xT+nNsUy26TYxpjWrQy8JIK7LhrEIjPobnjPDlp1pWFaprD7Jy0U71Ns
	Ys3hYjH+0uj+6nz+mZBQQrLfhULmqmJ+jRNF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EpmdYqdP0gohuZBLqvjR9TUL90781gYx
	QhaEfBePIWEsyi5prEXQ2tQu4BeGkD2cgsT75CGJyc78sR7UmmT9H2BmwIhIrs+b
	5jm4i1izts8p6bp+nJvobj1Nve3ILuP34mj4vjkEUr/80rJnUaMBcZA8xWCAUOuJ
	8fMs1p81hSQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 782FEA4E93;
	Tue,  8 Dec 2009 02:53:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 367BEA4E91; Tue,  8 Dec 2009
 02:53:20 -0500 (EST)
In-Reply-To: <20091208074935.GB12049@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 8 Dec 2009 02\:49\:35 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3BE3B00-E3CE-11DE-8256-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134833>

Jeff King <peff@peff.net> writes:

> OK, here it is with the test and an amended commit message. You could
> almost do an [e]dit on this and delete the "deleted" line, but you have
> no way of fixing up the "+++ /dev/null" line. For now, we have
> disabled [e]dit entirely for non-content hunks, so at least you cannot
> get yourself into trouble creating a broken patch. :)

;-)

Thanks.
