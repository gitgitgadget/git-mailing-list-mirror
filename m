From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: prettify fatal messages
Date: Tue, 15 Nov 2011 17:05:33 -0800
Message-ID: <7vvcqkswpu.fsf@alter.siamese.dyndns.org>
References: <1321349492-5653-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 02:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQTwd-0006fv-8P
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 02:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772Ab1KPBFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 20:05:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756943Ab1KPBFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 20:05:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5E3A5767;
	Tue, 15 Nov 2011 20:05:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4m431X2wf3V/mC+tZ9ecuD+HauY=; b=X7Cg6V
	hNmXmUu9iMAK11TGOPLuT4vLCQozZPRoMqqFEaYsoPuXutI0mc2TEVQ3/yEg6t39
	NpKqlEsvkQVe0tMaIvnRDePNaWQl7rfFDTflhhbKL+QQtVhjKzARbTSd69jblfoh
	P2WTfoeJmi5C2gvdz1RduoNrqnUYmymvdhRXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X8/ox/Cvc4+iXs1Vg0wg2O+TD/+FH+42
	tGAdVJuvpbfErXI+sb17g9gDASJfDETNJYDxxphibSo/F9t8TEZWQP+MVH8uwLBX
	eajC+7Ce5cbAd9YRSAfMF8AE68uNTLB5re1/GJAKgsm/Z2cb47iOUJxpR7rKn/UA
	ByEGJ7veFEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8EE5766;
	Tue, 15 Nov 2011 20:05:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 594AC5764; Tue, 15 Nov 2011
 20:05:35 -0500 (EST)
In-Reply-To: <1321349492-5653-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 15 Nov 2011 15:01:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16E88990-0FEF-11E1-AC73-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185502>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  Candidate for 'maint'?

Too minor to matter when 'master' is already at -rc2.

Thanks.
