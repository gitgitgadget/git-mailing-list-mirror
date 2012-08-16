From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Wed, 15 Aug 2012 23:26:58 -0700
Message-ID: <7vehn72vyl.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
 <87sjbpa5m8.fsf@thomas.inf.ethz.ch>
 <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
 <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
 <7vipcj2w9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 08:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1tY1-00029D-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 08:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab2HPG1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 02:27:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab2HPG1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 02:27:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9D75695A;
	Thu, 16 Aug 2012 02:27:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MPjKx1s93FfQZel1qKJLHAM61O8=; b=mWmElJ
	GqmikIuIqXMUDN1tpA8YdhJ0ek7dwqSMgW/t3u3YnNxvlptjiMrwXRiktlPR3zv2
	tNK/lGTEukShFYZ3itm60mynzwfAxokxirIqjO6yb/O5/NthI98FxWjzgNb6fa7n
	DFgGaq2VfMCZm1f1THtr4qqGSGuGhmEorC2eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eRRr7e+EBE94DHjAAR4fSCGj//V5Augn
	OMNmuJpt6rlXooRF+yhrUrLxed3XUOWpbpcSjCqsKpE4M8Gs94EBRPMZpbG6j4GZ
	gicec/DZzQBFF2NHi97qJTrnGmPy0cilZDjFPSVz3k011ARpxqdn0KBjSX1ZlvOR
	OJ30Fx/xK8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95A0A6959;
	Thu, 16 Aug 2012 02:27:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1062A6947; Thu, 16 Aug 2012
 02:26:59 -0400 (EDT)
In-Reply-To: <7vipcj2w9f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Aug 2012 23:20:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62AB96B6-E76B-11E1-BF25-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We could remove it if you find it confusing.
>
> I think the original motivation that line was added was to help
> people who see "git log" (without any frills) output for the first
> time not to be alarmed when they see newer things first: "In
> general, the "time" flows from bottom to top", but the "time" in
> that sentence is not necessarily the timestamp of either committer
> nor author field.

Just to clarify, I am not defending the current wording that I did
not touch in my patch with the above.  I am just giving historical
background to help _other_ people (including you) to come up with a
better wording, as I do not think of a better replacement myself.
