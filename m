From: Junio C Hamano <gitster@pobox.com>
Subject: Re: displaying subtree merges
Date: Wed, 04 Apr 2012 14:27:25 -0700
Message-ID: <7vaa2r89xe.fsf@alter.siamese.dyndns.org>
References: <4F7C787A.6050905@in.waw.pl>
 <7vehs38arm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: "git\@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXjr-0006jK-Rk
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab2DDV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:27:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab2DDV12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:27:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6F1D3913;
	Wed,  4 Apr 2012 17:27:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WA9SqvEFL12a7zZGWdEkphRiYqY=; b=YsAQpD
	pvxTJLYxyPLeL9v6LpkP/yGHIUnCzhzVHXzDxqxxuNRX660FaNiLXt8DyFaeJ8at
	RKPeV2FKDJ/a1am2lufC8pA5W0igmg5g4sXeAAieeFTCDslsaegGs+LcrBDTByna
	0l4YYS4iR0vuRW5dQHg93OZUt8iX1u+GBJuiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mrBrv6T5b+0Y7MfpQckdsTs9wlJlEAFI
	V3R/QxThnBCEDWAZsaTThoRS/+VcjNJqPN3GZohzhc+lLKSDPqO8zdy00vT1ODBx
	Ki9yUZ2cx87EIuAZ5Ph7Ld2O+jMnR4qN+ikZoJRbHk3z1J/S4if6UUO2WygCDKn8
	Q9WWG3pg1PE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0F83912;
	Wed,  4 Apr 2012 17:27:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 602373911; Wed,  4 Apr 2012
 17:27:27 -0400 (EDT)
In-Reply-To: <7vehs38arm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Apr 2012 14:09:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA1D69BC-7E9C-11E1-AA64-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194744>

Junio C Hamano <gitster@pobox.com> writes:

> I am absolutely sure I wrote on how to look at gitk and gitweb part of the
> history on this list in the past few months, but my archive digging skill
> seems to be failing me today X-<.

It was http://thread.gmane.org/gmane.comp.version-control.git/190405/focus=190616
in case anybody cares.
