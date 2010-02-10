From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: reword --thin description
Date: Wed, 10 Feb 2010 10:59:48 -0800
Message-ID: <7vsk98apcr.fsf@alter.siamese.dyndns.org>
References: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
 <alpine.LFD.2.00.1002101037300.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:00:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfHnB-0001uL-Q9
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab0BJS76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 13:59:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab0BJS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 13:59:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B6C398576;
	Wed, 10 Feb 2010 13:59:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J703Jz1uCfv0HrSvf+B+Hcz8YVc=; b=BDob3a
	I2lzi7r2mn0Q+myLwxcu6wnQMV+3uoIlXWH4NG0VvX0B6ql6A8nDm3JACX/7+8OC
	aRnyq4XQrmqsyP+3PbZNAgigFZ2sMxJuhLfTj9+JavlhYODf2Fxf1a2WE6uDcaHO
	G6lfy788elXI72G3A9NKVgimLSnflW6ors10M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tt0QiQOVmYoz0pGpXtIG27fA9z3ItqS5
	VLOdvbJIJRFY7SMJrKL5Lhn6Jb84dygiBJ8APXsmC3lTeDPkgFWFKu+OE5Zxpehq
	2js2Oj82uEWMFvSHXwNVzRT5RYISeDy5hwc1Zc0ca1zYSmwmlyXxHxZy1lX4aSjJ
	q07ZWkLSvJQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D339856B;
	Wed, 10 Feb 2010 13:59:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 568A89856A; Wed, 10 Feb
 2010 13:59:50 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002101037300.1681@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 10 Feb 2010 11\:07\:09 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 793E32BC-1676-11DF-9B9F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139532>

Nicolas Pitre <nico@fluxnic.net> writes:

> ....  But --thin turned 
> out to be re-enabled by default for pushes by mistake on a few occasions 
> when the affected code has been reworked.  No idea what state it is now, 
> and I don't think that makes such a difference on the server in the end.

Hmmmm... it's doubly bad that the maintainer does not recall these
few occasions that mistakes happened.
