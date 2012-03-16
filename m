From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 15:10:24 -0700
Message-ID: <7vpqccdwof.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org> <20120316214151.GA25092@ecki>
 <7v1uosfc0p.fsf@alter.siamese.dyndns.org> <20120316220117.GA25624@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 16 23:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8fM8-0003kN-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 23:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759Ab2CPWKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 18:10:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758251Ab2CPWK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 18:10:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3AE1646B;
	Fri, 16 Mar 2012 18:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kI8Ljh0lwztqCKhQ6GvmJ6hS8RQ=; b=MtZW7M
	ECnMg3azcj9Q7YuyEKPVFq0xx2w6tVmkdB8tqoBQjcq1Z8TSorZCg2WLHV/X9hMq
	dTEeOnMRNvuVGwq5DoKzzMltX91rCwdsA4+WY0cQvXKMqaceRNCJXGMhmrX8KDwh
	9wGE2IZWNhQK7oE+JHJ6bYXIp1tszcJdRBsnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVa4fQQFYUZrsjIlhRIjucjvGlM0QTIj
	Ri1y7Ik78uxSd383U9IqcgxG1ioza3Fj/4wqQ6QuBRmDnv8bcjC01SsuY8FkCcWh
	lYrGGAlgWX0+W0/DspOai8HG+RPgORNifMiG2NUSP+5nrA+J4JnLcdpESZUzbSlP
	5WmNlwPRT90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BBF16469;
	Fri, 16 Mar 2012 18:10:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DEB56467; Fri, 16 Mar 2012
 18:10:26 -0400 (EDT)
In-Reply-To: <20120316220117.GA25624@ecki> (Clemens Buchacher's message of
 "Fri, 16 Mar 2012 23:01:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D54EF908-6FB4-11E1-8B21-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193288>

Clemens Buchacher <drizzd@aon.at> writes:

> I am afraid we are still not talking about the same thing...

Then I give up and shut up, at least for now, as it would not help you if
I rephrase what I said in a different way.

It's your turn to try explaining what is different better.
